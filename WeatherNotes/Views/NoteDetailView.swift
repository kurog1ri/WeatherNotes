//
//  NoteDetailView.swift
//  WeatherNotes
//

import SwiftUI

struct NoteDetailView: View {

    @StateObject private var viewModel: NoteDetailViewModel

    init(note: WeatherNote) {
        _viewModel = StateObject(wrappedValue: NoteDetailViewModel(note: note))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                noteSection
                weatherSection
            }
            .padding()
        }
        .navigationTitle("Note")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: Sections

    private var noteSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Note", systemImage: "note.text")
                .font(.caption)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)

            Text(viewModel.note.text)
                .font(.typewriter(.title3))
                .fontWeight(.medium)
                .foregroundStyle(.primary)

            Text(viewModel.formattedDate)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private var weatherSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label("Weather", systemImage: "cloud.sun.fill")
                .font(.caption)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)

            HStack(spacing: 16) {
                WeatherIconView(iconCode: viewModel.iconCode, size: 64)

                VStack(alignment: .leading, spacing: 6) {
                    Text(viewModel.temperature)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(viewModel.weatherDescription)
                        .font(.body)
                        .foregroundStyle(.secondary)

                    Label(viewModel.cityName, systemImage: "location.fill")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    NavigationStack {
        NoteDetailView(note: WeatherNote(
            text: "Morning jog in the park",
            createdAt: Date(),
            weather: WeatherData(
                temperature: 12,
                description: "Clear sky",
                iconCode: "01d",
                cityName: "Kyiv"
            )
        ))
    }
}
