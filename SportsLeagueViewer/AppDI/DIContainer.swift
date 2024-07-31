//
//  DIContainer.swift
//  SportsLeagueViewer
//
//  Created by François-Xavier on 31/07/2024.
//

import Foundation

protocol DIContainerProtocol {
    func register<T>(_ service: T, for type: T.Type)
    func resolve<T>(_ type: T.Type) -> T?
    func unregister<T>(_ type: T.Type)
}

class DIContainer {

    static let shared = DIContainer()

    private init() {}

    private var services: [String: Any] = [:]

    func register<T>(service: T, for type: T.Type) {
        let key = String(describing: type)
        services[key] = service
    }

    func resolve<T>(type: T.Type) -> T? {
        let key = String(describing: type)
       return services[key] as? T
    }

    // Maybe delete this because you will not use it in this test
    func unregister<T>(_ type: T.Type) {
        let key = String(describing: type)
        services.removeValue(forKey: key)
    }
}
