
<img src="https://github.com/user-attachments/assets/10d9c13e-89a0-4b79-ba11-f07b1ea5fa69" width=100>

# ActAPI

ActAPI is a voice-control API by [Alex (Sidebar)](https://alexcodes.app) that lets you easily implement extremely fast voice commands in your iOS/MacOS apps.

https://github.com/user-attachments/assets/ee063337-f3f3-4b00-b770-405c90d64ef5


## Quickstart

> Check the [Examples](./Examples/) directory for a TodoList app that uses voice intents.


### Pt. 1: Installation

Add the `ActAPIFramework` package via SPM:

`https://github.com/AlexSideBar/ActAPI`


### Pt. 2: Define Actions

ActAPI uses enums to define actions for your app. Here's an example:

```swift
@BaseAction
enum MyActions {
    // Adds a todo item to our list of todos
    case addTodo(
        content: String,
        deadline: Date?
    )
    
    // Marks a todo item as done
    case markDone(
        todo_id: String
    )
    
    // Example uses of the enum
    // Must include all cases!
    //
    static var allCases: [MyActions] {
        return [
            .addTodo(content: "My cool todo", deadline: Date()),
            .markDone(todo_id: "123")
        ]
    }
}

...

@StateObject var actor = ActAPI<MyActions>(apiKey: "sk-123")
...
```

### Pt. 3: Start / End Recordings

Then, all you have to do is execute two functions: `actor.startRecording()` and `actor.endRecord()`. We handle the audio recordings for you.

Once `endRecord()` is executed, it will return a list of the action enums you have defined. In this case, `[MyActions]`:

```swift
for action in try await actor.endRecord() {
    switch action {
    case .addTodo(let content, let deadline):
        // Add a todo item something here
    case .markDone(let todo_id):
        // Remove the todo item
    }
}
```

That's it! You can now define any number of actions, and get back to building features.


> Note: Be sure to add examples for all enum cases to `allCases`


### API Key

The service is currently in beta and is free, so the api key `sk-123` works for all actions.

### Record Button

There's also a pre-defined record button in the Examples directory. But in the future, we'll add a proper reusable record button.





