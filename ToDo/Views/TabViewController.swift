//
//  TabViewController.swift
//  ToDo
//
//  Created by Vinitha Rao A on 16/03/22.
//

import UIKit

class TabBarController: UITabBarController  {
    

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .white
           tabBar.tintColor = .systemBlue
           setupVCs()
    }
    
    func setupVCs() {
        viewControllers = [
                createNavController(for: ToDoViewController(), title: NSLocalizedString("ToDo", comment: ""), image: UIImage(systemName: "checklist")!),
                createNavController(for: TagViewController(), title: NSLocalizedString("Tags", comment: ""), image: UIImage(systemName: "tag")!),
            ]
        }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                      title: String,
                                                      image: UIImage) -> UIViewController {
            let navController = UINavigationController(rootViewController: rootViewController)
            navController.tabBarItem.title = title
            navController.tabBarItem.image = image
            rootViewController.navigationItem.title = title
            return navController
    }

}

extension TabBarController: UITabBarControllerDelegate {
    
}


