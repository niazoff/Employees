import SwiftUI

struct EmployeeGridItemView: View {
  @ObservedObject var viewModel: EmployeeGridItemViewModel
  
  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        Color(UIColor.systemGray4)
        Group {
          switch viewModel.image {
            case .idle, .loading: Color.clear
            case let .value(data):
              UIImage(data: data).map {
                Image(uiImage: $0).resizable()
                  .aspectRatio(contentMode: .fill)
              }.transition(.opacity.animation(.easeInOut))
            case .error:
              Image(systemSymbol: .person)
                .font(.title)
                .foregroundColor(.gray)
          }
        }
      }.frame(maxWidth: .infinity, minHeight: 180, maxHeight: 180).clipped()
      VStack(spacing: 2) {
        Text(viewModel.title).fontWeight(.medium)
        Text(viewModel.subtitle1).font(.caption)
          .fontWeight(.semibold)
          .multilineTextAlignment(.center)
          .foregroundColor(.gray)
        viewModel.subtitle2.map(Text.init)?
          .font(.caption2)
          .fontWeight(.medium)
          .foregroundColor(.gray)
        HStack(spacing: 12) {
          viewModel.phoneURL.map {
            Link(destination: $0) {
              Image(systemSymbol: .phone)
            }
          }
          viewModel.emailURL.map {
            Link(destination: $0) {
              Image(systemSymbol: .envelope)
            }
          }
        }.foregroundColor(Color(UIColor.label))
        .padding(.top, 6)
      }.padding()
    }.background(Color(UIColor.systemBackground))
    .cornerRadius(20)
    .overlay {
      RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor.systemGray4), lineWidth: 1)
    }.task { await viewModel.loadImage() }
  }
}
