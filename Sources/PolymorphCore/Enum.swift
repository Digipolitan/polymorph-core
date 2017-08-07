//
//  Enum.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public struct Enum: Object, Packageable {

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case package
        case values
        case documentation
    }

    public struct Value: Documentable {
        public var name: String
        public var numeric: Int
        public var documentation: String?

        public init(name: String, numeric: Int) {
            self.name = name
            self.numeric = numeric
        }
    }

    // MARK: Properties

    public var id: UUID

    public var name: String

    public var package: Package

    public var documentation: String?

    public var values: [Value]

    public internal(set) weak var project: Project? = nil

    public var canonicalName: String? {
        guard
            let project = self.project,
            let package = try? self.merge(parent: project) else {
                return nil
        }
        return "\(package.value).\(self.name)"
    }

    // MARK: Initializers

    public init(name: String, package: Package, values: [Value] = []) {
        self.id = UUID()
        self.name = name
        self.package = package
        self.values = values
    }

    public mutating func addValue(_ value: Value) -> Bool {
        for v in self.values {
            guard v.name != value.name else {
                return false
            }
        }
        self.values.append(value)
        return true
    }
}

extension Enum: Hashable {

    public var hashValue: Int {
        return self.id.hashValue
    }

    public static func ==(lhs: Enum, rhs: Enum) -> Bool {
        return lhs.name == rhs.name
    }
}
