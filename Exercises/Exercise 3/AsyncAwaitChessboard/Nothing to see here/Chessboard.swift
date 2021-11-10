import SwiftUI

struct Chessboard: View {
    private var columns: [GridItem] = [
        GridItem(.fixed(40), spacing: 0),
        GridItem(.fixed(40), spacing: 0),
        GridItem(.fixed(40), spacing: 0),
        GridItem(.fixed(40), spacing: 0),
        GridItem(.fixed(40), spacing: 0),
        GridItem(.fixed(40), spacing: 0),
        GridItem(.fixed(40), spacing: 0),
        GridItem(.fixed(40), spacing: 0),
    ]

    @State var fetchedColors: [Int: Color] = [:]

    let numberOfSquares: Int = 64
    private let darkSquareColor: Color = .black
    private let lightSquareColor: Color = .white

    private func color(forIndex index: Int) -> Color {
        if let color = fetchedColors[index] {
            return color
        }

        let row: Int = index / 8
        let column: Int = index % 8
        if row % 2 == 0 {
            return column % 2 == 0 ? lightSquareColor : darkSquareColor
        }
        return column % 2 != 0 ? lightSquareColor : darkSquareColor
    }

    var body: some View {
        VStack(alignment: .center) {
            chessboard
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Button {
                    fetchedColors = [:]
                } label: {
                    Image(systemName: "trash.square.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 32,
                                      weight: .regular,
                                      design: .default))
                }.padding()
            }
            buttons
        }
    }

    private var chessboard: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
            ForEach(0..<numberOfSquares, id: \.self) { index in
                color(forIndex: index)
                    .aspectRatio(1, contentMode: .fill)
            }
        }
        .frame(width: 40 * 8)
        .cornerRadius(2)
        .padding(2)
        .overlay(
            RoundedRectangle(cornerRadius: 4, style: .continuous)
                .stroke(darkSquareColor, lineWidth: 4)
        )
    }

    private var buttons: some View {
        VStack(spacing: 32) {
            VStack {
                Text("Completions")
                button(title: "Sequential") {
                    completions_sequentialFetch()
                }
                button(title: "Parallel") {
                    completions_parallelFetch()
                }
            }
            VStack {
                Text("Async/await")
                button(title: "Sequential") {
                    Task {
                        await asyncAwait_sequentialFetch()
                    }
                }
                button(title: "Parallel") {
                    Task {
                        await asyncAwait_parallelFetch()
                    }
                }
                button(title: "TaskGroup") {
                    Task {
                        await asyncAwait_taskGroupFetch()
                    }
                }
                button(title: "AsyncSequence") {
                    Task {
                        await asyncAwait_asyncSequenceFetch()
                    }
                }
            }
        }
    }

    private func button(title: String, action: @escaping () -> Void) -> some View {
        Button(title) {
            fetchedColors = [:]
            action()
        }
        .buttonStyle(.bordered)
    }

}

struct Preview: PreviewProvider {
    static var previews: some View {
        Chessboard()
    }
}
