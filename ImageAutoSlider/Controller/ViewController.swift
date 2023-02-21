//
//  ViewController.swift
//  ImageAutoSlider
//
//  Created by Md Murad Hossain on 10/10/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var imageArr = [
        UIImage(named: "1"),
        UIImage(named: "2"),
        UIImage(named: "3"),
        UIImage(named: "4"),
        UIImage(named: "5"),
        UIImage(named: "6"),
        UIImage(named: "7"),
        UIImage(named: "8"),
        UIImage(named: "9"),
        UIImage(named: "10"),
        UIImage(named: "11"),
        UIImage(named: "12"),
        UIImage(named: "13"),
        UIImage(named: "14"),
        UIImage(named: "15"),
        UIImage(named: "16"),
        UIImage(named: "18"),
        UIImage(named: "19"),
        UIImage(named: "20"),
        UIImage(named: "21"),
        UIImage(named: "22"),
        UIImage(named: "23"),
        UIImage(named: "24")
    ]
    
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupPageControl()
   
    }

    // MARK: - Private Methods
    
    func setupCollectionView() {
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupPageControl() {
        pageController.numberOfPages = imageArr.count
        pageController.currentPage = 0
        DispatchQueue.main.async {
              self.timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.autoSlideer), userInfo: nil, repeats: true)
           }
    }
    
    @objc func autoSlideer() {
        if counter < imageArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageController.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageController.currentPage = counter
            counter = 1
        }
    }
    
    // MARK: - Button Action

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.imageView.image = imageArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        pageController.currentPage = Int(scrollPos)
    }
    
}

