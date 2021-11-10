/// In this exercise you will practice converting completions to async/await.
/// The implementations may not make use of Grand Central Dispatch.
///
/// You only need to edit 'AsyncAwaitChessboardApp.swift'. Don't look in the other files!
///
/// The UI listens to changes to the 'fetchedColors: [Int: Color]' dictionary.
///
/// Bonus: Some data races may occur while running the parallel functions. Can you figure out why and fix them?
///
/// 3.1:
/// Implement the async version of the 'fetchColor' function using the completion version.
/// This will be used in the following subtasks.
/// https://developer.apple.com/documentation/swift/checkedcontinuation
///
/// 3.2:
/// Fetch the colors and update 'fetchedColors' sequentially in order.
/// Make use of the async version of 'fetchColor' that you previously implemented.
///
/// 3.3:
/// Fetch the colors and update 'fetchedColors' in parallel.
///
/// 3.4:
/// Use task groups
/// https://developer.apple.com/documentation/swift/taskgroup
///
/// 3.5:
/// Use AsyncStream
/// https://developer.apple.com/documentation/swift/asyncstream
///
/// Congratulations, you are done with the third exercise! 👏
///
///
/// Additional resources
/// https://developer.apple.com/documentation/swift/swift_standard_library/concurrency
/// https://developer.apple.com/documentation/swift/swift_standard_library/concurrency/updating_an_app_to_use_swift_concurrency
