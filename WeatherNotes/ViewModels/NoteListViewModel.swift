//
//  NoteListViewModel.swift
//  WeatherNotes
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class NoteListViewModel: ObservableObject {

    @Published var notes: [WeatherNote] = []

    private let storage: NoteStorageServiceProtocol

    init(storage: NoteStorageServiceProtocol? = nil) {
        self.storage = storage ?? NoteStorageService()
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
