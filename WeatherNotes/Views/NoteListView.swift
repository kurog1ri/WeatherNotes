//
//  NoteListView.swift
//  WeatherNotes
//

import SwiftUI

struct NoteListView: View {

    @StateObject private var viewModel = NoteListViewModel()
    @State private var showAddNote = false

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.notes.isEmpty {
                    emptyState
                } else {
                    noteList
                }
            }
            .navigationTitle("Weather Notes")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAddNote = true
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                    }
                }
            }
            .sheet(isPresented: $showAddNote) {
                AddNoteView {
                    viewModel.loadNotes()
                }
            }
            .onAppear {
                viewModel.loadNotes()
            }
        }
    }

    // MARK: Components

    private var noteList: some View {
        List {
            ForEach(viewModel.notes) { note in
                NavigationLink(destination: NoteDetailView(note: note)) {
                    NoteRowView(note: note)
                }
            }
            .onDelete(perform: viewModel.deleteNote)
        }
        .listStyle(.insetGrouped)
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "cloud.sun.rain")
                .font(.system(size: 64))
                .foregroundStyle(.secondary)

            Text("No Notes Yet")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Tap + to add your first weather note.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    NoteListView()
}
