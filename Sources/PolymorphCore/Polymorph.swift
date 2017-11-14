//
//  Polymorph.swift
//  PolymorphCore
//
//  Created by Benoit BRIATTE on 18/09/2017.
//

import Foundation

public class Polymorph {

    public static let version = "1.1.0"

    public static func compare(version: String) -> ComparisonResult {
        let current = Polymorph.version.split(separator: ".").map { return Int("\($0)") ?? 0 }
        let other = version.split(separator: ".").map { return Int("\($0)") ?? 0 }
        var idx = 0
        let currentCount = current.count
        let otherCount = other.count
        while idx < currentCount && idx < otherCount {
            if current[idx] > other[idx] {
                return ComparisonResult.orderedDescending
            } else if current[idx] < other[idx] {
                return ComparisonResult.orderedAscending
            }
            idx += 1
        }
        return ComparisonResult.orderedSame
    }

}
