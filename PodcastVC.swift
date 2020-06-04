//
//  PodcastVC.swift
//  RingerHub
//
//  Created by Jon Miller on 5/13/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import UIKit
import FeedKit
import SafariServices

class PodcastVC: UIViewController {
    
    var tableView = UITableView()
    var podcasts: [Podcast] = []
    let url = URL(string: "https://rss.art19.com/the-bill-simmons-podcast")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        fetchData(url: url)
        configureTableView()
    }
    
    
    func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }


    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PodcastCell.self, forCellReuseIdentifier: PodcastCell.reuseID)
        tableView.rowHeight = 100
        tableView.pin(to: view)
    }
    
    
    private func fetchData(url: URL) {
        let parser = FeedParser(URL: url)
        let feed = try! parser.parse().get().rssFeed
        
        if let count = feed?.items?.count {
            for n in 0...count-1 {
                let title = feed?.items?[n].title
                let epDescription = feed?.items?[n].iTunes?.iTunesSummary
                let link = feed?.items?[n].enclosure?.attributes?.url
                let image = feed?.image?.url
                
                var p = Podcast()
                p.episodeTitle = title
                p.episodeDescription = epDescription
                p.link = link
                p.thumbnail = image
                podcasts.append(p)
            }
        }
    }

}
extension PodcastVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        podcasts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PodcastCell.reuseID) as! PodcastCell
        let podcast = self.podcasts[indexPath.row]
        cell.set(podcast: podcast)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let podcast = podcasts[indexPath.row]
        let url = URL(string: podcast.link!)
        let safariVC = SFSafariViewController(url: url!)
        present(safariVC, animated: true)
    }
    
}
