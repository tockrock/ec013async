class StreamProvider {
  static let shared = StreamProvider()
  private var continuation: AsyncStream<Entry>.Continuation?
  
  private(set) var count = 0 {
    didSet {
      continuation?.yield(Entry(number: count))
    }
  }
  
  func selectNextNumber() {
    count = (count + 1) % 51
  }
}

extension StreamProvider {
  var entryStream: AsyncStream<Entry> {
    AsyncStream(Entry.self) { continuation in
      self.continuation = continuation
    }
  }
}
