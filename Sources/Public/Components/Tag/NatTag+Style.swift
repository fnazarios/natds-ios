extension NatTag {
    /**
     Style represents styles values for the NatTag component.

        These are all allowed styles for a NatTag:
        - default (centered)
        - left
        - right
    */

    public struct Style {
        let applyStyle: (NatTag) -> Void

        public static var defaultAlert: NatTag.Style {
            .init { tag in
                NatTagStyle.applyAlert(position: .default, on: tag)
            }
        }

        public static var leftAlert: NatTag.Style {
            .init { tag in
                NatTagStyle.applyAlert(position: .left, on: tag)
            }
        }

        public static var rightAlert: NatTag.Style {
            .init { tag in
                NatTagStyle.applyAlert(position: .right, on: tag)
            }
        }
    }
}

enum NatTagStyle {
    static func applyAlert(position: NatTag.Position, on tag: NatTag) {
        tag.configure(path: getUIColorFromTokens(\.colorPrimary), position: position)
        tag.configure(textColor: getUIColorFromTokens(\.colorOnPrimary))
    }
}
