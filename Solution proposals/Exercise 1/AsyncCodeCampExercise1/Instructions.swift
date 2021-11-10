///
/// If you are completely new to async/await, here are some good places to start:
/// https://developer.apple.com/videos/play/wwdc2021/10132/
/// https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html
///
/// Exercise 1: Your first async calls
///
/// Look at the code in ContentView, where a button-tap fetches an image async.
/// Your first assignment will be to update this code to async/await.
/// Run everything in a simulator or a real device, not just the SwiftUI previews.
///
/// 1.1:
/// Create a new function, similar to fetchImage in ContentViewModel but which uses async/await. Inside your new function, call the already async function
/// API.fetchImage_1_1 which returns an image async. But try not to peek at how fetchImage_1_1 is implemented. Any errors thrown can be ignored.
///
/// 1.2:
/// Update the button-tap action in ContentView to call your new async function in an async context.
///
/// 1.3:
/// You might have noticed that now we get a runtime warning saying that we are updating the UI from a background thread.
/// This is something we'll need to solve, as that can result in undefined behaviour. To do this, we'll use @MainActor.
/// Basically @MainActor makes sure that we'll run some specific piece code on the main thread, you can read more about it here later:
/// https://www.hackingwithswift.com/books/concurrency/how-to-use-mainactor-to-run-code-on-the-main-queue
/// We'll learn more about actors in a bit, but for now, place @MainActor above the class definition, the function or the property we need to ensure is updated
/// on the main thread, and make sure that the warning goes away when you run it again. If you though about this already in the previous tasks, then you can
/// proceed!
///
/// 1.4:
/// Great, now the run-time warning is gone. Let's dive into making some requests. A great use case for async/await.
/// In API.swift, you'll find the function fetchImage, now it is time to write a new version of this function to use async/await. You can use the old function as
/// inspiration. You'll find that Apple has updated URLSession with some new async functions for you to use.
///
/// 1.5:
/// Now update your function from 1.1 in ContentViewModel to use your own API-function, now the entire pipeline is rewritten in async/await 🎉. As you may have
/// notices, we can decide where we would like to handle thrown errors. Which of these functions do you think should throw and which should handle the error?
///
/// 1.6:
/// So far we've looked at SwiftUI, let's take a quick look at UIKit as well. First, go to AsyncCodeCampExercise1App and
/// change the view inside the WindowGroup to now instead be UIKitView. Second, go into ContentViewController, there you will find an API-call very
/// similar to the SwiftUI case, replace this completion-handler code to use your async/await API-call as well. Don't forget to make sure that the image is updated on
/// the main thread!
///
/// 1.7: Bonus
/// Back in 1.1, we used fetchImage_1_1, which is a function that converts a completion handler function to async/await using what is called
/// continuation. Now, try to implement this method yourself, without peeking at fetchImage_1_1, in API+Compatibility.swift. You'll need to use continuation to make
/// the completion handler version of fetchImage work in an async context When you are done, call this function in the ContentViewController and make sure that
/// everything still works.
/// https://developer.apple.com/documentation/swift/checkedcontinuation
///
/// Congratulations, you are done with the first exercise! 👏
///

