
import SwiftUI

struct StacksView: View {

    @StateObject private var viewModel = StacksViewModel()

    var body: some View {
        ZStack(alignment: .top) {

            HStack {
                Button {
                    viewModel.reset()
                } label: {
                    Text("Reset")
                }
                Spacer()
                Text("StacksView")
                Spacer()
                Button {
                    viewModel.moveAll()
                } label: {
                    Text("Move")
                }
            }

            VStack {
                Spacer()
                HStack(alignment: .bottom) {
                    VStack {
                        Text(String(viewModel.left))
                        Color.blue
                            .frame(width: 100, height: CGFloat(viewModel.left / 3))
                    }
                    Spacer()
                    VStack {
                        Text(String(viewModel.right))
                        Color.red
                            .frame(width: 100, height: CGFloat(max(0, viewModel.right / 3)))
                    }
                }
            }
        }
        .onAppear(perform: {
            viewModel.reset()
        })
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StacksView()
    }
}
