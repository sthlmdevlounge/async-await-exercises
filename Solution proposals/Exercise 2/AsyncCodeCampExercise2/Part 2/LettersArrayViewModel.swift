
import Foundation

// 2.3: Define the global actor here.

@globalActor
struct CodeCampActor {

    actor CodeCampActorType {}

    static let shared = CodeCampActorType()
}

final class LettersArrayViewModel: ObservableObject {

    @Published private(set) var publishedLetters: [String] = []

    private var letters: [String] = [] {
        didSet {
            Task { @MainActor in
                self.publishedLetters = self.letters
            }
        }
    }

    func load() {

        letters = []

        Task.detached(priority: .background) { [weak self] in
            await self?.addUppercase()
        }

        Task.detached(priority: .background) { [weak self] in
            await self?.addLowercase()
        }

    }

    // 2.3: Make sure that the functions are run on your new global actor

    @CodeCampActor
    private func addUppercase() async {
        let uppercaseAdder = UppercaseAdder()
        uppercaseAdder.addUppercase(array: &self.letters)
    }

    @CodeCampActor
    private func addLowercase() async {
        let lowercaseAdder = LowercaseAdder()
        lowercaseAdder.addLowercase(array: &self.letters)
    }

}

class UppercaseAdder {

    func addUppercase(array: inout [String]) {
        array.append("A")
        array.append("B")
        array.append("C")
        array.append("D")
        array.append("E")
        array.append("F")
        array.append("G")
    }

}

class LowercaseAdder {

    func addLowercase(array: inout [String]) {
        array.append("a")
        array.append("b")
        array.append("c")
        array.append("d")
        array.append("e")
        array.append("f")
        array.append("g")
    }

}
