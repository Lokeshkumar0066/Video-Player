//
//  FeedClassVC.swift
//  TotalityCorpProject
//
//  Created by manish on 08/02/20.
//  Copyright © 2020 manish. All rights reserved.
//

import UIKit
import AVFoundation

class FeedClassVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: FeedViewModel?
    var viewModelTemp: FeedViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
        self.getJSONDataFromBundle()
        
        NotificationCenter.default.removeObserver("playVideo")
        NotificationCenter.default.addObserver(self, selector: #selector(playVideo), name: NSNotification.Name(rawValue: "playVideo"), object: nil)
    }

    func getJSONDataFromBundle(){
        let dictFeed:[String:Any] = self.readingJSONFile(fileName: "feed")
        var arrFeed:[AnyObject] = []
        arrFeed = dictFeed["posts"] as! [AnyObject]
        viewModel = FeedViewModel(arrFeed: arrFeed)
        viewModelTemp = viewModel
        self.collectionView.reloadData()
    }

    
    func addBottomSheetView() {
        let story:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let profileObj: ProfileViewClassVC = story.instantiateViewController(withIdentifier: "ProfileViewClassVC") as! ProfileViewClassVC
        self.present(profileObj, animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc func rotated(){
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }

}


extension FeedClassVC :UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.items.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.videoPlayerItem = AVPlayerItem.init(url: URL(string: (viewModel?.items[indexPath.row].vUrl)!)!)

        cell.userName.text = viewModel?.items[indexPath.row].userName
        cell.profileImage.imageURL = viewModel?.items[indexPath.row].userImageUrl
        cell.videoImage.imageURL = viewModel?.items[indexPath.row].userImageUrl
        cell.userTime.text = viewModel?.items[indexPath.row].time
        cell.btnProfile.tag = indexPath.row
        cell.btnProfile.addTarget(self, action: #selector(onClickProfile(sender:)), for: .touchUpInside)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = (cell as? CustomCell)!
        cell.player.play()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = (cell as? CustomCell)!
        cell.player.pause()
    }
    
    
    @objc func onClickProfile(sender: UIButton){
        getVisibleCell(isPlay:false)
        self.addBottomSheetView()
    }
    
    func getVisibleCell(isPlay: Bool){
        for cell in collectionView.visibleCells{
            let cellObj = cell as? CustomCell
            if isPlay{
                cellObj?.player.play()
            }else{
                cellObj?.player.pause()
            }
        }
    }
    
    @objc func playVideo(){
        getVisibleCell(isPlay:true)
    }
    
}


extension FeedClassVC: UICollectionViewDelegateFlowLayout{
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let _ = collectionView.bounds.width
        let screenHeight = collectionView.bounds.height
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: screenHeight)
    }
}



extension FeedClassVC:UICollectionViewDataSourcePrefetching{
       func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]){
           
           for indexPath in indexPaths {
                let tempObj = viewModelTemp?.items[indexPath.row]
                self.viewModel?.items[indexPath.row] = tempObj!
           }
       }
       
       func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]){
           print("Cancel Prefetching Items At index which are not displayed on screen")
           for indexPath in indexPaths {
            self.viewModel?.items.remove(at: indexPath.row)
           }
       }

}
