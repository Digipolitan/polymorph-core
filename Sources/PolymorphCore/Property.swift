//
//  Property.swift
//  PolymorphCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public class Property: Member, Documentable, Codable {

    public struct Mapping: Codable {

        public struct TransformerConfiguration: Codable {

            enum CodingKeys: String, CodingKey {
                case transformer
                case options
            }

            public var transformer: UUID
            public var options: [Transformer.Option]

            public init(transformer: UUID, options: [Transformer.Option] = []) {
                self.transformer = transformer
                self.options = options
            }
        }

        enum CodingKeys: String, CodingKey {
            case key
            case transformer
            case isIgnored
        }

        public var key: String?
        public var transformer: TransformerConfiguration?
        public var isIgnored: Bool

        public init(key: String? = nil, transformer: TransformerConfiguration? = nil) {
            self.key = key
            self.transformer = transformer
            self.isIgnored = false
        }

        public static func ignored() -> Mapping {
            var mapping = Mapping()
            mapping.isIgnored = true
            return mapping
        }
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case name
        case mapping
        case type
        case genericTypes
        case documentation
        case isPrimary
        case isNonnull
        case isConst
        case isTransient
        case defaultValue
    }

    // MARK: Properties

    public var name: String

    public var mapping: Mapping?

    public var type: UUID

    public var genericTypes: [UUID]?
    
    public var documentation: String?

    public var isPrimary: Bool = false

    public var isNonnull: Bool = false

    public var isConst: Bool = false

    public var isTransient: Bool = false

    public var defaultValue: String?

    public internal(set) weak var project: Project? = nil

    // MARK: Initializers

    public init(name: String, type: UUID, genericTypes: [UUID]? = nil) {
        self.name = name
        self.type = type
        self.genericTypes = genericTypes
    }

    // MARK: Linked

    public func isLinked(to uuid: UUID) -> Bool {
        if self.type == uuid {
            return true
        }
        if let gt = self.genericTypes {
            return gt.contains(uuid)
        }
        return false
    }
}

extension Property: Hashable {

    public var hashValue: Int {
        return self.name.hashValue
    }

    public static func ==(lhs: Property, rhs: Property) -> Bool {
        return lhs.name == rhs.name
    }
}
