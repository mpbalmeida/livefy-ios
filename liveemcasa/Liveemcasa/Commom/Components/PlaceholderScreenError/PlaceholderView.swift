//
//  PlaceholderError.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 05/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import UIKit

protocol PlaceholderViewDelegate: AnyObject {
  func tryAgainIsPressed()
}

class PlaceholderView: UIView {

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var btnTryAgain: UIButton!
  
  weak var delegate: PlaceholderViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    Bundle.main.loadNibNamed("PlaceholderView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }

  @IBAction func tryAgainClicked(_ sender: Any) {
    delegate?.tryAgainIsPressed()
  }
}
