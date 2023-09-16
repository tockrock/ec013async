class VendorUsingURLSession {
}

extension VendorUsingURLSession {
  func selectRandomNumber(with completion:
                          @escaping (Int?, Error?) -> Void) {
    let number = Int.random(in: 1...50)
    if number.isMultiple(of: 5) {
      completion(nil, MultipleOfFiveError(number: number))
    } else {
      completion(number, nil)
    }
  }
}


