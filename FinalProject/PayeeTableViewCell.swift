//
//  PayeeTableViewCell.swift
//  FinalProject
//
//  Created by Alina FV on 11/22/17.
//  Copyright © 2017 alina. All rights reserved.
//

import UIKit

class PayeeTableViewCell: UITableViewCell {

	@IBOutlet weak var btncheckMark: UIButton!
	@IBOutlet weak var lblPayeeName: UILabel!
	@IBOutlet weak var lblDay: UILabel!
	@IBOutlet weak var lblAmount: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
