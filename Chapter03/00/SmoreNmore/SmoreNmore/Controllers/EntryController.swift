import Combine

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entries: [Entry] = []
  @Published private(set) var entries2: [Entry] = []
  @Published private(set) var entryPairs: [EntryPair] = []
  
  private let plain = AutoEntryVendor(delay: 2.0)
  
  init() {
    Task {
      await listenForEntries()
    }
  }
}

extension EntryController {
  private func listenForEntries() async {
    for await entry in plain.entries {
      entries.append(entry)
    }
  }
}
