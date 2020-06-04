//
//  VideoCell.swift
//  RingerHub
//
//  Created by Jon Miller on 5/19/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    static let reuseID  = "VideoCell"
    var thumbnail = UIImageView()
    var title = RHTitleLabel(textAlignment: .left, fontSize: 16)
    var publishedAt = RHSecondaryTitleLabel(fontSize: 14)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(video: Video) {
        NetworkManager.shared.downloadImage(from: video.thumbnailUrl) { [weak self](image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.thumbnail.image = image}
        }
        title.text = video.title
        publishedAt.text = video.publishedAt
    }
    
    private func configure() {
        addSubview(thumbnail)
        addSubview(title)
        
        title.numberOfLines = 2
        
        let views = [title, thumbnail, publishedAt]
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            thumbnail.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            thumbnail.centerXAnchor.constraint(equalTo: centerXAnchor),
            thumbnail.heightAnchor.constraint(equalToConstant: 180),
            thumbnail.widthAnchor.constraint(equalToConstant: 320),
            
            title.topAnchor.constraint(equalTo: thumbnail.bottomAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            title.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
}
