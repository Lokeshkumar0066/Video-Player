//
//  imageExtension.swift
//  Video_Player
//
//  Created by Lokesh on 09/02/20.
//  Copyright © 2020 Lokesh. All rights reserved.
//

import UIKit

extension UIImageView{
    func cornerRadiusForImage() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor .white.cgColor
        self.layer.borderWidth = 2.0
    }
}


extension UIButton{
    func cornerRadiusForButton() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor .white.cgColor
        self.layer.borderWidth = 2.0
    }
}
