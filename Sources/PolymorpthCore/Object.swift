//
//  Object.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public protocol Object: Documentable {
    var id: UUID { get }
    var name: String { get set }
}
