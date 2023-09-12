//
//  ViewController.swift
//  Netflix Clone
//
//  Created by Haytham on 28/08/2023.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: ComingSoonVC())
        let vc3 = UINavigationController(rootViewController: TopSearchesVC())
        let vc4 = UINavigationController(rootViewController: DownloadsVC())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.tabBarItem.title = "Home"
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc2.tabBarItem.title = "Coming Soon"
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.title = "Top Searches"
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        vc4.tabBarItem.title = "Downloads"
        tabBar.tintColor = .label

        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }


}

