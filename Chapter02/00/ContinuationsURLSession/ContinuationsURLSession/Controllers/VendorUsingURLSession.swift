import Foundation

class VendorUsingURLSession {
}

extension VendorUsingURLSession {
  @MainActor
  func selectRandomNumber(with completion:
                          @escaping (Int?, Error?) -> Void) {
    URLSession.shared
      .dataTask(with: URLConstants.intURL) { data, _, error in
        if let data,
           let string = String(data: data, encoding: .utf8),
           let number = Int(string) {
          completion(number, nil)
        } else {
          completion(nil, error)
        }
      }
      .resume()
  }
}
