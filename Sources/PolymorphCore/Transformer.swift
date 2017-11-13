//
//  Transformer.swift
//  PolymorphCore
//
//  Created by Benoit BRIATTE on 18/09/2017.
//

import Foundation

public class Transformer: Member {

    public struct Option: Codable {

        enum CodingKeys: String, CodingKey {
            case name
            case required
            case value
        }

        public let name: String
        public let required: Bool
        public let value: String?

        public init(name: String, required: Bool = false, value: String? = nil) {
            self.name = name
            self.required = required
            self.value = value
        }

        public func update(_ value: String?) -> Option {
            return Option(name: self.name, required: self.required, value: value)
        }
    }

    public let name: String
    public let options: [Option]
    public internal(set) weak var project: Project?

    internal init(name: String, options: [Option] = []) {
        self.name = name
        self.options = options
    }
}

extension Transformer: Hashable {

    public var hashValue: Int {
        return self.name.hashValue
    }

    public static func == (lhs: Transformer, rhs: Transformer) -> Bool {
        return lhs.name == rhs.name
    }
}
