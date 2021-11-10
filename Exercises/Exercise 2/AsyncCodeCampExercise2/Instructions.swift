
import Foundation

///
/// Exercise 2: Actors
///
/// Part 1: Actors
///
/// In this part we'll take a look at a simple view which increments a counter on one side of the app, and decrements it on another side.
///
/// 2.1:
/// Run the app, tap move, tap reset, try it out a few times. What happens? Is the app successfull in moving the entire (1000) in stack to the left side all of the times?
/// As you'll see, we get an inconsitent result, since there is a race condition between 5 threads trying to increment a counter. If you tap "move" while the
/// stacks are already moving you'll see another bug, but don't worry, we'll get to that too.
///
/// Let's solve this race condition with actors! Go to AsyncCodeCampExercise2App.swift and replace the view there with ActorStacksView.
///
/// Your task is now to implement an actor type, similar to StackCounter, found in StacksViewModel, you can put it above ActorStacksView. When you think you
/// are done, we'll move on to updating the view model. Remember that you have a version of the views in StacksView/StacksViewModel, although with some
/// race conditions, which you can look at for inspiration. Make sure that the left counter is starting at 0, and that the right counter is starting at 1000.
///
/// 2.2:
/// Let's update the ActorStacksViewModel accordingly to make use of our new actor. We'll hook up the button-tap actions to interact with our new actor.
/// When you are done, you should now be getting the full stacks being moved every single time!
///
/// How does actors affect performance? Will there be any drawbacks?
///
/// Part 2: Global actors
///
/// 2.3:
/// Race conditions with counters is fun and all, but the worst thing that can happen is that we miss an increment/decrement or two. Let's look at inserting
/// things into arrays, which can cause crashes if we try to do it from separate threads. In this exercise we'll take a look at a simplified scenario where two separate
/// entities needs to access the same resource, or perform something independent of each other, but not at the same time. This is where global actors come in to
/// play. @MainActor is a global actor, but we don't want to slow down the main thread for tasks that could be performed in the background.
///
/// Take a look at load() in LettersArrayViewModel, here we create 2 detached tasks, meaning that they do not inherit any prior context. As the two functions
/// tries to write to the same array on a background thread, this will often cause a crash. You can try this by swapping to LettersArrayView in
/// AsyncCodeCampExercise2App.swift, and then tapping "Reload".
///
/// Your task is to define a global actor, and then make sure that the two functions in load() both are performed on that actor (it shoud not be the @MainActor). When
/// you are done, the letters should show up and there should be no crashes and no keeping the @MainActor busy with appending to the array!
///
/// Are the letters always added in the same order? Try reloading a few times, if not, why?
///
/// Part 3: Bonus - Cancellation
///
/// 2.4:
/// If you have time over before the break, great! Let's try to squash some more bugs that we had back in Part 1. As previously mentioned, if you tap "Move" while
/// the app is already moving the stacks, the view will bug out, to solve this, we'll need to cancel the tasks that you'll find in the moveAll-function. For this exercise,
/// in the function moveAll, change it so that before the new Tasks are run, cancel the old tasks and reset the counter. That should result in a "restart" if you tap move
/// while it is already moving. Do the cancellations manually on each of the tasks. If you find this process a bit tedious, you'll find that we can solve these kinds of
/// problems later with TaskGroups. In this exercise, you'll have to modify the already existing code. Consider that cancelled task should not be able to affect our
/// current state.
/// 
/// Congratulations, you are done with the second exercise! 👏
///
