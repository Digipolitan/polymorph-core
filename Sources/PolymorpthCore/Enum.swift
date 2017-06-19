//
//  Enum.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public struct Enum: Object, Packageable {

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

    public var package: String

    public var documentation: String?

    public var values: [Value]

    // MARK: Initializers

    public init(name: String, package: String, values: [Value] = []) {
        self.id = UUID()
        self.name = name
        self.package = package
        self.values = values
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
