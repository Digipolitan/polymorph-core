//
//  NativeFactory.swift
//  PolymorphCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

internal class NativeFactory {

    internal static func create(project: Project) -> [UUID: Native] {
        var idx = 1
        var natives = [UUID: Native]()
        Native.DataType.all().forEach {
            guard let uuid = UUID(uuidString: "00000001-0000-0000-0000-\(String(format: "%012d", idx))") else {
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
