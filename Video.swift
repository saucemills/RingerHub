//
//  Video.swift
//  RingerHub
//
//  Created by Jon Miller on 5/18/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import UIKit

struct Video {
    var title: String
    var publishedAt: String
    var thumbnailUrl: String
    var videoID: String
}

enum VideoError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again"
    case unableToComplete   = "Unable to complete request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
}
