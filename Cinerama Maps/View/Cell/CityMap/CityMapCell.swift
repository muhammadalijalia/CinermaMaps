//
//  CityMapCell.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 27/08/24.
//

import UIKit
import Cosmos

class CityMapCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl_CountryName: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var lbl_Rating: UILabel!
    @IBOutlet weak var rating_Vw: CosmosView!
    
    @IBOutlet weak var btn_FavOt: UIButton!
    
    var cloFav:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btn_Fav(_ sender: UIButton) {
        self.cloFav?()
    }
}
