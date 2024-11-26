import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

extension UIView {
    func recycleStateUpdateAnimated(_ state: Bool, _ button: UIButton) {
        let image = state
        ? UIImage(resource: .nftRecycleEmpty)
        : UIImage(resource: .nftRecycleFull)
        
        UIView.animateKeyframes(withDuration: 0.3, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.67) {
                let transformation = CGAffineTransform(scaleX: 1.2, y: 1.2)
                button.transform = transformation
            }
            UIView.addKeyframe(withRelativeStartTime: 0.67, relativeDuration: 1) {
                let transformation = CGAffineTransform(scaleX: 1.0, y: 1.0)
                button.transform = transformation
                button.setImage(image, for: .normal)
            }
        }
    }

    func likeUpdateAnimated(_ state: Bool, _ button: UIButton) {
        let likeButtonColor: UIColor = state
        ? .nftRedUni
        : .nftWhiteUni
        
        UIView.animateKeyframes(withDuration: 1.2, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                let rotateTransform = CGAffineTransform.init(rotationAngle: 0.35)
                let scaleTransform = CGAffineTransform(scaleX: 1.1, y: 1.3).concatenating(rotateTransform)
                button.transform = scaleTransform
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.6) {
                let rotateTransform = CGAffineTransform.init(rotationAngle: -0.4)
                let scaleTransform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(rotateTransform)
                button.transform = scaleTransform
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.8) {
                let rotateTransform = CGAffineTransform.init(rotationAngle: 0.1)
                let scaleTransform = CGAffineTransform(scaleX: 1.2, y: 1.2).concatenating(rotateTransform)
                button.transform = scaleTransform
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 1) {
                let rotateTransform = CGAffineTransform.init(rotationAngle: 0)
                let scaleTransform = CGAffineTransform(scaleX: 1, y: 1).concatenating(rotateTransform)
                button.transform = scaleTransform
                button.tintColor = likeButtonColor
            }
        }
    }
}
