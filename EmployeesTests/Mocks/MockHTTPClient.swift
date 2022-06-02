import Foundation
import SwiftNetworking

struct MockHTTPClient: HTTPClient {
  private let result: (URLRequest) -> HTTPResult
  
  private struct MockTask: Task {
    func suspend() {}
    func resume() {}
    func cancel() {}
  }
  
  init(result: @escaping (URLRequest) -> HTTPResult) {
    self.result = result
  }
  
  func send(_ request: URLRequest, completionHandler: @escaping (HTTPResult) -> Void) -> Task {
    completionHandler(result(request))
    return MockTask()
  }
}
