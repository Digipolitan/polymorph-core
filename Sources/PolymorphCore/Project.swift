//
//  Project.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public class Project: Object, Packageable {

    // MARK: Properties

    public var id: UUID

    public var name: String

    public var package: String

    public var documentation: String?

    public var version: String

    public var author: String

    public var copyright: String

    public var models: Models

    // MARK: Initializers

    public init(name: String, package: String, author: String, copyright: String, version: String = "1.0") {
        self.id = UUID()
        self.name = name
        self.package = package
        self.author = author
        self.copyright = copyright
        self.version = version
        self.models = Models()
    }
}
