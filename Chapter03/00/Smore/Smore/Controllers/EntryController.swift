import Combine

class EntryController: ObservableObject {
  @Published private(set) var entries: [Entry] = []
  private let receiver = NotificationReceiver()
  
  init() {
    Task {
      await listenForNumbers()
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
  
  private func listenForNumbers() async {
    for await notification in receiver.notifications {
      entries.append(Entry(number: Int.random(in: 1...50)))
      print(notification)
    }
  }
}

extension EntryController {
  func nextEntry() {
    NotificationPoster.shared.selectNextNumber()
  }
}
