//
//  DealListRowTableViewCell.swift
//  DealMateIos
//
//  Created by qixiaohui on 3/15/17.
//  Copyright © 2017 qixiaohui. All rights reserved.
//

import UIKit

class DealListRowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var FreeShippingLabel: UILabel!
    @IBOutlet weak var DealImage: UIImageView!
    
    @IBOutlet weak var OriginalPrice: UILabel!
    @IBOutlet weak var CurrentPrice: UILabel!
    @IBOutlet weak var OverviewLabel: UILabel!
    @IBOutlet weak var DealTitle: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
