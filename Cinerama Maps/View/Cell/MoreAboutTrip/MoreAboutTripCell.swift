//
//  MoreAboutTripCell.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 14/11/24.
//

import UIKit

class MoreAboutTripCell: UITableViewCell {

    @IBOutlet weak var lbl_DayName: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    
    @IBOutlet weak var lbl_KM: UILabel!
    @IBOutlet weak var lbl_Minutes: UILabel!
    @IBOutlet weak var lbl_CityName: UILabel!
    @IBOutlet weak var lbl_CretedByCNRM: UILabel!
    
    @IBOutlet weak var viewHeadline: UIView!
    
    var cloDelete:(() -> Void)?
    var cloEdit:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewHeadline.roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func btn_Delete(_ sender: UIButton) {
        self.cloDelete?()
    }
    
    @IBAction func btn_Edit(_ sender: UIButton) {
        self.cloEdit?()
    }
}
