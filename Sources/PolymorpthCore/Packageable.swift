//
//  Packageable.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public protocol Packageable: Codable {
    var package: String { get set }
}
