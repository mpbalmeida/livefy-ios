//
//  UIView.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 05/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Foundation
import UIKit

enum VerticalLocation: String {
  case bottom
  case top
}

enum AnchorConstraint {
  case top
  case leading
  case trailing
  case bottom
  case centerX
  case centerY
}

extension UIView {
  
  func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
    switch location {
    case .bottom:
      addShadow(offset: CGSize(width: 0, height: 1), color: color, opacity: opacity, radius: radius)
    case .top:
      addShadow(offset: CGSize(width: 0, height: -1), color: color, opacity: opacity, radius: radius)
    }
  }
  
  func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
    self.layer.masksToBounds = false
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOffset = offset
    self.layer.shadowOpacity = opacity
    self.layer.shadowRadius = radius
  }
  
  enum ViewSide {
    case left, right, top, bottom
  }
  
  class func nib() -> UINib {
    return UINib(nibName: typeName, bundle: nil)
  }
  
  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
    roundCorners(corners, size: CGSize(width: radius, height: radius))
  }
  
  func roundCorners(_ corners: UIRectCorner, size: CGSize) {
    let path = UIBezierPath(roundedRect: bounds,byRoundingCorners: corners, cornerRadii: size)
    let mask = CAShapeLayer()
    
    mask.path = path.cgPath
    
    layer.mask = mask
  }
  
  func installShadow() {
    layer.cornerRadius = 2
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 1)
    layer.shadowOpacity = 0.45
    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shadowRadius = 1.0
  }
  
  func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
    
    let border = CALayer()
    border.backgroundColor = color
    
    switch side {
    case .left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
    case .right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
    case .top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.size.width, height: thickness)
    case .bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
    }
    
    layer.addSublayer(border)
  }
  
  func borders(for edges:[UIRectEdge], width:CGFloat = 1, color: UIColor = .black) {
    
    if edges.contains(.all) {
      layer.borderWidth = width
      layer.borderColor = color.cgColor
    } else {
      let allSpecificBorders:[UIRectEdge] = [.top, .bottom, .left, .right]
      
      for edge in allSpecificBorders {
        if let v = viewWithTag(Int(edge.rawValue)) {
          v.removeFromSuperview()
        }
        
        if edges.contains(edge) {
          let v = UIView()
          v.tag = Int(edge.rawValue)
          v.backgroundColor = color
          v.translatesAutoresizingMaskIntoConstraints = false
          addSubview(v)
          
          var horizontalVisualFormat = "H:"
          var verticalVisualFormat = "V:"
          
          switch edge {
          case UIRectEdge.bottom:
            horizontalVisualFormat += "|-(0)-[v]-(0)-|"
            verticalVisualFormat += "[v(\(width))]-(0)-|"
          case UIRectEdge.top:
            horizontalVisualFormat += "|-(0)-[v]-(0)-|"
            verticalVisualFormat += "|-(0)-[v(\(width))]"
          case UIRectEdge.left:
            horizontalVisualFormat += "|-(0)-[v(\(width))]"
            verticalVisualFormat += "|-(0)-[v]-(0)-|"
          case UIRectEdge.right:
            horizontalVisualFormat += "[v(\(width))]-(0)-|"
            verticalVisualFormat += "|-(0)-[v]-(0)-|"
          default:
            break
          }
          
          self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: horizontalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
          self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
        }
      }
    }
  }
  
  func img() -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
    let image = renderer.image { ctx in
      self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
    }
    return image
  }
  
  func snapAllConstraints(toView view: UIView, horizontalDistance: CGFloat = 0, verticalDistance: CGFloat = 0) {
    snapTop(toView: view, distance: verticalDistance)
    snapLeading(toView: view, distance: horizontalDistance)
    snapTrailing(toView: view, distance: -horizontalDistance)
    snapBottom(toView: view, distance: -verticalDistance)
  }
  
  func snapTop(toView view: UIView, anchor: AnchorConstraint = .top, distance: CGFloat = 0) {
    if anchor == .top {
      topAnchor.constraint(equalTo: view.topAnchor, constant: distance).isActive = true
    } else if anchor == .bottom {
      topAnchor.constraint(equalTo: view.bottomAnchor, constant: distance).isActive = true
    }
  }
  
  func snapLeading(toView view: UIView, anchor: AnchorConstraint = .leading, distance: CGFloat = 0) {
    if anchor == .leading {
      leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distance).isActive = true
    } else if anchor == .trailing {
      leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: distance).isActive = true
    }
  }
  
  func snapTrailing(toView view: UIView, anchor: AnchorConstraint = .trailing, distance: CGFloat = 0) {
    if anchor == .trailing {
      trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: distance).isActive = true
    } else if anchor == .leading {
      trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: distance).isActive = true
    }
  }
  
  func snapBottom(toView view: UIView, anchor: AnchorConstraint = .bottom, distance: CGFloat = 0) {
    if anchor == .bottom {
      bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: distance).isActive = true
    } else if anchor == .top {
      bottomAnchor.constraint(equalTo: view.topAnchor, constant: distance).isActive = true
    }
  }
  
  func snapCenterX(toView view: UIView, anchor: AnchorConstraint = .centerX, distance: CGFloat = 0) {
    centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: distance).isActive = true
  }
  
  func snapCenterY(toView view: UIView, anchor: AnchorConstraint = .centerY, distance: CGFloat = 0) {
    centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: distance).isActive = true
  }
  
  func snapCenter(toView view: UIView, distance: CGFloat = 0) {
    snapCenterX(toView: view, distance: distance)
    snapCenterY(toView: view, distance: distance)
  }
  
  func fixHeightConstraint(size: CGFloat) {
    heightAnchor.constraint(equalToConstant: size).isActive = true
  }
  
  func fixWidthConstraint(size: CGFloat) {
    widthAnchor.constraint(equalToConstant: size).isActive = true
  }
  
  func fixAspectOneToOne(size: CGFloat) {
    fixHeightConstraint(size: size)
    fixWidthConstraint(size: size)
  }
  
  func fadeIn(_ duration : TimeInterval, completion: ((Bool) -> Swift.Void)? = nil) {
    self.alpha = 0
    self.isHidden = false
    
    UIView.animate(withDuration: duration, animations: {
      self.alpha = 1
    }, completion: completion)
  }
  
  func fadeOut(_ duration : TimeInterval, completion: ((Bool) -> Swift.Void)? = nil) {
    UIView.animate(withDuration: duration, animations: {
      self.alpha = 0
    }, completion: completion)
  }
  
  func screenshot() -> UIImage {
    return UIGraphicsImageRenderer(size: CGSize(width: bounds.size.width + 40, height: bounds.size.height + 40)).image { _ in
      drawHierarchy(in: CGRect(origin: CGPoint(x: 20, y: 10), size: bounds.size), afterScreenUpdates: true)
    }
  }
  
  func bounceAnimate() {
    self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    
    UIView.animate(withDuration: 2.0,
                   delay: 0,
                   usingSpringWithDamping: 0.2,
                   initialSpringVelocity: 6.0,
                   options: .allowUserInteraction,
                   animations: { [weak self] in
                    self?.transform = .identity
      },
                   completion: nil)
  }
  
  func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
    let animation = CABasicAnimation(keyPath: "transform.rotation")
    
    animation.toValue = toValue
    animation.duration = duration
    animation.isRemovedOnCompletion = false
    animation.fillMode = CAMediaTimingFillMode.forwards
    
    self.layer.add(animation, forKey: nil)
  }

  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
  
  func drawDottedLine(color: UIColor) {
    let shapeLayer = CAShapeLayer()
    shapeLayer.strokeColor = color.cgColor
    shapeLayer.lineWidth = 2
    shapeLayer.lineDashPattern = [4, 4] // 7 is the length of dash, 3 is length of the gap.
    let p0 = CGPoint(x: self.bounds.minX, y: self.bounds.minY)
    let p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.minY)
    let path = CGMutablePath()
    path.addLines(between: [p0, p1])
    shapeLayer.path = path
    self.layer.addSublayer(shapeLayer)
  }
  
  func drawDottedLine(dashPatter: [NSNumber], strokeColor: UIColor) {
    let shapeLayer = CAShapeLayer()
    shapeLayer.strokeColor = strokeColor.cgColor
    shapeLayer.lineWidth = 1
    shapeLayer.lineDashPattern = dashPatter
    
    let path = CGMutablePath()
    path.addLines(between: [CGPoint(x: self.bounds.minX, y: self.bounds.midY),
                            CGPoint(x: self.bounds.maxX, y: self.bounds.midY)])
    shapeLayer.path = path
    layer.addSublayer(shapeLayer)
  }
  
  func invoiceShadow(_ cornerRadius: CGFloat? = nil) {
    if cornerRadius != nil { self.layer.cornerRadius = cornerRadius! }
    self.layer.shadowRadius = 4
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize.zero
    self.layer.shadowOpacity = 0.1
  }
  
  func tapToDismissKeyboard() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    self.addGestureRecognizer(tap)
  }
  
  @objc
  private func dismissKeyboard() {
    self.endEditing(true)
  }
}
