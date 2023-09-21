import AsyncAlgorithms
import Combine

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entries: [Entry] = []
  @Published private(set) var entryPairs: [EntryPair] = []
  
  private let plain = AutoEntryVendor(delay: 2.0)
  private let filled = AutoEntryVendor(delay: 1.5, isFilled: true)
  
  init() {
    Task {
      await listenForEntries()
    }
  }
}

extension EntryController {
  private func listenForEntries() async {
    for await entry in merge(plain.entries, filled.entries
                                            .throttle(for: .seconds(2.0))) {
      entries.append(entry)
    }
  }
}
