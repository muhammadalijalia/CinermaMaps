//
//  SubscriptionListCell.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 25/10/24.
//

import UIKit

class SubscriptionListCell: UITableViewCell {

    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var lbl_LikeCount: UILabel!
    @IBOutlet weak var lbl_DislikeCount: UILabel!
    
    @IBOutlet weak var btn_LikeCount: UIButton!
    @IBOutlet weak var btn_DislikeCount: UIButton!
    
    @IBOutlet weak var tags_Collection: UICollectionView!
    
    var arrayOfTag: [Tag_details] = []
    
    var cloLike:(() -> Void)?
    var cloDisLike:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.tags_Collection.register(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: "TagCell")
        self.tags_Collection.delegate = self
        self.tags_Collection.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btn_Like(_ sender: UIButton) {
        self.cloLike?()
    }
    
    @IBAction func btn_Dislike(_ sender: UIButton) {
        self.cloDisLike?()
    }
}

extension SubscriptionListCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.arrayOfTag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        let obj = self.arrayOfTag[indexPath.row]
        cell.lbl_TagName.text = obj.tag_name ?? ""
        cell.lbl_TagName.backgroundColor = hexStringToUIColor(hex: obj.color_code ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 127, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
