//
//  DiscountCell.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 23/08/24.
//

import UIKit

class DiscountCell: UITableViewCell {

    @IBOutlet weak var offer_Img: UIImageView!
    @IBOutlet weak var offer_CodeAndPercent: UIButton!
    @IBOutlet weak var lbl_OfferDescription: UILabel!
    
    @IBOutlet weak var subVw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        subVw.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
