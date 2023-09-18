import Foundation

class NotificationReceiver {
  func registerForNotification() {
    NotificationCenter
      .default
      .addObserver(forName: NextNumberNotification.name,
                   object: nil,
                   queue: nil) { notification in
        if let userInfo = notification.userInfo,
           let number = userInfo[NextNumberNotification.numberKey] as? Int {
          print("received", number)
        }
      }
  }
}
