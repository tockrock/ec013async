import Combine

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entries: [Entry] = []
  private let receiver = NotificationReceiver()
  
  init() {
    let sequence = [7, 4, nil, 9, 1, nil, 2, 6]
      .dropFirst()
      .compactMap { $0 }
      .sorted()
      .filter { $0.isMultiple(of: 2) }
      .map { Entry(number: $0) }
      .map(\.imageName)
    print(sequence)
    
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
    NotificationPoster.shared.selectNextNumber()
  }
}
