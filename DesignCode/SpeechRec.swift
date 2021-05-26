//
//  SpeechRec.swift
//  SpeechToTextDemo
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Speech

class SpeechRec: ObservableObject {
    @Published var recognizedText = ""
    @Published private(set) var isRunning = false
    @Published private(set) var speechData = Data()
    @Published private(set) var avAudioPlayer = AVAudioPlayer()
    
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru-RU")) // Use Russian
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()

    func start() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.record)
            SFSpeechRecognizer.requestAuthorization { status in
                DispatchQueue.main.async {
                    self.startRecognition()
                }
            }
        } catch {
            print("AVAudioSession error")
        }
    }
    
    func startRecognition() {
        do {
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = recognitionRequest else { return }
            
            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
                if let result = result {
                    self.recognizedText = result.bestTranscription.formattedString
                }
            }
            
            let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
            audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                recognitionRequest.append(buffer)
            }
            
            audioEngine.prepare()
            try audioEngine.start()
            
            self.recognizedText = "Слушаю..."
            self.isRunning = true
        }
        
        catch {
            
        }
    }
    
    func stop() {
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
        recognitionRequest?.endAudio()
        self.isRunning = false
    }
    
    func sendText(voice: String) {
        let semaphore = DispatchSemaphore (value: 0)
        let parameters = "{\n  \"text\": \"\(self.recognizedText)\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "https://1789f9eadcf5.ngrok.io/speech?voice=\(voice)")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
            DispatchQueue.main.async {
                self.speechData = data
            }
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
    
    func playSpeech() {
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
            self.avAudioPlayer = try AVAudioPlayer(data: self.speechData)
            avAudioPlayer.prepareToPlay()
            avAudioPlayer.volume = 1
            avAudioPlayer.play()
        }catch{
            debugPrint(error)
        }
    }
}
