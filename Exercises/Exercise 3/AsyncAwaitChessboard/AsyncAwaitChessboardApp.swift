import SwiftUI

@main
struct AsyncAwaitChessboardApp: App {
    var body: some Scene {
        WindowGroup {
            Chessboard()
        }
    }
}

extension ColorAPI {
    static func fetchColor(forIndex index: Int) async -> Color {
        // 3.1
        fatalError()
    }
}

extension Chessboard {

    // MARK: - Completions
    func completions_sequentialFetch() {
        let nextIndex = fetchedColors.count
        
        guard nextIndex < numberOfSquares else {
            return
        }

        ColorAPI.fetchColor(forIndex: nextIndex) { color in
            fetchedColors[nextIndex] = color
            completions_sequentialFetch()
        }
    }

    func completions_parallelFetch() {
        for index in 0..<numberOfSquares {
            ColorAPI.fetchColor(forIndex: index) { color in
                fetchedColors[index] = color
            }
        }
    }

    // MARK: - Async/await

    func asyncAwait_sequentialFetch() async {
        // 3.2
    }

    func asyncAwait_parallelFetch() async {
        // 3.3
    }

    func asyncAwait_taskGroupFetch() async {
        // 3.4
    }

    func asyncAwait_asyncSequenceFetch() async {
        // 3.5
    }
}
