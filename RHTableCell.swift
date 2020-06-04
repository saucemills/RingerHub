//
//  RHTableCell.swift
//  RingerHub
//
//  Created by Jon Miller on 5/14/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import UIKit

class RHTableCell: UITableViewCell {
    
    static let reuseID  = "NewsTableCell"
    var title           = RHTitleLabel(textAlignment: .left, fontSize: 22)
    var author          = RHSecondaryTitleLabel(fontSize: 18)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(article: Article) {
        title.text = article.title
        author.text = article.authors
    }
    
    private func configure() {
        addSubview(title)
        addSubview(author)
        
        title.numberOfLines = 0
        
        let views = [title, author]
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12),
            title.heightAnchor.constraint(equalToConstant: 50),
            
            author.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            author.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            author.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12),
            author.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    
    func tapped () {
        
    }
}
