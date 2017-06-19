//
//  NativeObject.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public struct Native: Object {

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
    }

    // MARK: Properties

    public var id: UUID

    public var name: String

    public var documentation: String?

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
