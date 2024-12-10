//
//  OnboardingVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 22/08/24.
//

import UIKit

class OnboardingVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let identifier = "OnboardingCell"
    let viewModel = OnboardingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.collectionView.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        if viewModel.incrementIndex() {
            updateUI()
        } else {
            viewModel.navigateToLoginViewController(from: self.navigationController)
        }
    }
    
    @IBAction func btnSkip(_ sender: UIButton) {
        viewModel.navigateToLoginViewController(from: self.navigationController)
    }
    
    func updateUI()
    {
        let currentIndex = viewModel.getCurrentIndex()
        self.pageControl.currentPage = currentIndex
        DispatchQueue.main.async {
             self.collectionView.isPagingEnabled = false
             self.collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
             self.collectionView.isPagingEnabled = true
         }
    }
}

extension OnboardingVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrayImageList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        let slide = viewModel.currentSlide
        cell.img.image = slide.image
        cell.lbl_Main.text = slide.mainHeading
        cell.lbl_Sub.text = slide.subHeading
        return cell
    }
}

extension OnboardingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
}

extension OnboardingVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.updateCurrentIndex(to: indexPath.row)
        self.pageControl.currentPage = indexPath.row
    }
}
