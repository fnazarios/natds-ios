import UIKit
import NatDS

class BadgeViewController: UIViewController, SampleItem {
    static var name: String = "Badge"

    private lazy var badgeableViewDot: BadgeableView = {
        let view = BadgeableView(frame: .init(x: 0, y: 0, width: 24, height: 24))
        view.configure(badgeStyle: .dot, withColor: .alert)
        return view
    }()

    private lazy var badgeableViewPulse: BadgeableView = {
        let view = BadgeableView(frame: .init(x: 0, y: 0, width: 24, height: 24))
        view.configure(badgeStyle: .pulse, withColor: .success)
        return view
    }()

    private lazy var badgeableViewOneChartStandard: BadgeableView = {
        let view = BadgeableView(frame: .init(x: 0, y: 0, width: 24, height: 24))
        view.configure(badgeStyle: .standard, withColor: .primary)
        view.setBadge(count: 100)
        view.configure(limit: .max9)
        return view
    }()

    private lazy var badgeableViewTwoCharStandard: BadgeableView = {
        let view = BadgeableView(frame: .init(x: 0, y: 0, width: 24, height: 24))
        view.configure(badgeStyle: .standard, withColor: .secondary)
        view.setBadge(count: 100)
        view.configure(limit: .max99)
        return view
    }()

    private lazy var badgeableViewThreeCharStandard: BadgeableView = {
        let view = BadgeableView(frame: .init(x: 0, y: 0, width: 24, height: 24))
        view.configure(badgeStyle: .standard, withColor: .success)
        view.setBadge(count: 1000)
        view.configure(limit: .unlimited)
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = NatSpacing.xLarge
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        title = Self.name
        view.backgroundColor = NatColors.background

        view.addSubview(stackView)
        stackView.addArrangedSubview(badgeableViewDot)
        stackView.addArrangedSubview(badgeableViewPulse)
        stackView.addArrangedSubview(badgeableViewOneChartStandard)
        stackView.addArrangedSubview(badgeableViewTwoCharStandard)
        stackView.addArrangedSubview(badgeableViewThreeCharStandard)

        let constraints = [
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 12)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
