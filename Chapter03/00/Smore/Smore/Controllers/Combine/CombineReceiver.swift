import Foundation

class CombineReceiver {
  let entries
  = IntPublisher.shared
    .$count
    .values
    .dropFirst()
    .map {number in
      Entry(number: number)
    }
}
