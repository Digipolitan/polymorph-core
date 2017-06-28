//
//  NativeFactory.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

internal class NativeFactory {

    public static func create() -> [Native] {
        let dataTypes: [Native.DataType] = [
            .int,
            .bool,
            .double,
            .float,
            .date,
            .string,
            .data,
            .array,
            .map
        ];
        return dataTypes.map { Native(type: $0) }
    }
}
