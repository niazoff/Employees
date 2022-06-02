import Foundation

struct MockEmployeesGetter: EmployeesGetter {
  private let employees: [Employee]
  
  init(employees: [Employee]) {
    self.employees = employees
  }
  
  func getEmployees(_ responseType: EmployeesResponseType) async throws -> [Employee] {
    employees
  }
}
