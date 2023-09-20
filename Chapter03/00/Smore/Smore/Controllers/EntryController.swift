import Combine

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entries: [Entry] = []
  private let receiver = CombineReceiver()
  
  init() {
    Task {
      await listenForEntries()
    }
  }
}

extension EntryController {
  private func example() {
    let ints = [1, 2, 3, 4]
    var iterator = ints.makeIterator()
    
    while let int = iterator.next() {
      print(int)
    }
  }
  
  private func listenForEntries() async {
    for await entry in receiver.entries {
      entries.append(entry)
    }
  }
}

extension EntryController {
  func nextEntry() {
    StreamProvider.shared.selectNextNumber()
  }
}
