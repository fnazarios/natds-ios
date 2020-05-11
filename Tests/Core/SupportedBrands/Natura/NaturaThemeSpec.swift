import Quick
import Nimble

@testable import NatDS

final class NaturaThemeSpec: QuickSpec {
    override func spec() {
        let systemUnderTest = NaturaTheme()

        describe("#lightColorPalette") {
            it("returns a instance of NaturaColorPaletteLight") {
                let colorPalette = systemUnderTest.lightColorPalette

                expect(colorPalette).to(beAnInstanceOf(NaturaColorPaletteLight.self))
            }
        }

        describe("#darkColorPalette") {
            it("returns a instance of NaturaColorPaletteDark") {
                let colorPalette = systemUnderTest.darkColorPalette

                expect(colorPalette).to(beAnInstanceOf(NaturaColorPaletteDark.self))
            }
        }

        describe("#sizes") {
            it("returns a instance of NaturaSizes") {
                let sizes = systemUnderTest.sizes

                expect(sizes).to(beAnInstanceOf(NaturaSizes.self))
            }
        }

        describe("#spacing") {
            it("returns a instance of NaturaSpacing") {
                let spacing = systemUnderTest.spacing

                expect(spacing).to(beAnInstanceOf(NaturaSpacing.self))
            }
        }

        describe("#borderRadius") {
            it("returns a instance of NaturaBorderRadius") {
                let borderRadius = systemUnderTest.borderRadius

                expect(borderRadius).to(beAnInstanceOf(NaturaBorderRadius.self))
            }
        }

        describe("#opacities") {
            it("returns a instance of NaturaOpacities") {
                let opacities = systemUnderTest.opacities

                expect(opacities).to(beAnInstanceOf(NaturaOpacities.self))
            }
        }

        describe("#font") {
            it("returns a instance of NaturaFont") {
                let font = systemUnderTest.font

                expect(font).to(beAnInstanceOf(NaturaFont.self))
            }
        }
    }
}
