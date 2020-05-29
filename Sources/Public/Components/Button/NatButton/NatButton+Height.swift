extension NatButton {
    /**
      Height is a enum that represents height values for the button component.

        This is all sizes allowed for a NatButton:
        - small
        - medium
        - large

        usage example:

            button.heightAnchor.constraint(equalToConstant: NatButton.Height.medium)

     - Requires:
            It's necessary to configure the Design System current Brand at DesisgnSystem class
            or fatalError will be raised.

                DesignSystem().configure(with: Brand)
    */

    public enum Height {
        public static var small: CGFloat { getTheme().sizes.semi }
        public static var medium: CGFloat { getTheme().sizes.semiX }
        public static var large: CGFloat { getTheme().sizes.medium }
    }
}