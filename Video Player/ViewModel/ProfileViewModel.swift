//
//  ProfileViewModel.swift
//  Video Player
//
//  Created by manish on 10/02/20.
//  Copyright © 2020 manish. All rights reserved.
//

import UIKit

class ProfileViewModel {
    var arrProfilePost = [ProfileModel]()
    
    init(arrPost:[AnyObject]) {
        self.arrProfilePost = ProfileModel .modelFromDictionnaryArray(arrPost: arrPost)
    }
    
}
