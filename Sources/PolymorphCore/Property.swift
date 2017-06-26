//
//  Property.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public struct Property: Documentable {

    // MARK: Properties

    public var name: String

    public var type: UUID

    public var genericTypes: [UUID]?
    
    public var documentation: String?

    public var isPrimary: Bool = false

    public var isNonnull: Bool = false

    public var isTransient: Bool = false

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
