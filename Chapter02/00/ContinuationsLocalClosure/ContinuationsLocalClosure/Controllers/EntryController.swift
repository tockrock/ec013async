import Foundation

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry = blankEntry()
  @Published private(set) var isUpdating = false
  @Published private(set) var delta = "..."
  let suffix = ".circle"
  private let vendor = ClosureBasedVendor()
}

extension EntryController {
  func next() {
    isUpdating = true
    vendor.selectRandomNumber { number, isGreater in
      self.entry = Entry(imageName: number.description + self.suffix)
      self.delta = isGreater ? "+" : "-"
      self.isUpdating = false
    }
  }
}

extension EntryController {
  func vendorWillSelect() {
    isUpdating = true
  }
  
  func vendor(didSelect number: Int,
              isGreater: Bool) {
    entry = Entry(imageName: number.description + suffix)
    delta = isGreater ? "+" : "-"
    isUpdating = false
  }
}
