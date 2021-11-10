
import SwiftUI

struct ActorStacksView: View {

    @StateObject var viewModel = ActorStacksViewModel()

    var body: some View {
        ZStack(alignment: .top) {

            HStack {
                Button {
                    Task {
                        await viewModel.reset()
                    }
                } label: {
                    Text("Reset")
                }
                Spacer()
                Text("Actors StacksView")
                Spacer()
                Button {
                    Task {
                        await viewModel.moveAll()
                    }
                } label: {
                    Text("Move")
                }
            }

            VStack {
                Spacer()
                HStack(alignment: .bottom) {
                    VStack {
                        Text(String(viewModel.left))
                        Color.green
                            .frame(width: 100, height: CGFloat(viewModel.left / 3))
                    }
                    Spacer()
                    VStack {
                        Text(String(viewModel.right))
                        Color.orange
                            .frame(width: 100, height: CGFloat(max(0, viewModel.right / 3)))
                    }
                }
            }
        }
        .task {
            await viewModel.reset()
        }
        .padding()
    }
}
struct ActorStackView_Previews: PreviewProvider {
    static var previews: some View {
        ActorStacksView()
    }
}
