import SwiftUI

struct UpdateDetail: View {

   var title = "SwiftUI"
   var text = "Loading..."
   var image = "Illustration1"
    @ObservedObject private var speechRec = SpeechRec()

   var body: some View {
      VStack(spacing: 20.0) {
         Text(title)
            .font(.largeTitle)
            .fontWeight(.heavy)

         Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 200)

         Text(text)
            .lineLimit(nil)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .font(.largeTitle)
            .padding()
        
         Spacer()
        
        Button(action: {
            self.speechRec.recognizedText = text
            print("Send to server")
            self.speechRec.sendText(voice: title)
        }) {
            Text("Generate speech")
                .foregroundColor(.white)
        }
        .frame(width: 300, height: 40)
        .background(Color("background3"), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .cornerRadius(30)
        .shadow(color: Color("backgroundShadow3"), radius: 20, x: 0, y: 20)
        .padding(.bottom, 20)
        
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
      }
      .padding(30.0)
   }
}

#if DEBUG
struct UpdateDetail_Previews: PreviewProvider {
   static var previews: some View {
      UpdateDetail()
   }
}
#endif
