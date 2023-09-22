struct NumberVendor {
  let delay: Double
  
  func randomNumber() async -> Int {
    do {
      try await Task.sleep(for: .seconds(delay))
    } catch {
      print("\(delay) task \(error)")
      return 0
    }
    return Int.random(in: 1...50)
  }
}

