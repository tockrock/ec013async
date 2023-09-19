import Foundation

class NotificationReceiver {
  let notifications = NotificationCenter.default
    .notifications(named: NextNumberNotification.name)
  
  var entries: AsyncMapSequence<AsyncCompactMapSequence<AsyncCompactMapSequence<NotificationCenter.Notifications, [AnyHashable : Any]>, Int>, Entry> {
   notifications
    .compactMap(\.userInfo)
    .compactMap { dictionary in
      dictionary[NextNumberNotification.numberKey] as? Int
    }
    .map { number in Entry(number: number) }
  }
}
