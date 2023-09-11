import DelegateSupport

class DelegateWrapper {
  lazy private var numberVendor = DelegatingVendor(delegate: self)
  var requestContinuation: UnsafeContinuation<Void, Never>?
  var receiveContinuation: UnsafeContinuation<(Int, Int), Never>?
}

extension DelegateWrapper {
  @MainActor
  func requestRandomEntryNumber() async {
    await withUnsafeContinuation { continuation in
      requestContinuation = continuation
      numberVendor.selectRandomNumber()
    }
  }
  
  @MainActor
  func receiveRandomEntryNumber() async -> (number: Int, delta: Int) {
    await withUnsafeContinuation { continuation in
      receiveContinuation = continuation
    }
  }
}

extension DelegateWrapper: VendorDelegate {
  func vendorWillSelect(_ vendor: DelegatingVendor) {
    requestContinuation?.resume(returning: ())
    requestContinuation = nil
  }
  
  func vendor(_ vendor: DelegatingVendor, didSelect number: Int) {
    receiveContinuation?.resume(returning: (number, vendor.delta))
    receiveContinuation = nil
  }
}
