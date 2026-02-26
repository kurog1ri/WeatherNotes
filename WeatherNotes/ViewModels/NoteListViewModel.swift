//
//  NoteListViewModel.swift
//  WeatherNotes
//

import Foundation

@MainActor
final class NoteListViewModel: ObservableObject {

    @Published var notes: [WeatherNote] = []

    private let storage: NoteStorageServiceProtocol

    init(storage: NoteStorageServiceProtocol = NoteStorageService()) {
        self.storage = storage
    }

    func loadNotes() {
        notes = storage.loadNotes()
    }

    func deleteNote(at offsets: IndexSet) {
        offsets.forEach { index in
            storage.deleteNote(id: notes[index].id)
        }
        notes.remove(atOffsets: offsets)
    }
}
