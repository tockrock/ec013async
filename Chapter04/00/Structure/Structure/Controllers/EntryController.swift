import Combine

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var plainEntry: Entry?
  @Published private(set) var filledEntry: Entry?
  @Published private(set) var comparison: Comparison?
  
  private let plain = NumberVendor(delay: 2.0)
  private let filled = NumberVendor(delay: 1.5)
  
  private var nextTask: Task<Void, Never>?
}

extension EntryController {
  func nextPair() {
    clear()
    nextTask = Task {
      async let plainNumber = plain.randomNumber()
      async let filledNumber = filled.randomNumber()

      comparison = Comparison(try await plainNumber, try await filledNumber)
      if Task.isCancelled { print("nextTask is cancelled") }
      filledEntry = Entry(number: try await filledNumber, isFilled: true)
      plainEntry = Entry(number: try await plainNumber)
    }
  }
}

extension EntryController {
  private func clear() {
    nextTask?.cancel()
    plainEntry = nil
    filledEntry = nil
    comparison = nil
  }
}
