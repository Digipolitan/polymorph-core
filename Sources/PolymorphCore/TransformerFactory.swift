//
//  TransformerFactory.swift
//  PolymorphCore
//
//  Created by Benoit BRIATTE on 18/09/2017.
//

import Foundation

internal class TransformerFactory {

    public static func create(project: Project) -> [UUID: Transformer] {
        let transformers = [
            Transformer(name: "timestamp"),
            Transformer(name: "date", options: [
                .init(name: "format", required: true, value: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
            ]),
            Transformer(name: "url", options: [
                .init(name: "encode", required: true, value: "false")
            ])
        ]
        var idx = 1
        var result = [UUID: Transformer]()
        transformers.forEach {
            guard let uuid = UUID(uuidString: "00000002-0000-0000-0000-\(String(format: "%012d", idx))") else {
                return
            }
            $0.project = project
            result[uuid] = $0
            idx += 1
        }
        return result
    }
}
