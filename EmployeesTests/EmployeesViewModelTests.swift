import XCTest

class EmployeesViewModelTests: XCTestCase {
  func testLoadEmployees() async {
    let employee = Employee(uuid: .init(), fullName: "Jack Dorsey", phoneNumber: nil, emailAddress: "jack@square.com", biography: nil, photoUrlSmall: nil, photoUrlLarge: nil, team: "Core", employeeType: .fullTime)
    let getter = MockEmployeesGetter(employees: [employee])
    let client = MockHTTPClient { _ in .success(.init(statusCode: 200, data: .init())) }
    let viewModel = EmployeesViewModel(getter: getter, client: client)
    await viewModel.loadEmployees()
    guard case let .value(employeeViewModels) = viewModel.employeeViewModels else { XCTFail(); return }
    XCTAssert(employeeViewModels.count == 1)
  }
}
