//
//  Loader.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 11/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import UIKit

public class Loader {

    // MARK: Properties

    struct Constants {
        static let backgroundColor = UIColor.white
        static let fade = 0.1
    }

    struct Position {
        static var screen: CGRect { return UIScreen.main.bounds }
        static var side: CGFloat { return screen.width / 4 }
        static var xPosition: CGFloat { return (screen.width / 2) - (side / 2) }
        static var yPosition: CGFloat { return (screen.height / 2) - (side / 2) }
    }

    static var loaderImage: UIImage? {
        return Images.loader.image?.withRenderingMode(.alwaysTemplate)
    }

    private static var indicator: UIView = {
        var view = UIView()

        view.frame = CGRect(x: Position.xPosition, y: Position.yPosition, width: Position.side, height: Position.side)
        view.layer.cornerRadius = 10
        view.alpha = 0.0
        view.tag = 1

        view.addSubview(loaderImageView)

        return view
    }()

    private static var loaderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: Position.side / 4, y: Position.side / 4, width: Position.side / 2.3, height: Position.side / 2.3)

        return imageView
    }()

    private static var backgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        blurEffectView.alpha = 0.0
        blurEffectView.tag = 2

        return blurEffectView
    }()

    private static var animation: CABasicAnimation = {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = 2.0
        rotateAnimation.repeatCount = Float.infinity
        return rotateAnimation
    }()

    // MARK: Methods

    public static func start(withImage image: UIImage? = nil, loaderColor: UIColor = UIColor.blue) {
        if let window: UIWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            var found: Bool = false

            window.subviews.forEach {
                if $0.tag == 1 || $0.tag == 2 {
                    found = true
                }
            }

            if !found {
                loaderImageView.image = image ?? loaderImage
                loaderImageView.tintColor = loaderColor
                addLoader(window: window)
            }
        }
    }

    public static func stop() {
        UIView.animate(withDuration: Constants.fade, animations: {
            self.indicator.alpha = 0.0
            self.backgroundView.alpha = 0.0
        }, completion: { _  in
            self.backgroundView.removeFromSuperview()
            self.indicator.removeFromSuperview()

            self.indicator.subviews.forEach {
                $0.layer.removeAllAnimations()
            }
        })
    }

    // MARK: Private Methods

    private static func addLoader(window: UIWindow) {
        window.addSubview(backgroundView)
        indicator.subviews.forEach { $0.layer.add(animation, forKey: nil) }

        window.addSubview(indicator)
        UIView.animate(withDuration: Constants.fade, animations: {
            self.backgroundView.alpha = 0.7
            self.indicator.alpha = 1.0
        })
    }
}
