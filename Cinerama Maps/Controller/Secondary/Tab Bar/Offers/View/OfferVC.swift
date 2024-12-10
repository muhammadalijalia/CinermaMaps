//
//  OfferVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 23/08/24.
//

import UIKit
import Parchment
import SnapKit

class OfferVC: UIViewController {

    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var viewContentPaging: UIView!
    @IBOutlet weak var search_Bar: UISearchBar!
    
    let viewModel = OfferViewModel()
    var vcs:[ContentViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupSearchBar(searchBar: search_Bar)
        setUpComanyOffers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpComanyOffers()
    {
        viewModel.requestCompanyOffer(vC: self)
        viewModel.fetchedSuccessfully = { [] in
            for i in 0...self.viewModel.arrayOfOffers.count - 1 {
                self.vcs.append(ContentViewController(index: self.viewModel.arrayOfOffers[i].category_name ?? "", arrOfferSubCategory: self.viewModel.arrayOfOffers[i].company_offer ?? [], catId: ""))
                print(self.viewModel.arrayOfOffers[i].company_offer ?? [])
                if i == self.viewModel.arrayOfOffers.count - 1 {
                    self.setUpCategories(self.vcs)
                }
            }
        }
    }
    
    func setUpCategories(_ vcs: [ContentViewController]) {
        let pagingViewController = PagingViewController(viewControllers: vcs)
        pagingViewController.backgroundColor = .clear
        pagingViewController.collectionView.backgroundColor = .clear
        addChild(pagingViewController)
        viewContentPaging.addSubview(pagingViewController.view)
        
        pagingViewController.view.snp.makeConstraints { make in
            make.top.equalTo(searchVw.snp.bottom).offset(20) // Position below searchVw with a 20-point gap
            make.leading.trailing.equalToSuperview() // Stretch to the edges horizontally
            make.bottom.equalToSuperview() // Stretch to the bottom
        }

        pagingViewController.didMove(toParent: self)
    }
}


