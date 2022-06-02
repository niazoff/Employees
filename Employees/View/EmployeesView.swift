import SwiftUI

struct EmployeesView: View {
  @StateObject var viewModel: EmployeesViewModel
  
  var body: some View {
    NavigationView {
      Group {
        switch viewModel.employeeViewModels {
          case .idle, .loading: ProgressView()
          case .value(let viewModels):
            if viewModels.isEmpty {
              VStack {
                Image(systemSymbol: .personTextRectangle).font(.title)
                Text("Add an employee to view\ntheir details here.")
                  .fontWeight(.medium)
                  .multilineTextAlignment(.center)
                  .padding(.top, 4)
              }.foregroundColor(.gray).padding()
            } else {
              ScrollView {
                LazyVGrid(columns: .init(repeating: .init(.flexible(minimum: 50, maximum: .infinity), spacing: 15), count: 2), spacing: 15) {
                  ForEach(viewModels) {
                    EmployeeGridItemView(viewModel: $0)
                  }
                }.padding(15)
              }
            }
          case .error:
            VStack {
              Image(systemSymbol: .exclamationmarkTriangle).font(.title)
              Text("Uh oh!\nAn error occured.\nPlease tap here to retry.")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
            }.foregroundColor(.gray)
              .padding().onTapGesture {
                AsyncTask { await viewModel.loadEmployees() }
              }
        }
      }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemGray5))
        .navigationTitle("Employees")
        .toolbar {
          Button {
            AsyncTask { await viewModel.loadEmployees() }
          } label: { Image(systemSymbol: .arrowClockwise) }
        }.accentColor(.init(.primary))
    }.task { await viewModel.loadEmployees() }
  }
}
