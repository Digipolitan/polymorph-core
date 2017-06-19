import XCTest
@testable import PolymorpthCore

class PolymorpthCoreTests: XCTestCase {

    func testEncodeEmptyProject() {
        
        let p = Project(name: "Sample", package: "com.digipolitan.sample", author: "Digipolitan", copyright: "Digipolitan 2014")

        var c = Class(name: "person", package: "persons")
        c.addProperty(Property(name: "firstName", type: p.models.findNative(type: .string)!.id))
        c.addProperty(Property(name: "lastName", type: p.models.findNative(type: .string)!.id))
        c.addProperty(Property(name: "age", type: p.models.findNative(type: .int)!.id))
        p.models.addObject(c)

        let e = Enum(name: "STATUS", package: "enum", values: [
            Enum.Value(name: "OK", numeric: 200),
            Enum.Value(name: "CREATED", numeric: 201)
            ])
        p.models.addObject(e)

        var c2 = Class(name: "User", package: "users", extends: c.id)
        c2.addProperty(Property(name: "token", type: p.models.findNative(type: .string)!.id))

        p.models.addObject(c2)

        let encoder = JSONEncoder()
        if let data = try? encoder.encode(p),
            let json = String(data: data, encoding: .utf8) {
            print(json)
        }
    }

    func testDecodeEmptyProject() {

        let json = """
        {"author":"Digipolitan","title":"Sample","copyright":"Digipolitan 2014","models":{"classes":[]},"version":"1.0"}
        """
        if let data = json.data(using: .utf8) {
            let decoder = JSONDecoder()
            if let p = try? decoder.decode(Project.self, from: data) {
                print(p.version)
            }
        }
    }

    static var allTests: [(String, (PolymorpthCoreTests) -> () -> Void)] = [
        ("testEncodeEmptyProject", testEncodeEmptyProject),
        ("testDecodeEmptyProject", testDecodeEmptyProject)
    ]
}
