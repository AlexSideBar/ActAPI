//
//  ContentView.swift
//  act
//
//  Created by Daniel Edrisian on 2/12/25.
//

import SwiftUI
import ActAPIFramework


@BaseActionMacro
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
    
    // Some examples of actions
    static var allCases: [MyActions] {
        return [
            .addTodo(content: "My cool todo", deadline: Date()),
            .markDone(todo_id: "123")
        ]
    }
}

struct ContentView: View {
    @StateObject var actor = ActAPI<MyActions>(apiKey: "sk-123")
    
    @State var todos: [Todo] = []
    
    func recordButtonClicked() async throws {
        // First, call actor.startRecording() to start recording.
        if !actor.isRecording {
            try actor.startRecording()
            return
        }
        
        // Then just call actor.endRecord(), and we'll parse the audio into an action.
        for action in try await actor.endRecord() {
            switch action {
            case .addTodo(let content, let deadline):
                todos.append(
                    Todo(
                        id: UUID().uuidString,
                        content: content,
                        deadline: deadline
                    )
                )
            case .markDone(let todo_id):
                todos.removeAll(where: { $0.id == todo_id })
            }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                if todos.isEmpty {
                    EmptyListView()
                } else {
                    ForEach(todos) { todo in
                        Group {
                            if let deadline = todo.deadline {
                                HStack {
                                    Text("\(todo.content)")
                                    Spacer()
                                    Text("\(deadline, format: Date.FormatStyle(time: .standard))")
                                        .opacity(0.6)
                                }
                            } else {
                                Text(todo.content)
                            }
                        }
                        .transition(.blurReplace)
                    }
                }
            }
            .navigationTitle("Todos")
            .overlay(alignment: .bottom) {
                RecordButton(actor: actor, action: recordButtonClicked)
                    .padding(.bottom, 30)
            }
        } detail: {
            Text("Select an item")
        }
        .preferredColorScheme(.light)
    }
}
