
import Foundation

final class StackCounter {

    var leftStack: Int
    var rightStack: Int

    init(leftStack: Int, rightStack: Int) {
        self.leftStack = leftStack
        self.rightStack = rightStack
    }

    func reset() {
        leftStack = 0
        rightStack = 1000
    }

}

final class StacksViewModel: ObservableObject {

    @Published var left: Int = 0
    @Published var right: Int = 0

    private let numberOfIncreasesPerThread = 200

    private var stackCounter = StackCounter(leftStack: 0, rightStack: 1000)

    func reset() {
        stackCounter.reset()
        updateUI()
    }

    private func move() {

        for _ in 0 ..< numberOfIncreasesPerThread {
            stackCounter.leftStack += 1
            stackCounter.rightStack -= 1
            updateUI()

            // Microseconds, 10^-6
            usleep(500)
        }

    }

    private func updateUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.left = self.stackCounter.leftStack
            self.right = self.stackCounter.rightStack
        }
    }


    func moveAll() {


        DispatchQueue(label: "Q1", qos: .background).async { [weak self] in
            self?.move()
        }

        DispatchQueue(label: "Q2", qos: .background).async { [weak self] in
            self?.move()
        }

        DispatchQueue(label: "Q3", qos: .background).async { [weak self] in
            self?.move()
        }

        DispatchQueue(label: "Q4", qos: .background).async { [weak self] in
            self?.move()
        }

        DispatchQueue(label: "Q5", qos: .background).async { [weak self] in
            self?.move()
        }

    }

}
