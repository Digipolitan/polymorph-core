//
//  Packageable.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public protocol Packageable: Codable {
    var package: Package { get set }
}

public extension Packageable {
    
    public func merge(parent: Packageable) throws -> Package {
        return try parent.package.append(package: self.package)
    }
}

