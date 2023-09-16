import Foundation

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry: Entry = blankEntry()
  @Published private(set) var isUpdating = false
  let suffix = ".circle"
  private let vendor = VendorUsingURLSession()
}

extension EntryController {
  func next() {
    isUpdating = true
    vendor.selectRandomNumber { number, error in
      if let number {
        self.entry = Entry(imageName: number.description + self.suffix)
      } else {
        print(error?.localizedDescription ?? "error is nil")
        self.entry = errorEntry()
      }
      self.isUpdating = false
    }
  }
}

