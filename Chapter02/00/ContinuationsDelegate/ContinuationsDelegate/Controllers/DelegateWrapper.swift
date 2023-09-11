import DelegateSupport

class DelegateWrapper {
  lazy private var numberVendor = DelegatingVendor(delegate: self)
  var numberContinuation: CheckedContinuation<Int, Never>?
}

extension DelegateWrapper: VendorDelegate {
  @MainActor
  func randomEntryNumber() async -> Int {
    await withCheckedContinuation { continuation in
      numberContinuation = continuation
      numberVendor.selectRandomNumber()
    }
  }
  
  func vendorWillSelect(_ vendor: DelegatingVendor) {
    numberContinuation?.resume(returning: 0)
  }
  
  func vendor(_ vendor: DelegatingVendor, didSelect number: Int) {
    numberContinuation?.resume(returning: number)
    numberContinuation = nil
  }
}
