//
//  CustomCell.swift
//  Video_Player
//
//  Created by Lokesh on 09/02/20.
//  Copyright © 2020 Lokesh. All rights reserved.
//

import UIKit
import AVFoundation

class CustomCell: UICollectionViewCell {
    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTime: UILabel!
    @IBOutlet weak var btnProfile: UIButton!
    
    var playerLayer: AVPlayerLayer = AVPlayerLayer()
    var player: AVPlayer = AVPlayer()
    var videoPlayerItem: AVPlayerItem? = nil {
        didSet {
            player.replaceCurrentItem(with: self.videoPlayerItem)
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.cornerRadiusForImage()
        
        videoImage.clipsToBounds = true
        videoImage.backgroundColor = UIColor.clear

        self.player = AVPlayer.init(playerItem: self.videoPlayerItem)
        playerLayer = AVPlayerLayer(player: player)

        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        playerLayer.zPosition = 10
        player.actionAtItemEnd = .none
        videoImage.layer.addSublayer(playerLayer)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem)

    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: CMTime.zero, completionHandler: nil)

    }

    
    override func prepareForReuse() {
        self.userName.text = ""
        self.profileImage.imageURL = nil
        self.videoImage.imageURL = nil
        super.prepareForReuse()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = CGRect(x:0,y:0,width: self.frame.size.width, height: self.frame.size.height)
    }
    
}



