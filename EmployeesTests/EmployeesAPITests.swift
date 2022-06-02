import XCTest
@testable import Employees

class EmployeesAPITests: XCTestCase {
  func testGetEmployees() async throws {
    guard let data = try Bundle(for: Self.self).url(forResource: "mock_employees", withExtension: "json")
      .map({ try Data(contentsOf: $0) }) else { preconditionFailure() }
    let client = MockHTTPClient { _ in .success(.init(statusCode: 200, data: data)) }
    let employees = try await EmployeesAPI.Client(client: client).getEmployees(.normal)
    XCTAssert(employees.count == 11)
  }
}
