//
//  PhotoCell.swift
//  Tumblr Client
//
//  Created by Akbar Mirza on 1/9/17.
//  Copyright © 2017 Akbar Mirza. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
