//
//  DataManager.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 22.07.2025.
//

import Foundation
import SwiftData

@MainActor
final class DataManager<T: PersistentModel> {
    private let container: ModelContainer
    private var context: ModelContext { container.mainContext }
    
    nonisolated static var manager: DataManager<T> {
        do {
            return try DataManager(container: .init(for: T.self))
        } catch {
            fatalError("Failed to initilise storage")
        }
    }

    nonisolated init(container: ModelContainer) {
        self.container = container
    }

    func insert(_ model: T) {
        context.insert(model)
        try? context.save()
    }

    func fetchAll() -> [T] {
        let descriptor = FetchDescriptor<T>()
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func fetchFirst(where predicate: Predicate<T>? = nil) -> T? {
        var descriptor = FetchDescriptor<T>(predicate: predicate)
        descriptor.fetchLimit = 1
        return try? context.fetch(descriptor).first
    }
    
    func delete(_ model: T) {
        context.delete(model)
        try? context.save()
    }
}
