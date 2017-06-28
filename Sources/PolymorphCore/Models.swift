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

    public internal(set) weak var project: Project? = nil {
        didSet {
            self.classes = self.classes.map {
                var c = $0
                c.project = self.project
                self.objects[c.id] = c
                return c
            }
            self.enums = self.enums.map {
                var e = $0
                e.project = self.project
                self.objects[e.id] = e
                return e
            }
            self.natives = self.natives.map {
                var n = $0
                n.project = self.project
                self.objects[n.id] = n
                return n
            }
        }
    }

    public private(set) var classes: [Class] {
        didSet {
            let remove = oldValue.filter { !self.classes.contains($0) }
            let add = self.classes.filter { !oldValue.contains($0) }
            remove.forEach { self.objects[$0.id] = nil }
            add.forEach { self.objects[$0.id] = $0 }
        }
    }

    public private(set) var enums: [Enum] {
        didSet {
            let remove = oldValue.filter { !self.enums.contains($0) }
            let add = self.enums.filter { !oldValue.contains($0) }
            remove.forEach { self.objects[$0.id] = nil }
            add.forEach { self.objects[$0.id] = $0 }
        }
    }

    public private(set) var natives: [Native] {
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
        return self.objects[uuid]
    }

    public func findObject(name: String) -> Object? {
        if let dataType = Native.DataType.from(string: name) {
            return self.findNative(type: dataType)
        }
        if let c = self.findClass(name: name) {
            return c
        }
        return self.findEnum(name: name)
    }

    public func searchObjects(matching: String) -> [Object] {
        return self.objects.filter { $0.value.name.range(of: matching, options: .caseInsensitive) != nil }.map { $0.value }
    }

    @discardableResult
    public func addObject(_ object: Object) -> Bool {
        if let c = object as? Class {
            guard !self.classes.contains(c) else {
                return false
            }
            self.classes.append(c)
            return true
        } else if let e = object as? Enum {
            guard !self.enums.contains(e) else {
                return false
            }
            self.enums.append(e)
            return true
        }
        return false
    }

    @discardableResult
    public func removeObject(uuid: UUID) -> Bool {
        if let o = self.findObject(uuid: uuid) {
            if let c = o as? Class {
                guard let idx = self.classes.index(of: c) else {
                    return false
                }
                self.classes.remove(at: idx)
                return true
            } else if let e = o as? Enum {
                guard let idx = self.enums.index(of: e) else {
                    return false
                }
                self.enums.remove(at: idx)
                return true
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
}
