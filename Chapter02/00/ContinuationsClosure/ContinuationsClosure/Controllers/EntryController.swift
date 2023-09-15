import Foundation
import ClosureSupport

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry: Entry = blankEntry()
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
