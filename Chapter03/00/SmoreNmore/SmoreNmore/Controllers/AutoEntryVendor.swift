import AsyncAlgorithms

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
      let timer = AsyncTimerSequence.repeating(every: .seconds(delay))
      continuation.onTermination = { termination in
        print("Stopped (is filled =", self.isFilled, ")", termination)
      }
      Task {
        for await _ in timer {
          if 20 > count {
            count += 1
            continuation.yield(Entry(number: count, isFilled: isFilled))
          } else {
            continuation.finish()
          }
        }
      }
    }
  }
}
