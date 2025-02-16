//
//  ContentView.swift
//  act
//
//  Created by Daniel Edrisian on 2/12/25.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "checkmark.circle")
                .font(.system(size: 64))
                .foregroundStyle(Color.gray.opacity(0.5))
            
            Text("No todos yet")
                .font(.headline)
                .foregroundStyle(Color.gray)
            
            Text("Tap the microphone button to add a todo")
                .font(.subheadline)
                .foregroundStyle(Color.gray.opacity(0.8))
                .multilineTextAlignment(.center)
        }
        .padding(.top, 150)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .listRowBackground(Color.clear)
    }
}
