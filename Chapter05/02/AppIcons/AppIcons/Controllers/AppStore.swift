import Foundation
import Combine
import UIKit.UIImage

@MainActor
class AppStore: ObservableObject {
  @Published private(set) var apps = [AppInfo]()
  @Published private(set) var images = [String: UIImage]()
  private var downloadTask: Task<Void, Never>? {
    willSet {
      resetForNewSearch()
    }
  }
}

extension AppStore {
  func search(for rawText: String) {
    downloadTask = Task {
      do {
        apps = try await retrieveApps(for: rawText)
        ProgressMonitor.shared.resetTotal(to: apps.count)
        try await retrieveImages()
      } catch {
        print(error)
      }
    }
  }
}

extension AppStore {
  private func retrieveApps(for rawText: String) async throws -> [AppInfo] {
    let (data, _)
    = try await ephemeralURLSession
      .data(from: url(for: rawText))
    let searchResults
    = try JSONDecoder().decode(SearchResults.self,
                               from: data)
    return searchResults.apps
  }
}

extension AppStore {
  private func retrieveImages() async throws {
    try await withThrowingTaskGroup(of: (UIImage?,
                                         String).self) { group in
      for app in apps {
        group.addTask {
          async let (imageData, _)
          = ephemeralURLSession
            .data(from: app.artworkURL)
          let image = UIImage(data: try await imageData)
          return (image, app.name)
        }
      }
      for try await (image, name) in group {
        ProgressMonitor.shared.registerCompletedDownload()
        publish(image: image,
                forAppNamed: name)
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
  private func resetForNewSearch() {
    downloadTask?.cancel()
    apps.removeAll()
    images.removeAll()
  }
}
