//
//  Enum.swift
//  PolymorphCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public class Enum: Object, Documentable, Packageable {

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case package
        case values
        case documentation
        case rawType
    }

    public enum RawType: String, Codable {
        case int
        case string

        public static func all() -> [RawType] {
            return [
                .int,
                .string
            ]
        }
    }

    public struct Value: Documentable, Codable {
        public var name: String
        public var raw: String
        public var documentation: String?

        public init(name: String, raw: String) {
            self.name = name
            self.raw = raw
        }
    }

    // MARK: Properties

    public var id: UUID

    public var name: String

    public var rawType: RawType

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

    public init(name: String, package: Package, rawType: RawType = .int, values: [Value] = []) {
        self.id = UUID()
        self.name = name
        self.rawType = rawType
        self.package = package
        self.values = values
    }

    public func addValue(_ value: Value) -> Bool {
        for val in self.values {
            guard val.name != value.name else {
                return false
            }
        }
        self.values.append(value)
        return true
    }
}

extension Enum: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }

    public static func == (lhs: Enum, rhs: Enum) -> Bool {
        return lhs.name == rhs.name
    }
}
