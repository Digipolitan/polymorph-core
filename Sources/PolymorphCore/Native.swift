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
        "dictionary": .map
    ]

    // MARK: Properties

    public var name: String

    public internal(set) weak var project: Project? = nil

    // MARK: Initializers

    internal init(type: DataType) {
        self.name = type.rawValue
    }
}

extension Native: Hashable {

    public var hashValue: Int {
        return self.name.hashValue
    }

    public static func ==(lhs: Native, rhs: Native) -> Bool {
        return lhs.name == rhs.name
    }
}
