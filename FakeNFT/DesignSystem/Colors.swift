import UIKit

extension UIColor {
    // Creates color from a hex string
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: CGFloat(alpha) / 255
        )
    }

    // MARK: - UniversalColors
    static let nftGreyUni = UIColor(hexString: "#625C5C")
    static let nftRedUni = UIColor(hexString: "#F56B6C")
    static let nftGreenUni = UIColor(hexString: "#1C9F00")
    static let nftBlueUni = UIColor(hexString: "#0A84FF")
    static let nftBlackUni = UIColor(hexString: "#1A1B22")
    static let nftWhiteUni = UIColor(hexString: "#FFFFFF")
    static let nftYellowUni = UIColor(hexString: "#FEEF0D")
    static let nftBackgroundUni = UIColor(hexString: "#1A1B2280").withAlphaComponent(0.5)
    
    // MARK: - DayNightColors
    
    private static let nftLightGreyDay = UIColor(hexString: "#F7F7F8")
    private static let nftLightGreyNight = UIColor(hexString: "#2C2C2E")
    
    static let nftWhite = UIColor { $0.userInterfaceStyle == .light ? .nftWhiteUni : .nftBlackUni }
    static let nftBlack = UIColor { $0.userInterfaceStyle == .light ? .nftBlackUni : .nftWhiteUni }
    static let nftLightGrey = UIColor { $0.userInterfaceStyle == .light ? .nftLightGreyDay : .nftLightGreyNight }
    
    // MARK: - BackgroundColor
    static let background = UIColor { $0.userInterfaceStyle == .light ? .nftWhiteUni : .nftBlackUni }

    // MARK: - TextColor
    static let textPrimary = UIColor.nftBlack
    static let textSecondary = UIColor.nftGreyUni
    static let textOnPrimary = UIColor.white
    static let textOnSecondary = UIColor.black

    static let segmentActive = UIColor { $0.userInterfaceStyle == .light ? .nftBlackUni : .nftWhiteUni }
    static let segmentInactive = UIColor { $0.userInterfaceStyle == .light ? .nftLightGreyDay : .nftLightGreyNight }
    static let closeButton = UIColor { $0.userInterfaceStyle == .light ? .nftBlackUni : .nftWhiteUni }
}
