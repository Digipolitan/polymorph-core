//
//  Class.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public class Class: Object, Documentable, Packageable {

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case package
        case documentation
        case extends
        case properties
        case serializable
        case injectable
    }

    // MARK: Properties

    public var id: UUID

    public var name: String

    public var package: Package

    public var documentation: String?

    public var serializable: Bool

    public var injectable: Bool

    public var extends: UUID?

    public var canonicalName: String? {
        guard
            let project = self.project,
            let package = try? self.merge(parent: project) else {
                return nil
        }
        return "\(package.value).\(self.name)"
    }

    public private(set) var properties: [Property]

    public internal(set) weak var project: Project? = nil {
        didSet {
            self.properties.forEach { $0.project = self.project }
        }
    }

    // MARK: Initializers

    public init(name: String, package: Package, extends: UUID? = nil, serializable: Bool = false, injectable: Bool = false) {
        self.id = UUID()
        self.name = name
        self.package = package
        self.extends = extends
        self.properties = []
        self.serializable = serializable
        self.injectable = injectable
    }

    // MARK: Properties

    @discardableResult
    public func removeProperty(name: String) -> Bool {
        if let idx = self.indexOf(property: name) {
            self.properties.remove(at: idx)
            return true
        }
        return false
    }

    @discardableResult
    public func addProperty(_ property: Property) -> Bool {
        guard self.indexOf(property: property.name) == nil else {
            return false
        }
        self.properties.append(property)
        return true
    }

    public func findProperty(name: String) -> Property? {
        if let idx = self.indexOf(property: name) {
            return self.properties[idx]
        }
        return nil
    }

    private func indexOf(property name: String) -> Int? {
        return self.properties.index(where: { $0.name == name })
    }

    public func parentProperties() -> [Property] {
        var properties: [Property] = []
        guard let project = self.project else {
            return properties
        }
        var cur: Class = self
        while let extends = cur.extends {
            if let parent = project.models.findObject(uuid: extends) as? Class {
                properties = parent.properties + properties
                cur = parent
            } else {
                return properties
            }
        }
        return properties
    }

    // MARK: Linked

    public func isLinked(to uuid: UUID) -> Bool {
        if self.extends == uuid {
            return true
        }
        return self.properties.first { $0.isLinked(to: uuid) } != nil
    }
}

extension Class: Hashable {

    public var hashValue: Int {
        return self.id.hashValue
    }

    public static func ==(lhs: Class, rhs: Class) -> Bool {
        return lhs.name == rhs.name
    }
}
