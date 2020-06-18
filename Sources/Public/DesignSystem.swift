/**
  DesignSystem is a class entry point of configurations for this framework.

    Exemple of usage:

            DesignSystem().configure(brand: .avon)
            //or
            DesignSystem().configure(brand: .theBodyShop)

 - Note:
    Current Supported Brands:
        - Avon
        - Natura
        - The Body Shop
 
 - Requires:
        It's necessary to configure the Design System current Brand first
        or fatalError will be raised.

            DesignSystem().configure(with: Brand)
*/

public final class DesignSystem {

    // MARK: - Private properties

    private let storage: ConfigurationStorable

    // MARK: - Inits

    public convenience init() {
        self.init(storage: ConfigurationStorage.shared)
    }

    init(storage: ConfigurationStorable) {
        self.storage = storage
    }

    // MARK: - Public

    public enum Brand {
        case avon
        case natura
        case theBodyShop
    }

    public func configure(with brand: Brand) {
        switch brand {
        case .avon: storage.save(theme: AvonTheme())
        case .natura: storage.save(theme: NaturaTheme())
        case .theBodyShop: storage.save(theme: TheBodyShopTheme())
        }
    }

    public var currentBrand: Brand? {
        let theme = storage.getTheme()
        return getBrandFrom(theme: theme)
    }

    // MARK: - Private methods

    private func getBrandFrom(theme: Theme?) -> Brand? {
        let brand: Brand?

        switch theme {
        case is AvonTheme: brand = .avon
        case is NaturaTheme: brand = .natura
        case is TheBodyShopTheme: brand = .theBodyShop
        default: brand = nil
        }
        return brand
    }
}
