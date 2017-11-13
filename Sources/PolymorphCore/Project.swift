//
//  Project.swift
//  PolymorphCore
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
        case network
    }

    // MARK: Properties

    public var name: String

    public var package: Package

    public var documentation: String?

    public var version: String

    public var author: String?

    public var copyright: String?

    public var models: Models

    public var network: Network

    public lazy var natives: [UUID: Native] = {
        return NativeFactory.create(project: self)
    }()

    public lazy var transformers: [UUID: Transformer] = {
        return TransformerFactory.create(project: self)
    }()

    // MARK: Initializers

    public init(name: String, package: Package) {
        self.name = name
        self.package = package
        self.version = Polymorph.version
        self.models = Models()
        self.network = Network()
        defer {
            self.models.project = self
            self.network.project = self
        }
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let version = try container.decode(String.self, forKey: .version)
        let comparisonResult = Polymorph.compare(version: version)
        guard comparisonResult == .orderedSame else {
            if comparisonResult == .orderedAscending {
                throw PolymorphCoreError.polymorphCoreOutdated(version: version)
            }
            throw PolymorphCoreError.projectOutdated(version: version)
        }
        self.version = version
        self.name = try container.decode(String.self, forKey: .name)
        self.package = try container.decode(Package.self, forKey: .package)
        self.documentation = try container.decodeIfPresent(String.self, forKey: .documentation)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
        self.models = try container.decode(Models.self, forKey: .models)
        self.network = try container.decode(Network.self, forKey: .network)
        defer {
            self.models.project = self
            self.network.project = self
        }
    }

    // MARK: Natives

    public func findNative(type: Native.DataType) -> UUID? {
        return self.natives.first { $0.value.name == type.rawValue }?.key
    }

    public func findNative(name: String) -> UUID? {
        guard let dataType = Native.DataType.from(string: name) else {
            return nil
        }
        return self.findNative(type: dataType)
    }

    public func searchNatives(matching: String) -> [UUID: Native] {
        return self.natives.filter {  $0.value.name.range(of: matching, options: .caseInsensitive) != nil }
    }

    // MARK: Transformers

    public func findTransformer(name: String) -> UUID? {
        return self.transformers.first { $0.value.name == name }?.key
    }

    public func searchTransformers(matching: String) -> [UUID: Transformer] {
        return self.transformers.filter { $0.value.name.range(of: matching, options: .caseInsensitive) != nil }
    }

}
