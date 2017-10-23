//
//  Network.swift
//  PolymorphCore
//
//  Created by Benoit BRIATTE on 23/10/2017.
//

import Foundation

public class Network: Documentable, Codable {

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case documentation
        case services
    }

    // MARK: Properties

    public var documentation: String?

    public private(set) var services: [UUID: Service]

    public internal(set) weak var project: Project? = nil {
        didSet {
            self.services.values.forEach { $0.project = self.project }
        }
    }

    // MARK: Initializers

    public init() {
        self.services = [:]
    }

    // MARK: Objects

    public func findObject(uuid: UUID) -> Object? {
        if let cl = self.services[uuid] {
            return cl
        }
        return nil
    }

    public func findObject(name: String) -> Object? {
        if let c = self.findService(name: name) {
            return c
        }
        return nil
    }

    public func searchObjects(matching: String) -> [Object] {
        var objects: [Object] = []
        objects += self.searchServices(matching: matching) as [Object]
        return objects
    }

    // MARK: Classes

    @discardableResult
    public func addService(_ service: Service) -> Bool {
        guard self.services[service.id] == nil else {
            return false
        }
        self.services[service.id] = service
        return true
    }

    @discardableResult
    public func removeService(uuid: UUID) -> Bool {
        guard self.services[uuid] != nil else {
            return false
        }
        self.services[uuid] = nil
        return true
    }

    public func findService(name: String) -> Service? {
        return self.services.first { $0.value.name == name }?.value
    }

    public func searchServices(matching: String) -> [Service] {
        return self.services.values.filter { $0.name.range(of: matching, options: .caseInsensitive) != nil }
    }

    public func searchServices(linkedTo uuid: UUID) -> [Service] {
        return self.services.values.filter { $0.isLinked(to: uuid) }
    }
}
