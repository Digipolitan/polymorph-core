import XCTest
@testable import PolymorphCore

class PolymorphCoreTests: XCTestCase {

    func testEncodeEmptyProject() {
        guard let package = try? Package(string: "com.digipolitan.sample") else {
            XCTFail("Cannot create package")
            return
        }
        let proj = Project(name: "Sample", package: package)

        let encoder = JSONEncoder()
        if let data = try? encoder.encode(proj),
            let json = String(data: data, encoding: .utf8) {
            print(json)
        }

        let str = """
        {"package":{"value":"com.digipolitan.sample"},"name":"Sample","version":"1.0.0"}
        """

        let decoder = JSONDecoder()
        do {
            let project = try decoder.decode(Project.self, from: str.data(using: .utf8)!)
            print(project)
        } catch {
            print(error)
        }
    }

    static var allTests: [(String, (PolymorphCoreTests) -> () -> Void)] = [
        ("testEncodeEmptyProject", testEncodeEmptyProject)
    ]
}
