import Foundation
import Combine
import UIKit.UIImage

@MainActor
class AppStore: ObservableObject {
  @Published private(set) var apps = [AppInfo]()
  @Published private(set) var images = [String: UIImage]()
}

extension AppStore {
  func search(for rawText: String)  {
    Task {
      do {
        let (data, _) = try await ephemeralURLSession
          .data(from: url(for: rawText))
        let searchResults = try JSONDecoder()
          .decode(SearchResults.self, from: data)
        apps = searchResults.apps
        print(searchResults)
        try await retrieveImages()
      } catch {
        print(error)
      }
    }
  }
}

extension AppStore {
  private func publish(image: UIImage?,
                       forAppNamed name: String) {
    if let image {
      images[name] = image
    }
  }
}

extension AppStore {
  private func retrieveImages() async throws {
    for app in apps {
      async let (imageData, _) = ephemeralURLSession
        .data(from: app.artworkURL)
      let image = UIImage(data: try await imageData)
      publish(image: image,
              forAppNamed: app.name)
    }
  }
}
