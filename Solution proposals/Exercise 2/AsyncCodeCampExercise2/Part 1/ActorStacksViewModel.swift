
import Foundation

// 2.1: Create an actor type here

actor ActorStackCounter {

    private(set) var leftStack: Int
    private(set) var rightStack: Int

    init(leftStack: Int, rightStack: Int) {
        self.leftStack = leftStack
        self.rightStack = rightStack
    }

    func updateLeftStack() async {
        leftStack += 1
    }

    func updateRightStack() async {
        rightStack -= 1
    }

    func reset() async {
        leftStack = 0
        rightStack = 1000
    }

}

final class ActorStacksViewModel: ObservableObject {

    @Published var left: Int = 0
    @Published var right: Int = 0

    private let numberOfIncreasesPerTask = 200

    // 2.1: Create an instance of your actor here.
    private var actorStackCounter = ActorStackCounter(leftStack: 0, rightStack: 1000)

    func reset() async {

        // 2.2: Reset the actor counter here

        await actorStackCounter.reset()
        updateUI()
    }

    private func move() async {

        for _ in 0 ..< numberOfIncreasesPerTask {
            do {

                // 2.2: Increment and decrement the stacks here, and update the UI

                await actorStackCounter.updateLeftStack()
                await actorStackCounter.updateRightStack()
                updateUI()

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

            left = await actorStackCounter.leftStack
            right = await actorStackCounter.rightStack
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
