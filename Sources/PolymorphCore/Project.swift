//
//  Project.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public class Project: Packageable, Documentable {

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case name
        case package
        case documentation
        case version
        case author
        case copyright
        case models
    }

    // MARK: Properties

    public var name: String

    public var package: Package

    public var documentation: String?

    public var version: String

    public var author: String?

    public var copyright: String?

    public var models: Models

    // MARK: Initializers

    public init(name: String, package: Package) {
        self.name = name
        self.package = package
        self.version = "1.0"
        self.models = Models()
        defer {
            self.models.project = self
        }
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.package = try container.decode(Package.self, forKey: .package)
        self.documentation = try container.decodeIfPresent(String.self, forKey: .documentation)
        self.version = try container.decode(String.self, forKey: .version)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
        self.models = try container.decode(Models.self, forKey: .models)
        defer {
            self.models.project = self
        }
    }
}
