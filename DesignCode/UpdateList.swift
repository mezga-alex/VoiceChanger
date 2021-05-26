import SwiftUI

struct VoicesHistoryList: View {

   var updates = updateData
   @ObservedObject var store = UpdateStore(updates: updateData)

   func addUpdate() {
      store.updates.append(Update(image: "Certificate1", title: "New Title", text: "New Text", date: "JUL 1"))
   }

   func move(from source: IndexSet, to destination: Int) {
      store.updates.swapAt(source.first!, destination)
   }

   var body: some View {
      NavigationView {
         List {
            ForEach(store.updates) { item in
               NavigationLink(destination: UpdateDetail(title: item.title, text: item.text, image: item.image)) {
                  HStack(spacing: 12.0) {
                     Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .background(Color("background"))
                        .cornerRadius(20)

                     VStack(alignment: .leading) {
                        Text(item.title)
                           .font(.headline)

                        Text(item.text)
                           .lineLimit(2)
                           .lineSpacing(4)
                           .font(.subheadline)
                           .frame(height: 50.0)

                        Text(item.date)
                           .font(.caption)
                           .fontWeight(.bold)
                           .foregroundColor(.gray)
                     }
                  }
               }
               .padding(.vertical, 8.0)
            }
            .onDelete { index in
               self.store.updates.remove(at: index.first!)
            }
            .onMove(perform: move)
         }
         .navigationBarTitle(Text("History"))
         .navigationBarItems(
            trailing: EditButton()
         )
      }
   }
}

#if DEBUG
struct VoicesHistoryList_Previews: PreviewProvider {
   static var previews: some View {
    VoicesHistoryList()
   }
}
#endif

struct Update: Identifiable {
   var id = UUID()
   var image: String
   var title: String
   var text: String
   var date: String
}

let updateData = [
   Update(image: "Illustration1", title: "Mila", text: "Меня зовут Мила и я озвучиваю этот текст.", date: "MAY 23"),
   Update(image: "Illustration2", title: "Dina", text: "Привет, меня зовут Дина.", date: "JMAY 23"),
   Update(image: "Illustration3", title: "Tisha", text: "Здравствуйте, Илья Витальевич! Меня зовут Тихон.", date: "MAY 23"),
   Update(image: "Illustration4", title: "Tina", text: "Этот текст был озвучен Тиной.", date: "MAY 23"),
]
