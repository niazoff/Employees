enum EmployeesResponseType {
  case normal, malformed, empty
}

protocol EmployeesGetter {
  func getEmployees(_ responseType: EmployeesResponseType) async throws -> [Employee]
}
