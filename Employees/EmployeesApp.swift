import SwiftUI
import SFSafeSymbols

typealias AsyncTask = _Concurrency.Task

@main
struct EmployeesApp: App {
  private let urlSession: URLSession = {
    let configuration = URLSessionConfiguration.default
    let bytes = Int(Measurement(value: 1, unit: UnitInformationStorage.megabytes).converted(to: .bytes).value)
    configuration.urlCache = .init(memoryCapacity: 10 * bytes, diskCapacity: 500 * bytes)
    configuration.requestCachePolicy = .returnCacheDataElseLoad
    return .init(configuration: configuration)
  }()
  
  var body: some Scene {
    WindowGroup {
      EmployeesView(
        viewModel: EmployeesViewModel(
          getter: EmployeesAPI.Client(client: urlSession),
          client: urlSession
        )
      )
    }
  }
}

func debugPrint(_ message: String) {
  #if DEBUG
  print(message)
  #endif
}
