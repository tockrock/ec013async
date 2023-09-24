import SwiftUI

struct AsyncImageGrid {
  let apps: [AppInfo]
  let columns = [GridItem(.adaptive(minimum: 60,
                                   maximum: 60))]
}

extension AsyncImageGrid: View {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(apps) { app in
          AsyncImage(url: app.artworkURL) { image in
            image
              .resizable()
              .scaledToFill()
          } placeholder: {
            ZStack {
              Image(systemName: "square.fill")
                .resizable()
                .scaledToFill()
                .foregroundColor(.secondary.opacity(0.2))
              ProgressView()
                .progressViewStyle(.circular)
            }
          }
        }
      }
    }
  }
}

struct AsyncImageGrid_Previews: PreviewProvider {
  static var previews: some View {
    AsyncImageGrid(apps: [AppInfo]())
  }
}
