//
//  PodcastCell.swift
//  RingerHub
//
//  Created by Jon Miller on 5/20/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {

    static let reuseID  = "PodcastCell"
    var thumbnail = UIImageView()
    var title = RHTitleLabel(textAlignment: .left, fontSize: 18)
    var summary = RHSecondaryTitleLabel(fontSize: 14)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(podcast: Podcast) {
        NetworkManager.shared.downloadImage(from: podcast.thumbnail!) { [weak self](image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.thumbnail.image = image}
        }
        title.text = podcast.episodeTitle
        summary.text = podcast.episodeDescription
    }
    
    private func configure() {
        addSubview(thumbnail)
        addSubview(title)
        addSubview(summary)
        
        title.numberOfLines = 2
        summary.numberOfLines = 3
        
        let views = [title, thumbnail, summary]
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            thumbnail.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbnail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            thumbnail.heightAnchor.constraint(equalToConstant: 64),
            thumbnail.widthAnchor.constraint(equalToConstant: 64),
            
            title.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            title.heightAnchor.constraint(equalToConstant: 40),
            
            summary.topAnchor.constraint(equalTo: title.bottomAnchor),
            summary.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 5),
            summary.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            summary.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

}
