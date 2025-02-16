//
//  SceneDelegate.swift
//  Filmania-IOS
//
//  Created by Furkan Türkyaşar on 9.02.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var keychainId: String?
    var isFirstTime: Bool?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        setupKeychainId()
        //BaseKeychainManager.shared[BaseConstant.Keys.keychainId] = nil
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        print("is first time \(String(describing: isFirstTime))")
        isFirstTime = true
        if let isFirstTime = isFirstTime, isFirstTime == true {
            window.rootViewController = WalktroughViewController()
        } else {
            window.rootViewController = ViewController()
        }
        
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func setupKeychainId() {
        if let id: String = BaseKeychainManager.shared[BaseConstant.Keys.keychainId],
           !id.isEmpty {
            keychainId = id
            print("Keychain id: \(id)")
            //isFirstTime = false
            return
        }
        
        let newKeychainId = BaseUtil.randomString(length: 10)
        keychainId = newKeychainId
        print("New Keychain id: \(newKeychainId)")
        isFirstTime = true
        BaseKeychainManager.shared[BaseConstant.Keys.keychainId] = newKeychainId
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
    
    
}

