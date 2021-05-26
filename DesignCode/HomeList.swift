import SwiftUI

struct HomeList: View {

   var courses = coursesData
    @State private var selectedVoice = ""
    @State var showContent = false

   var body: some View {
         VStack {
            HStack {
               VStack(alignment: .leading) {
                  Text("Voice Changer")
                     .font(.largeTitle)
                     .fontWeight(.heavy)

                  Text("By Alex Mezga & Art Poltavsky")
                     .foregroundColor(.gray)
               }
               Spacer()
            }
            .padding(.leading, 30.0)
            
            ScrollView(.horizontal, showsIndicators: false) {
               HStack(spacing: 30.0) {
                  ForEach(courses) { item in
                     Button(action: {
                        self.showContent.toggle()
                        self.selectedVoice = item.title
                     }) {
                        GeometryReader { geometry in
                           VoiceView(title: item.title,
                                      image: item.image,
                                      color: item.color,
                                      shadowColor: item.shadowColor)
                              .rotation3DEffect(Angle(degrees:
                                 Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                              .sheet(isPresented: self.$showContent) {
                                ContentView(selectedVoice: !self.selectedVoice.isEmpty ? self.selectedVoice : item.title)
                              }
                        }
                        .frame(width: 256, height: 410)
                     }
                  }
               }
               .padding(.leading, 30)
               .padding(.top, 40)
               .padding(.bottom, 70)
               Spacer()
            }
            .padding(.top, 80)
            
//            CertificateRow()
         }
         .padding(.top, 78)
      }
   
}

#if DEBUG
struct HomeList_Previews: PreviewProvider {
   static var previews: some View {
      HomeList()
   }
}
#endif

struct VoiceView: View {

   var title = ""
   var image = ""
   var color = Color("")
   var shadowColor = Color("")

   var body: some View {
      return VStack(alignment: .leading) {
         Text(title)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(30)
            .lineLimit(4)

         Spacer()

         Image(image)
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(width: 256, height: 200)
            .padding(.bottom, 30)
      }
      .background(color)
      .cornerRadius(30)
      .frame(width: 256, height: 410)
      .shadow(color: shadowColor, radius: 20, x: 0, y: 20)
   }
}

struct Voice: Identifiable {
   var id = UUID()
   var title: String
   var image: String
   var color: Color
   var shadowColor: Color
}

let coursesData = [
    Voice(title: "Mila",
          image: "Illustration1",
          color: Color("background3"),
          shadowColor: Color("backgroundShadow3")),
    Voice(title: "Dina",
          image: "Illustration2",
          color: Color("background4"),
          shadowColor: Color("backgroundShadow4")),
    Voice(title: "Tisha",
          image: "Illustration3",
          color: Color("background7"),
          shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
    Voice(title: "Tina",
          image: "Illustration4",
          color: Color("background5"),
          shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
    Voice(title: "Pasha",
          image: "Illustration5",
          color: Color("background8"),
          shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
    Voice(title: "Nika",
           image: "Illustration6",
           color: Color("background10"),
           shadowColor: Color("backgroundShadow3")),
]
