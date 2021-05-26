import SwiftUI


struct TabBar: View {
   var body: some View {
      TabView {
         Home().tabItem {
            Text("Home")
         }
         .tag(1)
         ContentView().tabItem {
            Text("Certificates")
         }
         .tag(2)
     
      }
      .edgesIgnoringSafeArea(.top)
   }
}

#if DEBUG
struct TabBar_Previews: PreviewProvider {
   static var previews: some View {
      TabBar()
//         .environment(\.colorScheme, .dark)
   }
}
#endif
