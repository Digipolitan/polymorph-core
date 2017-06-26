//
//  Models.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public class Models: Documentable {

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case documentation
        case classes
        case enums
        case natives
    }

    // MARK: Properties

    public var documentation: String?

    private var objects: [UUID: Object] = [:]

    public private(set) var classes: Set<Class> {
        didSet {
            let remove = oldValue.filter { !self.classes.contains($0) }
            let add = self.classes.filter { !oldValue.contains($0) }
            remove.forEach { self.objects[$0.id] = nil }
            add.forEach { self.objects[$0.id] = $0 }
        }
    }

    public private(set) var enums: Set<Enum> {
        didSet {
            let remove = oldValue.filter { !self.enums.contains($0) }
            let add = self.enums.filter { !oldValue.contains($0) }
            remove.forEach { self.objects[$0.id] = nil }
            add.forEach { self.objects[$0.id] = $0 }
        }
    }

    public private(set) var natives: Set<Native> {
        didSet {
            oldValue.forEach { self.objects[$0.id] = nil }
            self.natives.forEach { self.objects[$0.id] = $0 }
        }
    }

    // MARK: Initializers

    public init() {
        self.classes = []
        self.enums = []
        self.natives = NativeFactory.create()
    }

    // MARK: Objects

    public func findObject(uuid: UUID) -> Object? {
        self.checkIntegrity()
        return self.objects[uuid]
    }

    public func searchObjects(matching: String) -> [Object] {
        self.checkIntegrity()
        return self.objects.filter { $0.value.name.range(of: matching, options: .caseInsensitive) != nil }.map { $0.value }
    }

    @discardableResult
    public func addObject(_ object: Object) -> Bool {
        self.checkIntegrity()
        if let c = object as? Class {
            return self.classes.insert(c).inserted
        } else if let e = object as? Enum {
            return self.enums.insert(e).inserted
        }
        return false
    }

    @discardableResult
    public func removeObject(uuid: UUID) -> Bool {
        self.checkIntegrity()
        if let o = self.findObject(uuid: uuid) {
            if let c = o as? Class {
                return self.classes.remove(c) != nil
            } else if let e = o as? Enum {
                return self.enums.remove(e) != nil
            }
        }
        return false
    }

    @discardableResult
    public func updateObject(_ object: Object) -> Bool {
        return self.removeObject(uuid: object.id) && self.addObject(object)
    }

    // MARK: Classes

    public func findClass(name: String) -> Class? {
        return self.classes.first { $0.name == name }
    }

    public func searchClasses(matching: String) -> [Class] {
        return self.classes.filter { $0.name.range(of: matching, options: .caseInsensitive) != nil }
    }

    public func searchClasses(linkedTo uuid: UUID) -> [Class] {
        return self.classes.filter { $0.isLinked(to: uuid) }
    }

    // MARK: Enums

    public func findEnum(name: String) -> Enum? {
        return self.enums.first { $0.name == name }
    }

    public func searchEnum(matching: String) -> [Enum] {
        return self.enums.filter { $0.name.range(of: matching, options: .caseInsensitive) != nil }
    }

    // MARK: Natives

    public func findNative(type: Native.DataType) -> Native? {
        return self.natives.first { $0.name == type.rawValue }
    }

    // MARK: Private

    private func checkIntegrity() {
        if self.objects.count == 0 {
            self.classes.forEach { self.objects[$0.id] = $0 }
            self.enums.forEach { self.objects[$0.id] = $0 }
            self.natives.forEach { self.objects[$0.id] = $0 }
        }
    }
}
