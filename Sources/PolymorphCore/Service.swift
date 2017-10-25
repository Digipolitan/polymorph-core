//
//  Service.swift
//  PolymorphCore
//
//  Created by Benoit BRIATTE on 23/10/2017.
//

import Foundation

public class Service: Object, Documentable, Packageable {

    public enum Transformer: String, Codable {
        case raw
        case string
        case json
        case xml
        case yaml

        public func all() -> [Transformer] {
            return [
                .raw,
                .string,
                .json,
                .xml,
                .yaml
            ]
        }
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case package
        case documentation
        case serializer
        case parser
        case endpoints
    }

    // MARK: Properties

    public var id: UUID

    public var name: String

    public var package: Package

    public var documentation: String?

    public var serializer: Transformer

    public var parser: Transformer

    public var endpoints: [Endpoint]

    public internal(set) weak var project: Project? = nil {
        didSet {
            self.endpoints.forEach { $0.project = self.project }
        }
    }

    public init(name: String, package: Package, serializer: Transformer = .json, parser: Transformer = .json) {
        self.id = UUID()
        self.name = name
        self.package = package
        self.serializer = serializer
        self.parser = parser
        self.endpoints = []
    }

    // MARK: Linked

    public func isLinked(to uuid: UUID) -> Bool {
        return self.endpoints.first { $0.isLinked(to: uuid) } != nil
    }
}
