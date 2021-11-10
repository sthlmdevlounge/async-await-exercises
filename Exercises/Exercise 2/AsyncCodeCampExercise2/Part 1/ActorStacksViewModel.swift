
import Foundation

// 2.1: Create an actor type here

final class ActorStacksViewModel: ObservableObject {

    @Published var left: Int = 0
    @Published var right: Int = 0

    private let numberOfIncreasesPerTask = 200

    // 2.2: Create an instance of your actor here.

    func reset() async {

        // 2.2: Reset the actor's stacks here

        updateUI()
    }

    private func move() async {

        for _ in 0 ..< numberOfIncreasesPerTask {
            do {

                // 2.2: Increment and decrement the stacks here, and update the UI

                // Nanoseconds, 10^-9
                try await Task.sleep(nanoseconds: 500_000)
            } catch {
                print(error.localizedDescription)
                return
            }
        }

    }

    private func updateUI() {
        Task { @MainActor in

            // 2.2: Update the properties ´left´and ´right´.

        }
    }

    func moveAll() async {

        // There is actually no guarantee that this will be perfomed on different threads,
        // that is determined by the system, but in my testing it has been performed on different threads.

        Task.detached(priority: .background) { [weak self] in
            await self?.move()
        }

        Task.detached(priority: .background) { [weak self] in
            await self?.move()
        }

        Task.detached(priority: .background) { [weak self] in
            await self?.move()
        }

        Task.detached(priority: .background) { [weak self] in
            await self?.move()
        }

        Task.detached(priority: .background) { [weak self] in
            await self?.move()
        }

    }

}
