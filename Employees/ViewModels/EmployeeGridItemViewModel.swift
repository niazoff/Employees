import Foundation
import Combine
import SwiftNetworking

final class EmployeeGridItemViewModel: ObservableObject, Identifiable {
  private let employee: Employee
  private let client: HTTPClient
  
  @Published var image: LoadingState<Data> = .idle
  
  var title: String { employee.fullName }
  var subtitle1: String { employee.team }
  var subtitle2: String? { employee.employeeType.title }
  
  var phoneURL: URL? { employee.phoneNumber.flatMap { .init(string: "tel:\($0)") } }
  var emailURL: URL? { .init(string: "mailto:\(employee.emailAddress)") }
  
  init(employee: Employee, client: HTTPClient) {
    self.employee = employee
    self.client = client
  }
  
  @MainActor func loadImage() async {
    guard let url = employee.photoUrlSmall else {
      image = .error
      return
    }
    image = .loading
    do { image = try await .value(client.response(from: url).data) }
    catch { image = .error; debugPrint(error) }
  }
}
