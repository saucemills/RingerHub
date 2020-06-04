//
//  Article.swift
//  RingerHub
//
//  Created by Jon Miller on 5/14/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import Foundation

struct Article {
    var title: String?
    var authors: String?
    var id: String?
}

enum LoadingError : Error {
    case networkingError(Error)
    case requestFailed(Int)
    case serverError(Int)
    case notFound
    case feedParsingError(Error)
    case missingAttribute(String)
}
