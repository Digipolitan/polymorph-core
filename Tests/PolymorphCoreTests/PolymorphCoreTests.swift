import XCTest
@testable import PolymorphCore

class PolymorpthCoreTests: XCTestCase {

    func testEncodeEmptyProject() {

/*
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
 */
    }

    func testDecodeEmptyProject() {

        let json = """
        {"package":{"value":"com.medissimo"},"id":"456B43A9-65D6-4E60-A2D9-3E2522BC30F0","author":"Dig ipolitan","models":{"classes":[{"package":{"value":"person"},"id":"CDE3A31F-7A1D-4438-AB05-7F49D25F8F82","properties":[{"isTransient":false,"isPrimary":false,"name":"lastName","type":"7B4BAC0D-DB1D-4A4D-B7D7-3CC2E1D93D1C","isNonnull":true},{"isTransient":false,"isPrimary":false,"name":"firstName","type":"7B4BAC0D-DB1D-4A4D-B7D7-3CC2E1D93D1C","isNonnull":false},{"isNonnull":false,"isTransient":false,"isPrimary":false,"name":"objects","type":"00A73B1B-E2B4-4611-88BA-A4226B34C992","genericTypes":["7B4BAC0D-DB1D-4A4D-B7D7-3CC2E1D93D1C","70E929BB-FF8F-43CA-8AB5-FB1DDA59286D"]},{"isNonnull":false,"isTransient":false,"isPrimary":false,"name":"cars","type":"7B45BE5E-164C-410C-98E3-5602DD208A5B","genericTypes":["7B4BAC0D-DB1D-4A4D-B7D7-3CC2E1D93D1C"]},{"isNonnull":false,"isTransient":false,"isPrimary":false,"name":"oaze","type":"00A73B1B-E2B4-4611-88BA-A4226B34C992","genericTypes":["7B4BAC0D-DB1D-4A4D-B7D7-3CC2E1D93D1C","70E929BB-FF8F-43CA-8AB5-FB1DDA59286D"]}],"name":"P","serializable":true},{"package":{"value":"user"},"id":"CF8BB40F-113A-4BED-A0D8-5D35B2E1E6E7","properties":[],"name":"User","serializable":false,"extends":"CDE3A31F-7A1D-4438-AB05-7F49D25F8F82"},{"package":{"value":"user"},"id":"7E29F28E-AC08-431E-AFA8-6FE3D7C183AD","properties":[{"isTransient":false,"isPrimary":false,"name":"test","type":"CDE3A31F-7A1D-4438-AB05-7F49D25F8F82","isNonnull":false}],"name":"SuperUser","serializable":true,"extends":"CF8BB40F-113A-4BED-A0D8-5D35B2E1E6E7"}],"enums":[],"natives":[{"id":"00A73B1B-E2B4-4611-88BA-A4226B34C992","name":"Map"},{"id":"EE7AA367-962C-4832-9461-4DD37C8BD701","name":"Bool"},{"id":"7B4BAC0D-DB1D-4A4D-B7D7-3CC2E1D93D1C","name":"String"},{"id":"70E929BB-FF8F-43CA-8AB5-FB1DDA59286D","name":"Int"},{"id":"7B45BE5E-164C-410C-98E3-5602DD208A5B","name":"Array"},{"id":"70117129-9005-4AF8-A1B2-01CB99AF684C","name":"Date"},{"id":"C001B7A9-C5C5-42F4-8505-4C2524240A60","name":"Data"},{"id":"8A071EFE-6F74-41A6-80A4-63013FB74743","name":"Double"},{"id":"5ACCBCCC-A560-4F98-9DB5-7AB1DEB0A474","name":"Float"}]},"name":"Medissimo","version":"1.0"}
        """
        if let data = json.data(using: .utf8) {
            let decoder = JSONDecoder()
            let p = try! decoder.decode(Project.self, from: data)

                print(p.models.classes)

        }
    }

    static var allTests: [(String, (PolymorpthCoreTests) -> () -> Void)] = [
        ("testEncodeEmptyProject", testEncodeEmptyProject),
        ("testDecodeEmptyProject", testDecodeEmptyProject)
    ]
}
