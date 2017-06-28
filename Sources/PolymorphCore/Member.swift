//
//  Member.swift
//  PolymorphCore
//
//  Created by Benoit BRIATTE on 28/06/2017.
//

import Foundation

public protocol Member {

    var name: String { get }

    var project: Project? { get }
}
