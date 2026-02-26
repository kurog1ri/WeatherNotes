//
//  NoteStorageService.swift
//  WeatherNotes
//

import Foundation

// MARK: - Protocol

protocol NoteStorageServiceProtocol {
    func saveNote(_ note: WeatherNote)
    func loadNotes() -> [WeatherNote]
    func deleteNote(id: UUID)
}

// MARK: - UserDefaults Implementation

final class NoteStorageService: NoteStorageServiceProtocol {

    private let key = "weather_notes"
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func saveNote(_ note: WeatherNote) {
        var notes = loadNotes()
        notes.insert(note, at: 0)
        encode(notes)
    }

    func loadNotes() -> [WeatherNote] {
        guard let data = defaults.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([WeatherNote].self, from: data)) ?? []
    }

    func deleteNote(id: UUID) {
        let notes = loadNotes().filter { $0.id != id }
        encode(notes)
    }

    // MARK: Private

    private func encode(_ notes: [WeatherNote]) {
        guard let data = try? JSONEncoder().encode(notes) else { return }
        defaults.set(data, forKey: key)
    }
}
