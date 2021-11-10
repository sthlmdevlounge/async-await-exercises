
import SwiftUI

struct LettersArrayView: View {

    @StateObject private var viewModel: LettersArrayViewModel = LettersArrayViewModel()

    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                Button {
                    viewModel.load()
                } label: {
                    Text("Reload")
                        .padding()
                }

            }
            LazyVStack {
                ForEach(viewModel.publishedLetters, id: \.self) { (element) in
                    Text(element)
                }
            }
        }
        .onAppear {
            viewModel.load()
        }
    }
}

struct ArrayView_Previews: PreviewProvider {
    static var previews: some View {
        LettersArrayView()
    }
}
