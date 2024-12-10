//
//  TripScheduleCell.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 23/08/24.
//

import UIKit

class TripScheduleCell: UITableViewCell {

    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var lbl_ScheduleTrip: UILabel!
    @IBOutlet weak var lbl_CreatedBy: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    
    var cloDelete:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btn_Delete(_ sender: UIButton) {
        self.cloDelete?()
    }
}
