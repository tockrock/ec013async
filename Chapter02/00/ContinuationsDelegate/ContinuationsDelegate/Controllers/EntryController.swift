import Foundation
import DelegateSupport

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry = blankEntry()
  @Published private(set) var isUpdating = false
  @Published private(set) var delta = "..."
  let suffix = ".circle"
  lazy private var numberVendor = DelegatingVendor(delegate: self)
}

extension EntryController {
  func next() {
  }
}

extension EntryController: VendorDelegate {
  func vendorWillSelect(_ vendor: DelegatingVendor) {
    <#code#>
  }
  
  func vendor(_ vendor: DelegatingVendor, didSelect number: Int) {
    <#code#>
  }
}
