/**
  Representation of available themes in Design System.

 - Note:
    Supported Themes:
      - AvonDark
      - AvonLight
      - NaturaDark
      - NaturaLight
      - TheBodyShopDark
      - TheBodyShopLight

 - Warning:
    Under development.
*/

public enum AvailableTheme {
    case avonDark
    case avonLight
    case naturaDark
    case naturaLight
    case theBodyShopDark
    case theBodyShopLight

    init?(theme: ThemeProtocol) {
        switch theme {
        case is AvonDarkTheme: self = .avonDark
        case is AvonLightTheme: self = .avonLight
        case is NaturaDarkTheme: self = .naturaDark
        case is NaturaLightTheme: self = .naturaLight
        case is TheBodyShopDarkTheme: self = .theBodyShopDark
        case is TheBodyShopLightTheme: self = .theBodyShopLight
        default: return nil
        }
    }

    var newInstance: ThemeProtocol {
        let instance: ThemeProtocol

        switch self {
        case .avonDark: instance = AvonDarkTheme()
        case .avonLight: instance = AvonLightTheme()
        case .naturaDark: instance = NaturaDarkTheme()
        case .naturaLight: instance = NaturaLightTheme()
        case .theBodyShopDark: instance = TheBodyShopDarkTheme()
        case .theBodyShopLight: instance = TheBodyShopLightTheme()
        }

        return instance
    }
}
