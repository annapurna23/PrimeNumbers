
# App to show Prime Numbers


I have basically created this app to **learn flutter.** 
This is more focused on understanding core concepts related to asynchronous programming in flutter rather than making the algorithm efficient.




### Concepts Included:

- Updating UI based on the asynchronous process
- Delaying for loop
- On hitting back navigation button
    the async process pauses
    confirm dialog box appears
    on Confirm:
        - moves to previous route
    on Cancel
        - resumes asynchronous process

### UI Includes:
- Styling elevated button
- Disabling a button (State change of button)
- Confirm Dialog box
- App Bar
- Action Button in App Bar
- Updating text (State change of text)
- CheckBox with title, styling included





### Demo
<img src="https://user-images.githubusercontent.com/11718082/183950461-fd32c233-ae7b-401c-aa46-edf4d7cec76f.gif" width="250" alt-text="app demo"/>


 **Complete App Description**

Button in the main route takes to a new route. In this new route, there are 2 buttons: "Find Primes" & "Terminate Search".

The first button starts to look for the prime number, the second terminates the search.

The search loop starts with 2 and increment by 1 to look for the prime numbers(2, 3, 4, 5, 6 so on).
the loop is not optimized. 

Yes, 2 is the only even prime number, so it is obvious to check only even numbers after that. But here, increment the search number by 1 and check every number if it is prime.
The point here is to keep the working thread busy.

The route shows 2 texts, first, the latest found prime number and the second, the current number being checked.

There is a checkbox called "Pacifier Switch", that can be checked and unchecked by the user. This is just to test if the working thread is not blocked and the UI is working.
This has nothing else to do.

The current number bring check will change so fast that it becomes blur and hence, wastes a lot of CPU cycles. 
The number being checked is managed to be not more than few times per second, as many such that the number changes fast enough to be readable.
How many times per second? It is customisable.

When the back button is presses/route is dismissed, a confirm dialog appears to verify if the user is sure to terminate the searcg.
Dismissing the route terminates the current search.
Any search after that, starts from the beginning.
