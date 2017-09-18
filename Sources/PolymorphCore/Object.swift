//
//  Object.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public protocol Object: Member {
    var id: UUID { get }
}
