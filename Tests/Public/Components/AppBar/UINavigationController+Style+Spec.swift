import Nimble
import Quick

@testable import NatDS

final class UINavigationControllerStyleSpec: QuickSpec {
    override func spec() {
        var sut: UINavigationController.Style!

        beforeEach {
            ConfigurationStorage.shared.currentTheme = StubTheme()
        }

        describe("#default") {
            beforeEach {
                sut = .default
            }
            it("returns expected color for background") {
                let expectedColor = getUIColorFromTokens(\.colorSurface)
                expect(sut.backgroundColor).to(equal(expectedColor))
            }
            it("returns expected color for title") {
                let expectedColor = getUIColorFromTokens(\.colorHighEmphasis)
                expect(sut.titleColor).to(equal(expectedColor))
            }
            it("returns expected elevation") {
                let expectedElevation = NatElevation.Elevation.tiny
                expect(sut.elevation).to(equal(expectedElevation))
            }
        }
    }
}
