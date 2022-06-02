import Foundation
import Combine
import SwiftNetworking

final class EmployeesViewModel: ObservableObject {
  private let getter: EmployeesGetter
  private let client: HTTPClient
  
  @Published var employeeViewModels: LoadingState<[EmployeeGridItemViewModel]> = .idle
  
  init(getter: EmployeesGetter, client: HTTPClient) {
    self.getter = getter
    self.client = client
  }
  
  @MainActor func loadEmployees(responseType: EmployeesResponseType = .normal) async {
    employeeViewModels = .loading
    do {
      employeeViewModels = try await .value(getter.getEmployees(responseType)
        .sorted { $0.fullName < $1.fullName }
        .map { .init(employee: $0, client: client) })
    } catch { employeeViewModels = .error; debugPrint(error) }
  }
}
