import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var wireframe: LocationsWireframe!
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let navigationController = CustomNavigationController()
        window.rootViewController = navigationController
        
        self.window = window
        self.window?.makeKeyAndVisible()
        
        wireframe = .init(navigationController)
        wireframe.onLocationsList()
    }
}

