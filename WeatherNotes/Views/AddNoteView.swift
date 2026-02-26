//
//  AddNoteView.swift
//  WeatherNotes
//

import SwiftUI

struct AddNoteView: View {

    @StateObject private var viewModel = AddNoteViewModel()
    @Environment(\.dismiss) private var dismiss

    var onSave: (() -> Void)?

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                textInputSection
                Spacer()
            }
            .padding()
            .navigationTitle("New Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    saveButton
                }
            }
            .alert("Weather Unavailable", isPresented: Binding(
                get: { viewModel.errorMessage != nil && viewModel.saveCompleted },
                set: { _ in viewModel.errorMessage = nil }
            )) {
                Button("OK") { viewModel.errorMessage = nil }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onChange(of: viewModel.saveCompleted) { _, completed in
                if completed {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    onSave?()
                    dismiss()
                }
            }
        }
    }

    // MARK: Components

    private var textInputSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("What are you doing?")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            TextField("e.g. Morning jog, Commute to work…", text: $viewModel.noteText, axis: .vertical)
                .font(.body)
                .lineLimit(4...8)
                .padding(12)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
        }
    }

    private var saveButton: some View {
        Group {
            if viewModel.isSaving {
                ProgressView()
                    .scaleEffect(0.8)
            } else {
                Button("Save") {
                    Task { await viewModel.save() }
                }
                .disabled(!viewModel.canSave)
                .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    AddNoteView()
}
