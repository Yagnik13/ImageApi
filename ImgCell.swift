//
//  ImgCell.swift
//  ImageAPI
//
//  Created by Yagnik on 03/02/17.
//  Copyright © 2017 Yagnik. All rights reserved.
//

import UIKit

class ImgCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var imgtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
