//
//  PartyRock.swift
//  PartyRockApp
//
//  Created by Maury on 7/05/22.
//

import Foundation

class PartyRock {
    private var imageURL: String!
    private var videoURL: String!
    private var videoTitle: String!
    
    var imageURL1: String {
        return imageURL
    }
    
    var videoURL1: String {
        return videoURL
    }
    
    var videoTitle1: String {
        return videoTitle
    }
    
    init(imageURL1: String, videoURL1: String, videoTitle1: String) {
        imageURL = imageURL1
        videoURL = videoURL1
        videoTitle = videoTitle1
    }
}
