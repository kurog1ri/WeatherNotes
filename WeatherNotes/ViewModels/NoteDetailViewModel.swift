//
//  NoteDetailViewModel.swift
//  WeatherNotes
//

import Foundation
import Combine

@MainActor
final class NoteDetailViewModel: ObservableObject {

    let note: WeatherNote

    init(note: WeatherNote) {
        self.note = note
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: note.createdAt)
    }

    var weatherDescription: String {
        note.weather?.description ?? "Weather unavailable"
    }

    var temperature: String {
        note.weather?.temperatureFormatted ?? "—"
    }

    var cityName: String {
        note.weather?.cityName ?? "—"
    }

    var iconCode: String? {
        note.weather?.iconCode
    }
}
