/// This is an open-ended task designed to make you think!
///
/// All the dogs in the kennel have run away and you need to help find them.
/// Follow their trail and bring them home (turn the paw prints 🐾 into dog emojis 🐶).
///
/// More concretely, create tasks to find the dogs and make use of the DogKennel actor
/// to keep track of missing and found dogs. Do not stop until you've found them all.
///
///
/// Requirements:
/// - Grand Central Dispatch is not allowed.
/// - DogKennel is an actor which must be used to synchronize the finding of dogs.
/// - You can not add new properties, classes or structs to KennelView. Functions are allowed.
/// - All new properties, classes or structs need to be inside of DogKennel.
/// - Do not pass data from KennelView to DogKennel (e.g. function arguments).
/// - The number of tasks out looking for the missing dogs must be equal to 'numberOfEmployees'
/// - All tasks should keep looking for dogs until they are told to stop (cancelled).
/// - Use 'DogKennel.canCatchDog' to add an element of failure (e.g. wrong dog, failure to catch)
/// - After all dogs have been found, the tasks must cancel/stop gracefully (cancellation).
/// - Every time a dog is found, make sure to make a call to 'KennelView.configure' in order to update the UI.
///
/// Recommendations:
/// - Add some delay/duration to the tasks to make the UI update incrementally.
