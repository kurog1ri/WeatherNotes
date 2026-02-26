//
//  NoteRowView.swift
//  WeatherNotes
//

import SwiftUI

struct NoteRowView: View {

    let note: WeatherNote

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: note.createdAt)
    }

    var body: some View {
        HStack(spacing: 12) {
            WeatherIconView(iconCode: note.weather?.iconCode, size: 36)

            VStack(alignment: .leading, spacing: 4) {
                Text(note.text)
                    .font(.typewriter())
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                    .lineLimit(2)

                Text(formattedDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            if let weather = note.weather {
                Text(weather.temperatureFormatted)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(weather.temperatureColor)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    List {
        NoteRowView(note: WeatherNote(
            text: "Morning jog in the park",
            createdAt: Date(),
            weather: WeatherData(
                temperature: 12,
                description: "Clear sky",
                iconCode: "01d",
                cityName: "Kyiv"
            )
        ))
        NoteRowView(note: WeatherNote(
            text: "Commute to work",
            createdAt: Date(),
            weather: nil
        ))
    }
}
