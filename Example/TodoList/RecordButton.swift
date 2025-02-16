//
//  ContentView.swift
//  act
//
//  Created by Daniel Edrisian on 2/12/25.
//

import SwiftUI
import ActAPIFramework

struct RecordButton: View {
    @StateObject var actor: ActAPI<MyActions>
    let action: () async throws -> Void
    
    var body: some View {
        Button(action: {
            Task {
                try await action()
            }
        }) {
            Group {
                if actor.isTranscribing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .frame(width: 60, height: 60)
                } else {
                    Image(systemName: actor.isRecording ? "mic.circle" : "mic.circle.fill")
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(width: 60, height: 60)
            .foregroundStyle(actor.isRecording ? Color.red.opacity(0.8) : Color.indigo.opacity(0.8))
            .background(
                Circle()
                    .fill(actor.isRecording ? Color.red.opacity(0.1) : Color.indigo.opacity(0.1))
                    .frame(width: 72, height: 72)
            )
            .scaleEffect(actor.isRecording ? 1.1 : 1.0)
            .animation(.spring(response: 0.3), value: actor.isRecording)
        }
    }
}
