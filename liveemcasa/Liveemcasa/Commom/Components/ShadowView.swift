//
//  ShadowView.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 05/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Foundation
import UIKit

class ShadowView: UIView {
  
  // MARK: - Properties
  var shadowOffset: CGSize  = CGSize(width: 0, height: 2)
  var cornerRadius: CGFloat = CGFloat(8.0)
  
  override var bounds: CGRect {
    didSet {
      setupShadow()
    }
  }
  
  // MARK: - Init
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setupShadow() {
    self.layer.cornerRadius = cornerRadius
    self.layer.shadowOffset = shadowOffset
    self.layer.shadowRadius = 3
    self.layer.shadowOpacity = 0.1
    self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 10, height: 10)).cgPath
    self.layer.shouldRasterize = true
    self.layer.rasterizationScale = UIScreen.main.scale
  }
}

extension ShadowView {
  private func setup() {
    self.layer.cornerRadius = cornerRadius
    self.layer.shadowOffset = shadowOffset
    self.layer.shadowRadius = 3
    self.layer.shadowOpacity = 0.1
    self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 10, height: 10)).cgPath
    self.layer.shouldRasterize = true
    self.layer.rasterizationScale = UIScreen.main.scale
  }
}
