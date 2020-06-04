//
//  NewsVC.swift
//  RingerHub
//
//  Created by Jon Miller on 5/13/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import UIKit
import FeedKit
import SafariServices

class NewsVC: UIViewController {

    var tableView = UITableView()
    var articles: [Article] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        fetchData()
        configureTableView()

    }
    
    
    func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RHTableCell.self, forCellReuseIdentifier: RHTableCell.reuseID)
        tableView.rowHeight = 100
        tableView.pin(to: view)
    }
    
    
    private func fetchData() {
        let feedURL = URL(string: "https://www.theringer.com/rss/index.xml")!
        let parser = FeedParser(URL: feedURL)
        
        let feed = try! parser.parse().get().atomFeed
        
        if let count = feed?.entries?.count {
            for n in 0...count-1 {
                let title = feed?.entries?[n].title
                let author = feed?.entries?[n].authors?.compactMap({ $0.name }).joined(separator: ", ") ?? ""
                let id = feed?.entries?[n].id
                
                var a = Article()
                a.title = title
                a.authors = author
                a.id = id
                articles.append(a)
                
            }
        }
        
    }
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RHTableCell.reuseID) as! RHTableCell
        let article = articles[indexPath.row]
        cell.set(article: article)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let url = URL(string: article.id!)
        let safariVC = SFSafariViewController(url: url!)
        present(safariVC, animated: true)
    }
    
}
