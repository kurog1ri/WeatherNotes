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
    @Published var saveCompleted: Bool = false

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

        var fetchedWeather: WeatherData?
        do {
            fetchedWeather = try await weatherService.fetchWeather(city: Config.defaultCity)
        } catch let error as AppError {
            errorMessage = error.errorDescription
        } catch {
            errorMessage = error.localizedDescription
        }

        let note = WeatherNote(
            text: noteText.trimmingCharacters(in: .whitespaces),
            createdAt: Date(),
            weather: fetchedWeather
        )

        storage.saveNote(note)
        isSaving = false
        saveCompleted = true
    }
}
