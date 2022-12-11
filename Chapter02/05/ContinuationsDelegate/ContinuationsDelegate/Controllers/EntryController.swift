import Foundation

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry: Entry = blankEntry()
  @Published private(set) var isUpdating = false
  @Published private(set) var delta = "..."
  let suffix = ".circle"
  private let wrapper = DelegateWrapper()
}

extension EntryController {
  func next() {
    Task {
      let _ = await wrapper.requestRandomEntryNumber()
      isUpdating = true
      do {
        let result = try await wrapper.receiveRandomEntryNumber()
        entry = Entry(imageName: result.number.description + suffix)
        delta = result.delta.description
      } catch {
        entry = errorEntry()
        delta = ""
      }
      isUpdating = false
    }
  }
}
