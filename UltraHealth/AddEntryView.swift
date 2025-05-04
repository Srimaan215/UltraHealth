import SwiftUI

struct AddEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Add a new entry")
                    .font(.title)
                    .padding()
                
                // insert form later
                
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            .navigationTitle("Quick Add")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}
