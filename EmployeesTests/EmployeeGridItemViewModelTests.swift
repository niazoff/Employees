import XCTest

class EmployeeGridItemViewModelTests: XCTestCase {
  private let employee = Employee(uuid: .init(), fullName: "Jack Dorsey", phoneNumber: "0123456789", emailAddress: "jack@square.com", biography: nil, photoUrlSmall: .init(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/f8fc3c8e-b8ed-41d8-9005-537cf657c169/small.jpg"), photoUrlLarge: nil, team: "Core", employeeType: .fullTime)
  
  func testProperties() {
    let client = MockHTTPClient { _ in .success(.init(statusCode: 200, data: .init())) }
    let viewModel = EmployeeGridItemViewModel(employee: employee, client: client)
    XCTAssert(viewModel.title == employee.fullName)
    XCTAssert(viewModel.subtitle1 == employee.team)
    XCTAssert(viewModel.subtitle2 == employee.employeeType.title)
    XCTAssert(viewModel.phoneURL == .init(string: "tel:0123456789"))
    XCTAssert(viewModel.emailURL == .init(string: "mailto:jack@square.com"))
  }
  
  func testLoadImage() async throws {
    guard let data = try Bundle(for: Self.self).url(forResource: "jack", withExtension: "jpg")
      .map({ try Data(contentsOf: $0) }) else { preconditionFailure() }
    let client = MockHTTPClient { _ in .success(.init(statusCode: 200, data: data)) }
    let viewModel = EmployeeGridItemViewModel(employee: employee, client: client)
    await viewModel.loadImage()
    guard case let .value(viewModelData) = viewModel.image else { XCTFail(); return }
    XCTAssert(viewModelData == data)
  }
}
