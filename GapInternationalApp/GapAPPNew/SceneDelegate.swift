//
//  SceneDelegate.swift
//  GapAPPNew
//
//  Created by NAMAN GARG on 6/21/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var username: String?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else {
            return
        }
        
    }
    func openLoginView() {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "LoginViewController")
        self.window?.rootViewController = vc
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func showSplitViewController(_ user: String){
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let splitVC = storyboard.instantiateViewController(withIdentifier: "SplitViewController") as? UISplitViewController else { return  }
        username = user
        print(user)
        window?.rootViewController = splitVC
        
        guard
            let splitVC = window?.rootViewController as? UISplitViewController,
            let leftNavVC = splitVC.viewControllers.first as? UINavigationController,
            let masterVC = leftNavVC.viewControllers.first as? MasterTableViewController,
            let detailVC = (splitVC.viewControllers.last as? UINavigationController)?.topViewController as? DetailViewController
        else {
            return
        }
        if let user = username{
        detailVC.username = user
        masterVC.username = user
        }
        masterVC.delegate = detailVC
        //detailVC.navigationItem.leftItemsSupplementBackButton = true
        detailVC.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
    }
    


}

