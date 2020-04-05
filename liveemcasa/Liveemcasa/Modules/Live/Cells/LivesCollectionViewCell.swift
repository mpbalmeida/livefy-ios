//
//  LivesCollectionViewCell.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 05/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import UIKit
import SDWebImage

class LivesCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var viewContent: UIView!
  @IBOutlet weak var lblDate: UILabel!
  @IBOutlet weak var imgLive: UIImageView!
  
  public static let identifier: String = "LivesCollectionViewCell"
  public static let nib: UINib = UINib(nibName: "LivesCollectionViewCell", bundle: nil)
  private static let kPadding: CGFloat = 16.0
  public static let size: CGSize = CGSize(width: UIScreen.main.bounds.size.width - kPadding * 2, height: 100)

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  public func configureCell(live: Live) {
    viewContent.layer.cornerRadius = 10;
    viewContent.layer.masksToBounds = true;
    
    imgLive.sd_setImage(with: URL(string: live.bands[0].bucketFile.preSignedUrl))
    
    if let date = live.date.date(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ") {
      lblDate.text = (date.string(withFormat: "dd/MM/yyyy HH:mm"))
    }
  }

}
