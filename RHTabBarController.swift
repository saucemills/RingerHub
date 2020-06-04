//
//  RHTabBarController.swift
//  RingerHub
//
//  Created by Jon Miller on 5/13/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import UIKit

class RHTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor     = .systemGreen
        viewControllers                     = [createNewsNC(), createYouTubeNC(), createPodcastNC()]    }
    
    func createNewsNC() -> UINavigationController {
        let newsVC = NewsVC()
        newsVC.title = "Articles"
        newsVC.tabBarItem = UITabBarItem(title: "Articles", image: SFSymbols.news, tag: 0)
        return UINavigationController(rootViewController: newsVC)
    }
    
    
    func createYouTubeNC() -> UINavigationController {
        let videoVC = YouTubeVC()
        videoVC.title = "Youtube"
        videoVC.tabBarItem = UITabBarItem(title: "Youtube", image: SFSymbols.tv, tag: 1)
        
        return UINavigationController(rootViewController: videoVC)
    }
    
    
    func createPodcastNC() -> UINavigationController {
        let podcastNC = PodcastVC()
        podcastNC.title = "Podcasts"
        podcastNC.tabBarItem = UITabBarItem(title: "Podcasts", image: SFSymbols.mic, tag: 2)
        
        return UINavigationController(rootViewController: podcastNC)
    }

}
