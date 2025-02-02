/**
 NatShortcut is a class that represents a component from the design system.
 The shortcut colors change according to the current theme configured in the Design System.

 This component has 4 styles:
    - Contained with Primary color
    - Contained with Default color
    - Outlined with Primary color
    - Outlined with Default color

 Example of usage:

        let containedPrimary = NatShortcut(style: .containedPrimary)

 - Requires:
 It's necessary to configure the Design System with a theme or fatalError will be raised.

        DesignSystem().configure(with: AvailableTheme)
 */

public final class NatShortcut: UIView {

    // MARK: - Private properties

    private let shortcutView: ShortcutView = {
        let view = ShortcutView(icon: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.font = NatFonts.font(ofSize: .caption, withWeight: .regular)
        label.textColor = getUIColorFromTokens(\.colorHighEmphasis)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let style: Style
    private let notificationCenter: NotificationCenterObservable
    private var action: (() -> Void)?

    // MARK: - Inits

    public convenience init(style: Style) {
        self.init(style: style, notificationCenter: NotificationCenter.default)
    }

    init(style: Style, notificationCenter: NotificationCenterObservable) {
        self.style = style
        self.notificationCenter = notificationCenter

        super.init(frame: .zero)

        style.applyStyle(self)
        setup()
    }

    // MARK: - Deinit

    deinit {
        notificationCenter.removeObserver(self)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - User interactions

    @objc func tapHandler(_ sender: UITapGestureRecognizer) {
        action?()

        addPulseLayerAnimated(at: shortcutView.centerBounds, in: shortcutView.layer, removeAfterAnimation: true)
    }

    @objc func longPressHandler(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            addPulseLayerAnimated(at: shortcutView.centerBounds, in: shortcutView.layer, removeAfterAnimation: true)
        case .ended:
            removePulseLayer(layer: shortcutView.layer)
        default:
            break
        }
    }
}

// MARK: - Public methods

extension NatShortcut {
    /// Sets an icon for the shortcut view
    /// - Parameter icon: An icon from NatDSIcons.
    /// Example of usage:
    ///
    ///     shortcut.configure(icon: getIcon(icon: .outlinedAlertNotification))
    public func configure(icon: String?) {
        shortcutView.configure(icon: icon)
    }

    /// Configures text for shortcut bottom label.
    /// - Parameter text: A string with the text to display on the label.
    public func configure(text: String) {
        label.text = text
    }

    /// Sets the functionality for the shortcut.
    /// - Parameter action: A block of functionality to be executed when the shorcut is pressed
    public func configure(action: @escaping () -> Void) {
        self.action = action
    }

    /// Configures a badge to the shortcut.
    /// - Parameter badge: A badge from the design system.
    /// The badge must be created and configured before setting it to the shortcut.
    ///
    /// Example of usage:
    /// ```
    /// let badge = NatBadge(style: .standard, color: .primary)
    /// badge.configure(limit: .max99)
    /// badge.configure(count: 100)
    /// shortcut.configure(badge: badge)
    /// ```
    public func configure(badge: NatBadge) {
        badge.addToView(shortcutView)
    }

    @available(*, deprecated, message: "Use configure(badge:) instead")
    public func configure(badgeValue: UInt) {
        shortcutView.configure(badgeValue: badgeValue)
    }
}

// MARK: - Internal methods

extension NatShortcut {
    func configure(circleColor color: UIColor) {
        shortcutView.backgroundColor = color
    }

    func configure(circleBorderWidth value: CGFloat) {
        shortcutView.layer.borderWidth = value
    }

    func configure(circleBorderColor color: CGColor) {
        shortcutView.layer.borderColor = color
    }

    func configure(iconColor color: UIColor) {
        shortcutView.configure(iconColor: color)
    }
}

// MARK: - Private methods - UI

extension NatShortcut {
    private func setup() {
        addSubview(shortcutView)
        addSubview(label)

        addConstraints()
        addGestures()

        notificationCenter.addObserver(
            self,
            selector: #selector(themeHasChanged),
            name: .themeHasChanged,
            object: nil
        )
    }

    private func addConstraints() {
        let circleSize = NatSizes.mediumX

        let constraints = [
            shortcutView.topAnchor.constraint(equalTo: topAnchor),
            shortcutView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            shortcutView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            shortcutView.centerXAnchor.constraint(equalTo: centerXAnchor),
            shortcutView.widthAnchor.constraint(equalToConstant: circleSize),
            shortcutView.heightAnchor.constraint(equalToConstant: circleSize),

            label.topAnchor.constraint(equalTo: shortcutView.bottomAnchor, constant: getTokenFromTheme(\.sizeTiny)),
            label.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            label.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.delaysTouchesBegan = true
        tapGesture.delaysTouchesEnded = true

        addGestureRecognizer(tapGesture)

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delaysTouchesBegan = true
        longPressGesture.delaysTouchesEnded = true

        addGestureRecognizer(longPressGesture)
    }
}

// MARK: - NotificationCenter

extension NatShortcut {
    @objc private func themeHasChanged() {
        style.applyStyle(self)
    }
}

// MARK: - Pulsable

extension NatShortcut: Pulsable {}
