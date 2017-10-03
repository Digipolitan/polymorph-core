//
//  Package.swift
//  PolymorphCore
//
//  Created by Benoit BRIATTE on 26/06/2017.
//

import Foundation
import StringCase

public struct Package: Codable {

    public let value: String

    private static let trimCharacters = CharacterSet(charactersIn: ".")

    private static let availableCharacters = CharacterSet(charactersIn: ".abcdefghijklmnopqrstuvwxyz0123456789_")

    public static func check(string: String) throws {
        for ch in string {
            for scalar in ch.unicodeScalars {
                if !Package.availableCharacters.contains(scalar) {
                    throw PolymorphCoreError.notAvailableInPackage(character: ch)
                }
            }
        }
    }

    public init(string: String) throws {
        try Package.check(string: string)
        self.value = string.trimmingCharacters(in: Package.trimCharacters)
    }

    public func append(package: Package) throws -> Package {
        if package.value.count > 0 {
            if self.value.count > 0 {
                return try Package(string: self.value + "." + package.value)
            }
            return package
        }
        return self
    }

    public func append(string: String) throws -> Package {
        if string.count > 0 {
            if self.value.count > 0 {
                return try Package(string: self.value + "." + string)
            }
            return try Package(string: string)
        }
        return self
    }

    public func toArray() -> [String] {
        return self.value.split(separator: ".").map { String($0) }
    }

    public func path(camelcase: Bool) -> String {
        if camelcase {
            return self.toArray().map { $0.camelCased(.capitalized) }.joined(separator: "/")
        }
        return self.toArray().joined(separator: "/")
    }
}
