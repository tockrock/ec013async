import DelegateSupport

class DelegateWrapper {
  lazy private var numberVendor = DelegatingVendor(delegate: self)
}

extension DelegateWrapper: VendorDelegate {
  func randomEntryNumber() async -> Int {
    0
  }
  
  func vendorWillSelect(_ vendor: DelegatingVendor) {
  }
  
  func vendor(_ vendor: DelegatingVendor, didSelect number: Int) {
  }
}
