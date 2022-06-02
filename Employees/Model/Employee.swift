import Foundation

struct Employee: Decodable {
  let uuid: UUID
  let fullName: String
  let phoneNumber: String?
  let emailAddress: String
  let biography: String?
  let photoUrlSmall: URL?
  let photoUrlLarge: URL?
  let team: String
  let employeeType: EmployeeType
}

enum EmployeeType: String, Decodable {
  case fullTime = "FULL_TIME"
  case partTime = "PART_TIME"
  case contractor = "CONTRACTOR"
  case undefined
  
  init(from decoder: Decoder) throws {
    let rawValue = try decoder.singleValueContainer().decode(String.self)
    self = .init(rawValue: rawValue) ?? .undefined
    if self == .undefined {
      debugPrint("The type returned from the server (\(rawValue)) is not known to the client. Please reach out to the server side team to implement.")
    }
  }
  
  var title: String? {
    switch self {
      case .fullTime: return "Full Time"
      case .partTime: return "Part Time"
      case .contractor: return "Contractor"
      case .undefined: return nil
    }
  }
}

extension Employee: Identifiable {
  var id: UUID { uuid }
}
