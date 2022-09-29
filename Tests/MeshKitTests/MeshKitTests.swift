import XCTest
@testable import MeshKit

final class MeshKitTests: XCTestCase {

    func testExportMesh() {
        self.measure(metrics: [XCTMemoryMetric()]) {
            let exp = expectation(description: "Finished")
            Task {
                let mesh = MeshKit.mesh(
                    of: .square(of: 5),
                    colors: [
                        .red, .red, .red, .red, .red,
                        .red, .orange, .yellow, .orange, .red,
                        .red, .yellow, .white, .yellow, .red,
                        .red, .orange, .yellow, .orange, .red,
                        .red, .red, .red, .red, .red,
                    ]
                )
                do {
                    let url = try await mesh.export(
                        size: .init(width: 2560, height: 1600),
                        subdivisions: 18,
                        colorSpace: .init(name: CGColorSpace.displayP3)
                    )
                    print(url.path)
                } catch {
                    print(error)
                }

                exp.fulfill()
            }

            wait(for: [exp], timeout: 200.0)
        }
    }
}
