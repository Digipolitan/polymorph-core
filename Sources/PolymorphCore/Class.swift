//
//  Class.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public struct Class: Object, Packageable {

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case package
        case documentation
        case extends
        case properties
    }

    // MARK: Properties

    public var id: UUID

    public var name: String

    public var package: Package

    public var documentation: String?

    public var extends: UUID?

    public private(set) var properties: Set<Property>

    // MARK: Initializers

    public init(name: String, package: Package, extends: UUID? = nil, properties: Set<Property> = Set()) {
        self.id = UUID()
        self.name = name
        self.package = package
        self.extends = extends
        self.properties = properties
    }

    // MARK: Properties

    @discardableResult
    public mutating func removeProperty(name: String) -> Bool {
        if let p = self.findProperty(name: name) {
            return self.properties.remove(p) != nil
        }
        return false
    }

    @discardableResult
    public mutating func addProperty(_ property: Property) -> Bool {
        return self.properties.insert(property).inserted
    }

    @discardableResult
    public mutating func updateProperty(_ property: Property) -> Bool {
        return self.removeProperty(name: property.name) && self.addProperty(property)
    }

    public func findProperty(name: String) -> Property? {
        return self.properties.first { $0.name == name }
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
