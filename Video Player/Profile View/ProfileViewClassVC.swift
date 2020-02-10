//
//  ProfileViewClassVC.swift
//  Video_Player
//
//  Created by Lokesh on 09/02/20.
//  Copyright © 2020 Lokesh. All rights reserved.
//

import UIKit

class ProfileViewClassVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var headerView: ProfileHeader = ProfileHeader()
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTitle: UILabel!

    var dictProfile:[String:Any] = [:]
    var viewModel: ProfileViewModel?
    var model: ProfileModel?
    var headerHeight:CGFloat = 1
    
    var partialView: CGFloat {
        return 100
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibFile()
        self.getJSONDataFromBundle()
        roundViews()

    }
    
    func registerNibFile(){
        self.collectionView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCell")
        self.collectionView .register(UINib(nibName: "ProfileHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProfileHeader")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    

    

    func roundViews() {
        view.layer.cornerRadius = 14
        view.clipsToBounds = false
        userImage.cornerRadiusForImage()
        btnCross.cornerRadiusForButton()
    }
    
    func getJSONDataFromBundle(){
        dictProfile = self.readingJSONFile(fileName: "userprofile")
        var arrProfileAlbum:[AnyObject] = []
        arrProfileAlbum = dictProfile["posts"] as! [AnyObject]
        viewModel = ProfileViewModel(arrPost: arrProfileAlbum)
        model = ProfileModel.init(dictProfile: dictProfile as NSDictionary)
        loadData()
        self.reloadData()
    }
    
    func loadData(){
        userImage.imageURL = model?.userImageUrl
        userName.text = model?.userName
        userTitle.text = model?.title
    }
    
    func reloadData(){
        let flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionHeadersPinToVisibleBounds = false
        self.collectionView.reloadData()
    }
    
    

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "playVideo"), object: nil)
    }

    @objc func rotated(){
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }

    @IBAction func onClickCross(_ sender: Any) {
         self.dismiss(animated: true) {
        //            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "playVideo"), object: nil)
                }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    

}



extension ProfileViewClassVC :UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           switch kind {

           case UICollectionView.elementKindSectionHeader:

            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProfileHeader", for: indexPath) as! ProfileHeader
            headerView.txtView.text = """
            
            Traveller😎 | Dance💃
            Waiting for the world to be better
            Hopelessly romantic😘😘
            www.nihalnova.com

            """
            return headerView
            
        default:
            assert(false, "Unexpected element kind")
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.arrProfilePost.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ProfileCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.userAlbum.imageURL = viewModel?.arrProfilePost[indexPath.row].postUserImageUrl
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let headerView = collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).first as? ProfileHeader {
            headerView.layoutIfNeeded()
            let height = headerView.txtView.contentSize.height
            headerHeight = height
            return CGSize(width: collectionView.frame.width, height: height)
        }
        return CGSize(width: collectionView.frame.width, height: headerHeight)
    }

    
}


extension ProfileViewClassVC: UICollectionViewDelegateFlowLayout{
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let screenWidth = collectionView.bounds.width
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width / 3 - 2, height: screenWidth / 2 - 20)
    }
}

