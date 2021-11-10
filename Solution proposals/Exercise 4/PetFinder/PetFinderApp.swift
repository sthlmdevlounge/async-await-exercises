//
//  
//

import SwiftUI

@main
struct PetFinderApp: App {
    var body: some Scene {
        WindowGroup {
            KennelView()
        }
    }
}

struct KennelView_Previews: PreviewProvider {
    static var previews: some View {
        KennelView()
    }
}

struct KennelView: View {
    private let kennel = DogKennel()
    private let numberOfEmployees: Int = 4
    private var dogNames: String { kennel.names.joined(separator: ", ") }

    @State var dogString: String = ""

    var body: some View {
        VStack(spacing: 16) {
            Text(dogNames)
            Text(dogString)
            Button("Look for dogs") {
                Task {
                    await lookForDogs()
                }
            }

            Button("Reset") {
                Task {
                    await kennel.reset()
                    configure(numberOfFoundDogs: 0,
                              numberOfMissingDogs: kennel.names.count)
                }
            }
        }
        .onAppear {
            configure(numberOfFoundDogs: 0, numberOfMissingDogs: kennel.names.count)
        }
    }

    private func configure(numberOfFoundDogs: Int, numberOfMissingDogs: Int) {
        dogString = ((0..<numberOfFoundDogs).map { _ in "🐶" } + (0..<numberOfMissingDogs).map { _ in "🐾"}).joined()
    }

    private func lookForDogs() async {
        await withThrowingTaskGroup(of: Void.self) { group in
            for _ in 0..<numberOfEmployees {
                group.addTask {
                    while !Task.isCancelled {
                        try await Task.sleep(nanoseconds: .random(in: 5_000_000...50_000_000))
                        try Task.checkCancellation()
                        let dogs = try await kennel.tryToFindDog()
                        configure(numberOfFoundDogs: dogs.found.count, numberOfMissingDogs: dogs.missing.count)
                    }
                }
            }
        }
    }
}

actor DogKennel {
    struct Dogs {
        var missing: [String]
        var found: [String]
    }

    nonisolated let names = ["Fido", "Scooby Doo", "Snoopy", "Scrappy Doo", "Pluto"]

    var dogs: Dogs

    init() {
        dogs = .init(missing: names,
                     found: [])
    }

    func reset() {
        dogs = .init(missing: names,
                     found: [])
    }

    enum DogError: Error {
        case noMissingDogs
    }

    private func canCatchDog() -> Bool {
        Int.random(in: 1...100) == 1
    }

    func tryToFindDog() async throws -> Dogs {
        guard !dogs.missing.isEmpty else {
            throw DogError.noMissingDogs
        }

        if canCatchDog() {
            let foundDog = dogs.missing.removeLast()
            dogs.found.append(foundDog)
        }

        return dogs
    }
}
