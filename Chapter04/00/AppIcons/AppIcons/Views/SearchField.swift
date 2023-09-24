import SwiftUI

struct SearchField {
  @Binding var apps: [AppInfo]
  @State private var searchTerm = ""
}

extension SearchField: View {
  var body: some View {
    TextField("Enter Search Term",
              text: $searchTerm)
    .onSubmit {
    }
    .multilineTextAlignment(.center)
    .textFieldStyle(RoundedBorderTextFieldStyle())
    .padding()
  }
}

struct SearchField_Previews: PreviewProvider {
  static var previews: some View {
    SearchField(apps: .constant([AppInfo]()))
  }
}
