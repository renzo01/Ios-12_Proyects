//
//  Song.swift
//  06-WebScrapping
//
//  Created by Walter gomez on 3/1/19.
//  Copyright © 2019 Walter gomez. All rights reserved.
//

import Foundation
class Song {
    //object
    var uuid : String
    var title : String
    var authorName : String
    var itunesUrl : String
    var imgUrl : String
    var imageDownloaded = false
    //Constructor
    
    init(title : String, authorName : String, itunesUrl : String, imgUrl : String = "") {
        self.uuid =  UUID().uuidString
        self.title = title
        self.authorName = authorName
        self.itunesUrl = itunesUrl.replacingOccurrences(of: "https://", with: "itms://")
        self.imgUrl = imgUrl
    }
}
