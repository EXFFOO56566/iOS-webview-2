//
//  RoundButton.swift
//  infixsoft.imrankst1221.RocketWeb
//
//  Created by Imran on 2/9/18.
//  Copyright © 2018 Orlendo dev. All rights reserved.
//

import UIKit

// MARK: Gradient Background
// view.setGradientBackground(colorOne: Colors.orange, colorTwo: Colors.brightOrange)
extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}


//MARK: VISIBLE INVISIBLE GONE
extension UIView {
    enum Visibility: String {
        case visible = "visible"
        case invisible = "invisible"
        case gone = "gone"
    }
    
    var visibility: Visibility {
        get {
            let constraint = (self.constraints.filter{$0.firstAttribute == .height && $0.constant == 0}.first)
            if let constraint = constraint, constraint.isActive {
                return .gone
            } else {
                return self.isHidden ? .invisible : .visible
            }
        }
        set {
            if self.visibility != newValue {
                self.setVisibility(newValue)
            }
        }
    }
    
    @IBInspectable
    var visibilityState: String {
        get {
            return self.visibility.rawValue
        }
        set {
            let _visibility = Visibility(rawValue: newValue)!
            self.visibility = _visibility
        }
    }
    
    private func setVisibility(_ visibility: Visibility) {
        let constraints = self.constraints.filter({$0.firstAttribute == .height && $0.constant == 0 && $0.secondItem == nil && ($0.firstItem as? UIView) == self})
        let constraint = (constraints.first)
        
        switch visibility {
        case .visible:
            constraint?.isActive = false
            self.isHidden = false
            break
        case .invisible:
            constraint?.isActive = false
            self.isHidden = true
            break
        case .gone:
            self.isHidden = true
            if let constraint = constraint {
                constraint.isActive = true
            } else {
                let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
                // constraint.priority = UILayoutPriority(rawValue: 999)
                self.addConstraint(constraint)
                constraint.isActive = true
            }
            self.setNeedsLayout()
            self.setNeedsUpdateConstraints()
        }
    }
}


// MARK: Set Image view resize
extension UIImage {
    func resize(size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}


// MARK: Set Image from URL
extension UIImageView {
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "demo_book.jpg")
            return
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self.image = data != nil ? UIImage(data: data!) : UIImage(named: "demo_book.jpg")
            }
        }
    }
}



// MARK: Removed extra space
extension String {
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}



// MARK: encoding a string
extension String {
    func customEncoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    func customDecoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}


// MARK: Print Constraint
extension NSLayoutConstraint {
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}


// MARK: Get AppName
extension Bundle {
    static func getAppName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version : String = dictionary["CFBundleName"] as? String {
            return version
        } else {
            return ""
        }
    }
}

// MARK: Hexcode -> Color
// UIColor(hexString: "#259F6C")
// call method with hex color code
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
