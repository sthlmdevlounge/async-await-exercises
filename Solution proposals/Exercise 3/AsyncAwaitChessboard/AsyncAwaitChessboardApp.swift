//
//
//

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
        await withCheckedContinuation { continuation in
            fetchColor(forIndex: index) { color in
                continuation.resume(returning: color)
            }
        }
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
        for index in 0..<numberOfSquares {
            let color = await ColorAPI.fetchColor(forIndex: index)
            fetchedColors[index] = color
        }
    }

    func asyncAwait_parallelFetch() async {
        // 3.3
        for index in 0..<numberOfSquares {
            Task {
                let color = await ColorAPI.fetchColor(forIndex: index)
                fetchedColors[index] = color
            }
        }
    }

    func asyncAwait_taskGroupFetch() async {
        // 3.4
        let colors = await fetchColorsWithTaskGroup()
        colors.enumerated().forEach {
            fetchedColors[$0.offset] = $0.element
        }
    }

    private func fetchColorsWithTaskGroup() async -> [Color] {

        return await withTaskGroup(of: (Int, Color).self, body: { group in
            for index in 0..<numberOfSquares {
                group.addTask {
                    let color = await ColorAPI.fetchColor(forIndex: index)
                    return (index, color)
                }
            }

            var results: [(Int, Color)] = []

            for await result in group {
                results.append(result)
            }

            return results.sorted { $0.0 < $1.0 }.map { $0.1 }
        })
    }

    func asyncAwait_asyncSequenceFetch() async {
        // 3.5
        let awaitableColors = AsyncStream(Color.self) { continuation in
            Task.detached {
                for index in 0..<numberOfSquares {
                    let color = await ColorAPI.fetchColor(forIndex: index)
                    continuation.yield(color)
                }
                continuation.finish()
            }
        }

        for await color in awaitableColors {
            fetchedColors[fetchedColors.count] = color
        }
    }
}
