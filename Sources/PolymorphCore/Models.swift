//
//  Models.swift
//  PolymorphCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public class Models: Documentable, Codable {

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case documentation
        case classes
        case enums
        case externals
    }

    // MARK: Properties

    public var documentation: String?

    public private(set) var classes: [UUID: Class]
    public private(set) var enums: [UUID: Enum]
    public private(set) var externals: [UUID: External]

    public internal(set) weak var project: Project? = nil {
        didSet {
            self.classes.values.forEach { $0.project = self.project }
            self.enums.values.forEach { $0.project = self.project }
            self.externals.values.forEach { $0.project = self.project }
        }
    }

    // MARK: Initializers

    public init() {
        self.classes = [:]
        self.enums = [:]
        self.externals = [:]
    }

    // MARK: Objects

    public func findObject(uuid: UUID) -> Object? {
        if let cl = self.classes[uuid] {
            return cl
        }
        if let en = self.enums[uuid] {
            return en
        }
        return self.externals[uuid]
    }

    public func findObject(name: String) -> Object? {
        if let clazz = self.findClass(name: name) {
            return clazz
        }
        if let enu = self.findEnum(name: name) {
            return enu
        }
        return self.findExternal(name: name)
    }

    public func searchObjects(matching: String) -> [Object] {
        var objects: [Object] = []
        objects += self.searchClasses(matching: matching) as [Object]
        objects += self.searchEnums(matching: matching) as [Object]
        objects += self.searchExternals(matching: matching) as [Object]
        return objects
    }

    // MARK: Classes

    @discardableResult
    public func addClass(_ newClass: Class) -> Bool {
        guard self.classes[newClass.id] == nil else {
            return false
        }
        self.classes[newClass.id] = newClass
        return true
    }

    @discardableResult
    public func removeClass(uuid: UUID) -> Bool {
        guard self.classes[uuid] != nil else {
            return false
        }
        self.classes[uuid] = nil
        return true
    }

    public func findClass(name: String) -> Class? {
        return self.classes.first { $0.value.name == name }?.value
    }

    public func searchClasses(matching: String) -> [Class] {
        return self.classes.values.filter { $0.name.range(of: matching, options: .caseInsensitive) != nil }
    }

    public func searchClasses(linkedTo uuid: UUID) -> [Class] {
        return self.classes.values.filter { $0.isLinked(to: uuid) }
    }

    // MARK: Enums

    @discardableResult
    public func addEnum(_ newEnum: Enum) -> Bool {
        guard self.enums[newEnum.id] == nil else {
            return false
        }
        self.enums[newEnum.id] = newEnum
        return true
    }

    @discardableResult
    public func removeEnum(uuid: UUID) -> Bool {
        guard self.enums[uuid] != nil else {
            return false
        }
        self.enums[uuid] = nil
        return true
    }

    public func findEnum(name: String) -> Enum? {
        return self.enums.first { $0.value.name == name }?.value
    }

    public func searchEnums(matching: String) -> [Enum] {
        return self.enums.values.filter { $0.name.range(of: matching, options: .caseInsensitive) != nil }
    }

    // MARK: External

    @discardableResult
    public func addExternal(_ newExternal: External) -> Bool {
        guard self.externals[newExternal.id] == nil else {
            return false
        }
        self.externals[newExternal.id] = newExternal
        return true
    }

    @discardableResult
    public func removeExternal(uuid: UUID) -> Bool {
        guard self.externals[uuid] != nil else {
            return false
        }
        self.externals[uuid] = nil
        return true
    }

    public func findExternal(name: String) -> External? {
        return self.externals.first { $0.value.name == name }?.value
    }

    public func searchExternals(matching: String) -> [External] {
        return self.externals.values.filter { $0.name.range(of: matching, options: .caseInsensitive) != nil }
    }
}
