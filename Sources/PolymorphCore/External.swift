//
//  External.swift
//  PolymorphCore
//
//  Created by Benoit BRIATTE on 13/11/2017.
//

import Foundation

public class External: Object, Documentable, Packageable {

    public enum ExternalType: String, Codable {
        case `class`
        case interface
        case `enum`
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case package
        case documentation
        case type
    }

    // MARK: Properties

    public var id: UUID

    public var name: String

    public var package: Package

    public var documentation: String?

    public var type: ExternalType

    public var canonicalName: String? {
        guard
            let project = self.project,
            let package = try? self.merge(parent: project) else {
                return nil
        }
        return "\(package.value).\(self.name)"
    }

    public internal(set) weak var project: Project? = nil

    // MARK: Initializers

    public init(name: String, package: Package, type: ExternalType = .class) {
        self.id = UUID()
        self.name = name
        self.package = package
        self.type = type
    }
}

extension External: Hashable {

    public var hashValue: Int {
        return self.id.hashValue
    }

    public static func == (lhs: External, rhs: External) -> Bool {
        return lhs.name == rhs.name
    }
}
