class ClosureBasedVendor {
  private var number = 0
}

extension ClosureBasedVendor {
  @MainActor
  func selectRandomNumber(with completion: @escaping (Int, Bool) -> Void) {
    Task {
      let (number, isGreater) = await selectRandomNumber()
      completion(number, isGreater)
    }
  }
  
  func selectRandomNumber() async -> (Int, Bool) {
    let numberBeforeChange = number
    try? await Task.sleep(for: .seconds(0.5))
    number = Int.random(in: 1...50)
    let isGreater = number > numberBeforeChange
    return (number, isGreater)
  }
}
