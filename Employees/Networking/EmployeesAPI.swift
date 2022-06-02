import Foundation
import SwiftNetworking

enum EmployeesAPI {}

extension EmployeesAPI {
  final class Client: EmployeesGetter {
    private let server = HTTPServer(host: "s3.amazonaws.com")
    private let client: HTTPClient
    
    private lazy var employeesDecoder: JSONDecoder = {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      return decoder
    }()
    
    init(client: HTTPClient) {
      self.client = client
    }
    
    func getEmployees(_ responseType: EmployeesResponseType) async throws -> [Employee] {
      let request = createRequest(.employees(responseType))
      let response = try await client.response(from: request)
      return try employeesDecoder.decode(EmployeesResponse.self, from: response.data).employees
    }
    
    private func createRequest(_ endpoint: Endpoint) -> URLRequest {
      guard let request = URLRequest(server: server, endpoint: endpoint, queryItems: [])
      else { preconditionFailure() }
      return request
    }
  }
}

private extension EmployeesAPI {
  enum Endpoint: HTTPEndpoint {
    case employees(EmployeesResponseType)
    
    var endpoint: (HTTPMethod, URLPath) {
      switch self {
        case let .employees(type): return (.GET, "/sq-mobile-interview/\(type.fileName)")
      }
    }
  }
}

private extension EmployeesResponseType {
  var fileName: String {
    switch self {
      case .normal: return "employees.json"
      case .malformed: return "employees_malformed.json"
      case .empty: return "employees_empty.json"
    }
  }
}

private struct EmployeesResponse: Decodable {
  let employees: [Employee]
}
