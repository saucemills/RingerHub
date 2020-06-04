//
//  YouTubeVC.swift
//  RingerHub
//
//  Created by Jon Miller on 5/13/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import UIKit
import SwiftyJSON
import SafariServices

class YouTubeVC: UIViewController {
    
    var tableView = UITableView()
    var videos: [Video] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureTableView()
        fetchData()
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VideoCell.self, forCellReuseIdentifier: VideoCell.reuseID)
        tableView.rowHeight = 235
        tableView.pin(to: view)
    }
    
    
    func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func fetchData() {
        let youTubeUrl = "https://www.googleapis.com/youtube/v3/playlistItems?part=contentDetails%2C%20snippet&maxResults=20&playlistId=UUT83YP07yVuaH9J19YABhlw&key=AIzaSyDa2u3n1ikyhJu3K1DgA3wr7ADWnqMA5ok"

        let url = URL(string: youTubeUrl)!

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                let json = try! JSON(data: data)
                for n in 0...json["items"].count-1 {
                    let title = json["items"][n]["snippet"]["title"].stringValue
                    let published = json["items"][n]["snippet"]["publishedAt"].stringValue
                    let thumbnail = json["items"][n]["snippet"]["thumbnails"]["medium"]["url"].stringValue
                    let videoId = json["items"][n]["contentDetails"]["videoId"].stringValue
                    
                    let v = Video(title: title, publishedAt: published, thumbnailUrl: thumbnail, videoID: videoId)
                    self.videos.append(v)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }.resume()
    }
}

extension YouTubeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoCell.reuseID) as! VideoCell
        let video = self.videos[indexPath.row]
        cell.set(video: video)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = videos[indexPath.row]
        let baseUrl = "https://www.youtube.com/watch?v="
        let newURL = baseUrl + video.videoID
        let url = URL(string: newURL)
        let safariVC = SFSafariViewController(url: url!)
        present(safariVC, animated: true)
    }
}
