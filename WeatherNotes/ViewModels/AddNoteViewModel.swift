//
//  AddNoteViewModel.swift
//  WeatherNotes
//

import Foundation
import Combine

@MainActor
final class AddNoteViewModel: ObservableObject {

    @Published var noteText: String = ""
    @Published var isSaving: Bool = false
    @Published var errorMessage: String?

    private let weatherService: WeatherServiceProtocol
    private let storage: NoteStorageServiceProtocol

    init(
        weatherService: WeatherServiceProtocol? = nil,
        storage: NoteStorageServiceProtocol? = nil
    ) {
        self.weatherService = weatherService ?? WeatherService()
        self.storage = storage ?? NoteStorageService()
    }

    var canSave: Bool {
        !noteText.trimmingCharacters(in: .whitespaces).isEmpty && !isSaving
    }

    func save() async {
        guard canSave else { return }
        isSaving = true
        errorMessage = nil

        let weather = try? await weatherService.fetchWeather(city: Config.defaultCity)
        let note = WeatherNote(
            text: noteText.trimmingCharacters(in: .whitespaces),
            createdAt: Date(),
            weather: weather
        )

        storage.saveNote(note)
        isSaving = false
    }
}
