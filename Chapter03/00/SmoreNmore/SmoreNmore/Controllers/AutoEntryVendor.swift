class AutoEntryVendor {
  let delay: Double
  let isFilled: Bool
  private var count = 0
  
  init(delay: Double,
       isFilled: Bool = false) {
    self.delay = delay
    self.isFilled = isFilled
  }
}

extension AutoEntryVendor {
  var entries: AsyncStream<Entry> {
    AsyncStream(Entry.self) { continuation in
      Task {
        while 10 > count {
          count += 1
          try? await Task.sleep(for: .seconds(delay))
          continuation.yield(Entry(number: count, isFilled: isFilled))
        }
        continuation.finish()
      }
    }
  }
}
