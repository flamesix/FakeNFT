import UIKit

public protocol TypographyExtensions: UILabel {
    var lineHeight: CGFloat? { get set }
}

extension UILabel: TypographyExtensions {
    
    public var lineHeight: CGFloat? {
        get { nil }
        set {
            
            // Values.
            let lineHeight = newValue ?? font.lineHeight
            let baselineOffset = (lineHeight - font.lineHeight) / 2.0 / 2.0
            
            // Paragraph style.
            let mutableParagraphStyle = NSMutableParagraphStyle()
            mutableParagraphStyle.minimumLineHeight = lineHeight
            mutableParagraphStyle.maximumLineHeight = lineHeight
            
            // Set.
            attributedText = NSAttributedString(
                string: text ?? "",
                attributes: [
                    .baselineOffset : baselineOffset,
                    .paragraphStyle : mutableParagraphStyle
                ]
            )
        }
    }
}
