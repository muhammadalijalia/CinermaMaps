//
//  ContentViewController.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 23/08/24.
//

import UIKit

class ContentViewController: UIViewController {

    let identifier = "DiscountCell"
    var arrOfferSubCategory: [Company_offer] = []
    
    convenience init(index: String, arrOfferSubCategory: [Company_offer], catId : String) {
        self.init(title: "\(index)", arrSub: arrOfferSubCategory, catId: catId)
    }
    
    convenience init(title: String, arrOfferSubCategory: [Company_offer], catId : String) {
        self.init(title: title, arrSub: arrOfferSubCategory, catId: catId)
    }
    
    init(title: String, arrSub: [Company_offer], catId : String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemGroupedBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        tableView.separatorStyle = .none
        self.arrOfferSubCategory = arrSub
        tableView.reloadData()
        view.addSubview(tableView)
        view.backgroundColor = .clear
        view.constrainToEdgesAfterMargin(tableView, after: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrOfferSubCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscountCell", for: indexPath) as! DiscountCell
        
        let obj = self.arrOfferSubCategory[indexPath.row]
        
        cell.offer_CodeAndPercent.setTitle("\(obj.discount_code ?? "") \(obj.discount_percentage ?? "")% Off Discount", for: .normal)
        
        let htmlString = obj.description ?? ""
        if let attributedData = htmlString.htmlAttributedString3{
            cell.lbl_OfferDescription.attributedText = attributedData
        }
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.offer_Img)
        } else {
            cell.offer_Img.image = R.image.blank()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
