//
//  NativeFactory.swift
//  PolymorphCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

internal class NativeFactory {

    internal static let dataTypes: [Native.DataType] = [
        .int,
        .bool,
        .double,
        .float,
        .date,
        .string,
        .data,
        .array,
        .map
    ]

    internal static func create(project: Project) -> [UUID: Native] {
        var idx = 1
        var natives = [UUID: Native]()
        NativeFactory.dataTypes.forEach {
            guard let uuid = UUID(uuidString: "NATIVEID-0000-0000-0000-\(String(format: "%012d", idx))") else {
                return
            }
            let native = Native(type: $0)
            native.project = project
            natives[uuid] = native
            idx += 1
        }
        return natives
    }
}
