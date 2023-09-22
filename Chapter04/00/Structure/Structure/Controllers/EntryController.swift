import Combine

class EntryController: ObservableObject {
  @Published private(set) var plainEntry: Entry?
  @Published private(set) var filledEntry: Entry?
  @Published private(set) var comparison: Comparison?
  
  private let plain = NumberVendor(delay: 2.0)
  private let filled = NumberVendor(delay: 1.5)
}

extension EntryController {
  func nextPair() {
  }
}

