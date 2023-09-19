import Foundation

class NotificationReceiver {
  let notifications = NotificationCenter.default
    .notifications(named: NextNumberNotification.name)
  
  var entries: AsyncStream<Entry> {
    AsyncStream(Entry.self) { contiunation in
      Task {
        let asyncSequence = notifications
          .compactMap(\.userInfo)
          .compactMap { dictionary in
            dictionary[NextNumberNotification.numberKey] as? Int
          }
          .map { number in Entry(number: number) }
        
        for await entry in asyncSequence {
          contiunation.yield(entry)
        }
      }
    }
  }
  
  func receiveNumbers(with completion: @escaping (Int) -> Void) {
    NotificationCenter
      .default
      .addObserver(forName: NextNumberNotification.name,
                   object: nil,
                   queue: nil) { notification in
        if let userInfo = notification.userInfo,
           let number = userInfo[NextNumberNotification.numberKey] as? Int {
          completion(number)
        }
      }
  }
}
