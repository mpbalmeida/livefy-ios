//
//  LivesTableViewCell.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 05/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import UIKit

class LivesTableViewCell: UITableViewCell {
  
  @IBOutlet weak var lblName: UILabel!
  @IBOutlet weak var lblDesc: UILabel!
  @IBOutlet weak var lblLink: UILabel!
  @IBOutlet weak var lblSocialMedia: UILabel!
  @IBOutlet weak var lblCategory: UILabel!
  @IBOutlet weak var lblImagePath: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  // MARK: - Class Methods
  func configCell(live: Live) {
    lblName.text = live.name
    lblDesc.text = live.description
    lblLink.text = live.link
    lblSocialMedia.text = live.socialMedia
    lblCategory.text = live.category
    lblImagePath.text = live.bands[0].bucketFile.preSignedUrl
    
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
    
}
