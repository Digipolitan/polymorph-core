//
//  Native.swift
//  PolymorphCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public class Native: Member {

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
        case url = "URL"
        case multilingual = "Multilingual"

        public static func all() -> [DataType] {
            return [
                .int,
                .bool,
                .double,
                .float,
                .date,
                .string,
                .data,
                .array,
                .map,
                .url,
                .multilingual
            ]
        }

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
        "date": .date,
        "data": .data,
        "bytes": .data,
        "array": .array,
        "map": .map,
        "dict": .map,
        "dictionary": .map,
        "url": .url,
        "multilingual": .multilingual
    ]

    // MARK: Properties

    public var name: String

    public internal(set) weak var project: Project?

    // MARK: Initializers

    internal init(type: DataType) {
        self.name = type.rawValue
    }
}

extension Native: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
    }

    public static func == (lhs: Native, rhs: Native) -> Bool {
        return lhs.name == rhs.name
    }
}
