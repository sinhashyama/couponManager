    //
//  ViewController.swift
//  couponManager
//
//  Created by Singh, Abhay on 6/30/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import UIKit

class CMCollectionVC: UIViewController {
    
    var collectionView: UICollectionView!
    var gradientLayer: CAGradientLayer!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var navBarItem: UINavigationItem!
    
    var desscription = ["OFF ANY ONE REGULAR PRICE ITEM", "Off on your entire purchase of $75 or more", "Off with a $70 minimum purchase"]
    var valueDiscount = ["10%", "$15", "$10"]
    var filteredArray:[String] = []
    var countNumber = 0
    var shouldShowSearchResults = false
    var searchResult = 0
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        setupCollectionView()
        countNumber = desscription.count
    }

    
    func setupCollectionView(){
        let layout = PinterestLayout()
        layout.delegate = self
        collectionView = UICollectionView(frame: CGRect(x:0.0, y:65.0, width:view.frame.width, height:view.frame.width - 20.0), collectionViewLayout: layout)
        self.collectionView.register(UINib(nibName: "CouponCell", bundle:nil), forCellWithReuseIdentifier: "pinInrestCell")
        //self.collectionView.register(CMCouponCell.self, forCellWithReuseIdentifier: "cmCouponCell")
        self.collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        //configureSearchController()
    }
    
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        let topColor = UIColor(red: 15/255, green: 118/255, blue: 128/255, alpha: 1)
        let bottomColor = UIColor(red: 84/255, green: 187/255, blue: 187/255, alpha: 1)
        let gradientColor = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocation = [0.0, 0.1]
        gradientLayer.colors = gradientColor
        gradientLayer.locations = gradientLocation as [NSNumber]?
        self.view.layer.addSublayer(gradientLayer)
    }
    
    @IBAction func searchActionTapped(_ sender: Any) {
    }
    
    @IBAction func addActionTapped(_ sender: Any) {
    }
    
    @IBAction func menuActionTapped(_ sender: Any) {
    }
    

}

//MARK: CollectionViewDelegate
extension CMCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return countNumber
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //do nothing so far
        let cell = collectionView.cellForItem(at: indexPath) as! CouponCell
        UIView.transition(with: cell.contentView, duration: 0.5, options: .transitionFlipFromRight, animations: { 
            if !(cell.showingBack) {
                cell.showingBack = true
                cell.cardView.isHidden = true
                cell.offerView.isHidden = false
            } else {
                cell.showingBack = false
                cell.cardView.isHidden = false
                cell.offerView.isHidden = true
            }
        }, completion: nil)
    }
    
    //We use this method to deques the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cmCouponCell", for: indexPath) as! CMCouponCell
        //cell.awakeFromNib()
        //return cell
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pinInrestCell", for: indexPath) as! CouponCell
      cell.awakeFromNib()
        cell.delegate = self
      return cell
    }
    
    //populate data for the cell
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let couponCell = cell as! CouponCell
        var headlineText:String?
        if shouldShowSearchResults {
            headlineText = filteredArray[indexPath.row].lowercased()
        } else {
            headlineText = desscription[indexPath.row].lowercased()
        }
        var discountValuetext = valueDiscount[indexPath.row]
        couponCell.headline.text = headlineText
        let firstFont = UIFont(name: "HelveticaNeue-Bold", size: 35)
        let secondFont = UIFont(name: "HelveticaNeue-Bold", size: 20)
        var desiredValue:NSAttributedString?
        if discountValuetext.contains("%") {
            desiredValue = utilities.superScript(discountValuetext, locationInt: discountValuetext.characters.count-1, length: 1, font1: firstFont!, font2: secondFont!)
        } else if discountValuetext.contains("$") {
            desiredValue = utilities.superScript(discountValuetext, locationInt: 0, length: 1, font1: firstFont!, font2: secondFont!)
        } else {
            desiredValue = utilities.superScript(discountValuetext, locationInt: 0, length: 0, font1: firstFont!, font2: secondFont!)
        }
        couponCell.discountValue.attributedText = desiredValue
    }
    
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionElementKindSectionHeader) {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
            
            return headerView
        }
        
        return UICollectionReusableView()
        
    }
    
}
    
extension CMCollectionVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        collectionView.reloadData()
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        //searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search here..."
        //searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            collectionView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        
        // Filter the data array and get only those countries that match the search text.
        filteredArray = desscription.filter({$0.contains(searchString!)})
        collectionView.reloadData()
    }
}

extension CMCollectionVC: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        return 42
    }
    
    func collectionView(collectionView: UICollectionView, heightForCaptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        let text = desscription[indexPath.row]
        let font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
        let height = utilities.heightForView(text: text, font: font!, width: width)
        print(height)
        return 120
    }
}

extension CMCollectionVC: CouponCellDeleteDelegate {
    func deleteCell(cell: CouponCell) {
        if let indexPath = collectionView.indexPath(for: cell){
            desscription.remove(at: indexPath.row)
            valueDiscount.remove(at: indexPath.row)
            countNumber = countNumber - 1
            self.collectionView.deleteItems(at: [indexPath])
        }
    }
}
    
