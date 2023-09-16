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
  
  func randomNumber() async throws -> Int {
    try await withCheckedThrowingContinuation { continuation in
      URLSession.shared
        .dataTask(with: URLConstants.intURL) { data, _, error in
          if let data,
             let string = String(data: data, encoding: .utf8),
             let number = Int(string) {
            continuation.resume(returning: number)
          } else {
            guard let error else {
              continuation.resume(throwing: UnexpectedDataFromServerError())
              return
            }
            continuation.resume(throwing: error)
          }
        }
        .resume()
    }
  }
}
