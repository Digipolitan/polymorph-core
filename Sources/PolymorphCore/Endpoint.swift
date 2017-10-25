//
//  Endpoint.swift
//  PolymorphCore
//
//  Created by Benoit BRIATTE on 23/10/2017.
//

import Foundation

public class Endpoint: Member, Documentable, Codable {

    public enum Method: String, Codable {
        case get
        case post
        case put
        case delete
        case options
        case trace
        case connect

        public func all() -> [Method] {
            return [
                .get,
                .post,
                .put,
                .delete,
                .options,
                .trace,
                .connect
            ]
        }
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case name
        case path
        case method
        case inputType
        case inputGenericTypes
        case outputType
        case outputGenericTypes
        case documentation
    }

    // MARK: Properties

    public var name: String

    public var path: String

    public var method: Method

    public var inputType: UUID

    public var inputGenericTypes: [UUID]?

    public var outputType: UUID

    public var outputGenericTypes: [UUID]?

    public var documentation: String?

    public internal(set) weak var project: Project? = nil

    // MARK: Initializers

    public init(name: String, path: String, method: Method, inputType: UUID, inputGenericTypes: [UUID]? = nil, outputType: UUID, outputGenericTypes: [UUID]? = nil) {
        self.name = name
        self.path = path
        self.method = method
        self.inputType = inputType
        self.inputGenericTypes = inputGenericTypes
        self.outputType = outputType
        self.outputGenericTypes = outputGenericTypes
    }

    // MARK: Linked

    public func isLinked(to uuid: UUID) -> Bool {
        if self.inputType == uuid || self.outputType == uuid {
            return true
        }
        if let gts = self.inputGenericTypes {
            if gts.contains(uuid) {
                return true
            }
        }
        if let gts = self.outputGenericTypes {
            return gts.contains(uuid)
        }
        return false
    }
}
