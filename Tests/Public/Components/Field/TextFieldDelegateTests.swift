import XCTest

@testable import NatDS

final class TextFieldDelegateTests: XCTestCase {
    var delegateMock: TextFieldDelegateMock!
    var sut: TextField!

    override func setUp() {
        super.setUp()

        ConfigurationStorage.shared.currentTheme = StubTheme()

        delegateMock = TextFieldDelegateMock()
        sut = TextField(frame: CGRect(x: 0, y: 0, width: 328, height: 99))
        sut.backgroundColor = .white

        sut.title = "Label"
        sut.placeholder = "Placeholder"
        sut.helper = "Helper Text"
        sut.delegate = delegateMock
    }

    func test_textFieldDelegate_whenHasDelegateAndCallDidEndEditing_expectInvokeTextFieldDelegate() {
        sut.textFieldDidEndEditing(sut.textField)

        XCTAssertEqual(delegateMock.invokedDidEndEditing.count, 1)
        XCTAssertEqual(delegateMock.invokedDidEndEditing.field, sut)
    }

    func test_textFieldDelegate_whenHasDelegateAndCallDidBeginEditing_expectInvokeTextFieldDelegate() {
        sut.textFieldDidBeginEditing(sut.textField)

        XCTAssertEqual(delegateMock.invokedDidBeginEditing.count, 1)
        XCTAssertEqual(delegateMock.invokedDidBeginEditing.field, sut)
    }

    func test_textFieldDelegate_whenHasDelegateAndCallShouldBeginEditing_expectInvokeTextFieldDelegate() {
        _ = sut.textFieldShouldBeginEditing(sut.textField)

        XCTAssertEqual(delegateMock.invokedDidShouldBeginEditing.count, 1)
        XCTAssertEqual(delegateMock.invokedDidShouldBeginEditing.field, sut)
    }

    func test_textFieldDelegate_whenHasDelegateAndCallShouldChangeCharacterInRange_expectInvokeTextFieldDelegate() {
        _ = sut.textField(sut.textField, shouldChangeCharactersIn: NSRange(), replacementString: "")

        XCTAssertEqual(delegateMock.invokedTextFieldChangeCharInRange.count, 1)
        XCTAssertEqual(delegateMock.invokedTextFieldChangeCharInRange.field, sut)
    }
}