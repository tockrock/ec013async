import ClosureSupport

class ClosureWrapper {
  let vendor = ClosureBasedVendor()
  
}

extension ClosureWrapper {
  func randomNumber() async -> (Int, Bool) {
    return await withCheckedContinuation { continuation in
      vendor.selectRandomNumber { number, isGreater in
        continuation.resume(returning: (number, isGreater))
      }
    }
  }
}
