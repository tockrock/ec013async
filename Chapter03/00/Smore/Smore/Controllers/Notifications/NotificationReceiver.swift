import Foundation

class NotificationReceiver {
  let notifications = NotificationCenter.default
    .notifications(named: NextNumberNotification.name)
  
  var entries: AsyncStream<Entry> {
    AsyncStream(Entry.self) { contiunation in
      Task {
        for await notification in notifications {
          if let userInfo = notification.userInfo,
             let number = userInfo[NextNumberNotification.numberKey] as? Int {
            contiunation.yield(Entry(number: number))
          }
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
