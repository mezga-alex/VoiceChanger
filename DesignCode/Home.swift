import SwiftUI

let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
let screen = UIScreen.main.bounds

struct Home: View {

   @State var show = false
   @State var showProfile = false

   var body: some View {
      ZStack(alignment: .top) {
         HomeList()
            .blur(radius: show ? 20 : 0)
            .scaleEffect(showProfile ? 0.95 : 1)
            .animation(.default)

         ContentView()
            .frame(minWidth: 0, maxWidth: 712)
            .cornerRadius(30)
            .shadow(radius: 20)
            .animation(.spring())
            .offset(y: showProfile ? statusBarHeight + 40 : UIScreen.main.bounds.height)
        
        VStack {
                HStack {
                    Spacer()
                    MenuRight(show: $showProfile)
                        .padding(.trailing, 8)
                }
            Spacer()
        }
        
         .offset(y: showProfile ? statusBarHeight : 80)
         .animation(.spring())

//         MenuView(show: $show)
      }
      .background(Color("background"))
      .edgesIgnoringSafeArea(.all)
   }
}

#if DEBUG
struct Home_Previews: PreviewProvider {
   static var previews: some View {
      Home()
         .previewDevice("iPhone X")
   }
}
#endif


struct CircleButton: View {
   var icon = "person.crop.circle"
   var body: some View {
      return HStack {
         Image(systemName: icon)
            .foregroundColor(.primary)
      }
      .frame(width: 44, height: 44)
      .background(Color("button"))
      .cornerRadius(30)
      .shadow(color: Color("buttonShadow"), radius: 20, x: 0, y: 20)
   }
}


struct MenuRight: View {

   @Binding var show: Bool
   @State var showUpdate = false

   var body: some View {
      return ZStack(alignment: .topTrailing) {
         HStack {
            Button(action: { self.showUpdate.toggle() }) {
               CircleButton(icon: "clock")
                  .sheet(isPresented: self.$showUpdate) { VoicesHistoryList() }
            }
         }
         Spacer()
      }
   }
}
