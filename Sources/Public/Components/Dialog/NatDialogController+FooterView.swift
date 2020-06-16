private typealias ActionHandler = () -> Void

extension NatDialogController {
    final class FooterView: UIView {
        // MARK: - Private properties

        private let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.spacing = getTheme().spacing.tiny
            stackView.translatesAutoresizingMaskIntoConstraints = false

            return stackView
        }()

        private var primaryButtonActionHandler: ActionHandler?
        private var secondaryButtonActionHandler: ActionHandler?

        private var isFirstTimeInLayoutSubviews = true

        // MARK: - Inits

        init() {
            super.init(frame: .zero)

            setup()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - Inits

        deinit {
            NotificationCenter.default.removeObserver(self)
        }

        // MARK: - Overrides

        override func layoutSubviews() {
            super.layoutSubviews()

            if isFirstTimeInLayoutSubviews {
                adjustButtonsToFitScreen()
                isFirstTimeInLayoutSubviews = false
            }
        }

        // MARK: - Action handlers

        @objc private func primaryActionHandler() {
            primaryButtonActionHandler?()
        }

        @objc private func secondaryActionHandler() {
            secondaryButtonActionHandler?()
        }

        // MARK: - Public methods

        func configure(primaryButton configuration: ButtonConfiguration) {
            primaryButtonActionHandler = configuration.action

            let button = NatButton(style: .contained)
            button.configure(title: configuration.title)
            button.addTarget(self, action: #selector(primaryActionHandler), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false

            stackView.insertArrangedSubview(button, at: 0)

            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: NatButton.Height.medium)
            ])
        }

        func configure(secondaryButton configuration: ButtonConfiguration) {
            secondaryButtonActionHandler = configuration.action

            let button = NatButton(style: .text)
            button.configure(title: configuration.title)
            button.addTarget(self, action: #selector(secondaryActionHandler), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false

            stackView.insertArrangedSubview(button, at: 0)

            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: NatButton.Height.medium)
            ])
        }

        // MARK: - Private methods

        private func setup() {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(adjustButtonsToFitScreen),
                name: UIDevice.orientationDidChangeNotification,
                object: nil
            )

            addSubview(stackView)

            addConstraints()
        }

        @objc private func adjustButtonsToFitScreen() {
            stackView.axis = stackView.frame.width >= frame.width ? .vertical : .horizontal
        }

        private func addConstraints() {
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
                stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor)
            ])
        }
    }
}
