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

            }

            Button("Reset") {
                reset()
            }
        }
        .onAppear {
            reset()
        }
    }

    private func reset() {
        configure(numberOfFoundDogs: 0, numberOfMissingDogs: kennel.names.count)
    }

    private func configure(numberOfFoundDogs: Int, numberOfMissingDogs: Int) {
        dogString = ((0..<numberOfFoundDogs).map { _ in "🐶" } + (0..<numberOfMissingDogs).map { _ in "🐾"}).joined()
    }
}

actor DogKennel {
    nonisolated let names = ["Fido", "Scooby Doo", "Snoopy", "Scrappy Doo", "Pluto"]

    private func canCatchDog() -> Bool {
        Int.random(in: 1...100) == 1
    }
}

