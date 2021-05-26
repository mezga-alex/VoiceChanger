import SwiftUI

struct ContentView: View {
    var selectedVoice = "Default Mila"
    @ObservedObject private var speechRec = SpeechRec()
    @State private var show = false
    @State private var viewState = CGSize.zero
    
    var body: some View {
      ZStack {
        BlurView(style: .systemMaterial)

        VStack() {
            HStack {
               VStack(alignment: .leading) {
                Text(self.selectedVoice)
                     .font(.largeTitle)
                     .fontWeight(.heavy)

                  Text("By Alex Mezga & Art Poltavsky")
                     .foregroundColor(.gray)
               }
               Spacer()
            }
            .padding(.leading, 30.0)
            .padding(.top, 30)

            Spacer()
            
            if speechRec.recognizedText.isEmpty {
                Text("Поговорим?")
                    .font(.largeTitle)
                    .padding()
                Spacer()
            } else {
                Text(speechRec.recognizedText)
                    .font(.largeTitle)
                    .padding()
                Spacer()
            }
            
            if !speechRec.recognizedText.isEmpty {
                Button(action: {
                    print("Send to server")
                    self.speechRec.sendText(voice: selectedVoice)
                }) {
                    Text("Generate speech")
                        .foregroundColor(.white)
                }
                .frame(width: 300, height: 40)
                .background(Color("background3"), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(30)
                .shadow(color: Color("backgroundShadow3"), radius: 20, x: 0, y: 20)
                .padding(.bottom, 20)
            }
            if !speechRec.speechData.isEmpty {
                Button(action: {
                    print("playSpeech")
                    self.speechRec.playSpeech()
                }) {
                    Text("Play speech")
                        .foregroundColor(.white)
                }
                .frame(width: 300, height: 40)
                .background(Color("background3"), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(30)
                .shadow(color: Color("backgroundShadow3"), radius: 20, x: 0, y: 20)
                .padding(.bottom, 20)
            }
//            RecordButton(speechRec: self.speechRec)
            Button(action: {
                if self.speechRec.isRunning {
                    print("stop")
                    self.speechRec.stop()
                } else {
                    print("start")
                    self.speechRec.start()
                }
            }) {
                Text(self.speechRec.isRunning ? "Stop Dictation" : "Start Dictation")
                    .foregroundColor(.white)

            }
            .frame(width: 300, height: 40)
            .background(Color("background3"), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .cornerRadius(30)
            .shadow(color: Color("backgroundShadow3"), radius: 20, x: 0, y: 20)
            .padding(.bottom, 20)
        }
    }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}
#endif



struct TitleView: View {
    var title = "Default"

   var body: some View {
      return HStack {
        VStack(alignment: .leading) {
            Text(self.title)
              .font(.largeTitle)
              .fontWeight(.heavy)

           Text("By Alex Mezga & Art Poltavsky")
              .foregroundColor(.gray)
        }
        Spacer()
     }
     .padding(.leading, 30.0)
        
        
   }
}

