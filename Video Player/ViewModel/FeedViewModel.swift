//
//  FeedViewModel.swift
//  Video Player
//
//  Created by manish on 10/02/20.
//  Copyright © 2020 manish. All rights reserved.
//

import UIKit

class FeedViewModel {
    
    var items = [FeedModel]()
    
    init(arrFeed:[AnyObject]) {
        self.items = FeedModel .modelFromDictionnaryArray(array: arrFeed)
    }
}
