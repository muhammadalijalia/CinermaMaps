//
//  ServiceDetailVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 23/08/24.
//

import UIKit

class ServiceDetailImageCell: UICollectionViewCell {
    
    @IBOutlet weak var place_Img: UIImageView!
    
}

class ServiceDetailVC: UIViewController {

    @IBOutlet weak var review_TableVw: UITableView!
    @IBOutlet weak var review_TableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var servicePlace_ImgCollection: UICollectionView!
    @IBOutlet weak var lbl_ServiceName: UILabel!
    @IBOutlet weak var lbl_ServiceDes: UILabel!
    @IBOutlet weak var lbl_ContactNum: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    
    let viewModel = ServiceDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.review_TableVw.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
        setUpBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
        self.review_TableHeight.constant = self.review_TableVw.contentSize.height
     }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_ServiceReview(_ sender: UIButton) {
        viewModel.navigateToRatingReviewViewController(from: navigationController)
    }
    
    private func setUpBinding()
    {
        viewModel.fetchServiceDetail(vC: self)
        viewModel.fetchedSuccessfully = { [] in
            DispatchQueue.main.async { [self] in
                let obj = self.viewModel.arrayServiceDetail
                self.lbl_ServiceName.text = obj?.company_name
                let html = obj?.description_ar
                if let attributedText = html?.htmlAttributedString3 {
                    self.lbl_ServiceDes.attributedText = attributedText
                }
                self.lbl_ContactNum.text = obj?.mobile
                self.lbl_Address.text = obj?.address
                self.servicePlace_ImgCollection.reloadData()
                self.review_TableVw.reloadData()
            }
        }
    }
}

extension ServiceDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrayRatingReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        let obj = self.viewModel.arrayRatingReview[indexPath.row]
        
        cell.lbl_Name.text = obj.user_name ?? ""
        cell.lbl_Date.text = obj.date_time ?? ""
        cell.ratingStar.rating = Double(obj.rating ?? "") ?? 0.0
        cell.ratingCount.text = obj.rating ?? ""
        cell.lbl_Message.text = obj.review ?? ""
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.user_Img)
        } else {
            cell.user_Img.image = R.image.blank()
        }
        
        return cell
    }
}

extension ServiceDetailVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrayOfImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ServiceDetailImageCell
        let obj = viewModel.arrayOfImages[indexPath.row]
        Utility.setImageWithSDWebImage(obj, cell.place_Img)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
