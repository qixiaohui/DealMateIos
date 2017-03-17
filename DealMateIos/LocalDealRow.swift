//
//  LocalDealRow.swift
//  DealMateIos
//
//  Created by qixiaohui on 3/16/17.
//  Copyright © 2017 qixiaohui. All rights reserved.
//

import UIKit

class LocalDealRow: UITableViewCell {

    @IBOutlet weak var CheckStore: UIButton!
    @IBOutlet weak var Check: UIButton!
    @IBOutlet weak var DealOverview: UILabel!
    @IBOutlet weak var DealStore: UILabel!
    @IBOutlet weak var DealTitle: UILabel!
    @IBOutlet weak var DealImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
