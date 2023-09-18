import Foundation

class NotificationReceiver {
  var numbers: AsyncStream<Int> {
    AsyncStream(Int.self) { contiunation in
      NotificationCenter
        .default
        .addObserver(forName: NextNumberNotification.name,
                     object: nil, queue: nil) { notification in
          if let userInfo = notification.userInfo,
             let number = userInfo[NextNumberNotification.numberKey] as? Int {
            contiunation.yield(number)
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
