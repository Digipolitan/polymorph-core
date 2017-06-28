//
//  Native.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public struct Native: Object {

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case documentation
    }

    public enum DataType: String {
        case int = "Int"
        case bool = "Bool"
        case double = "Double"
        case float = "Float"
        case date = "Date"
        case string = "String"
        case data = "Data"
        case array = "Array"
        case map = "Map"

        public static func from(string: String) -> DataType? {
            return Native.mapping[string.lowercased()]
        }
    }

    private static var mapping: [String: DataType] = [
        "int": .int,
        "integer": .int,
        "bool": .bool,
        "boolean": .bool,
        "double": .double,
        "float": .float,
        "string": .string,
        "data": .data,
        "bytes": .data,
        "array": .array,
        "map": .map,
        "dict": .map,
        "dictionary": .map
    ]

    // MARK: Properties

    public var id: UUID

    public var name: String

    public var documentation: String?

    public internal(set) weak var project: Project? = nil

    // MARK: Initializers

    public init(type: DataType) {
        self.id = UUID()
        self.name = type.rawValue
    }
}

extension Native: Hashable {

    public var hashValue: Int {
        return self.id.hashValue
    }

    public static func ==(lhs: Native, rhs: Native) -> Bool {
        return lhs.name == rhs.name
    }
}
