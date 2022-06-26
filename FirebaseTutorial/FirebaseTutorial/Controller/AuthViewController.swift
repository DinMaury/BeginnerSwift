//
//  AuthViewController.swift
//  FirebaseTutorial
//
//  Created by Maury on 13/06/22.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import FBSDKLoginKit

class AuthViewController: UIViewController {

    @IBOutlet weak var authStackView: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var facebookButon: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Autenticación"
        // Analytics Event
        //se colocar en el codigo para saber donde se metio el usuario y notar eventos en firebase
        Analytics.logEvent("InitScreen", parameters: ["message" : "Integracion de Firebase completa"])
        
        // Comprobar la sesión del usuario autenticado
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String,
           let provider = defaults.value(forKey: "provider") as? String {
            
            authStackView.isHidden = true
            
            navigationController?.pushViewController(HomeViewController(email: email, provider: ProviderType.init(rawValue: provider)!), animated: false)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authStackView.isHidden = false
    }
    
    private func showHome(result: AuthDataResult?, error: Error?, provider: ProviderType) {
        
        if let result = result, error == nil {
            
            self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: provider), animated: true)
        } else {
            let alertController = UIAlertController(title: "Error", message: "Se ha producido un error de autenticación mediante \(provider.rawValue)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

    @IBAction func singUpButtonAction(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                
                self.showHome(result: result, error: error, provider: .basic)
            }
        }
        
    }
    @IBAction func logInButtonAction(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                self.showHome(result: result, error: error, provider: .basic)
            }
        }
    }
    
    
    
    @IBAction func googleButtonAction(_ sender: Any) {
        
        GIDSignIn.sharedInstance.signOut()
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

          if let error = error {
            print(error)
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { result, error in
                self.showHome(result: result, error: error, provider: .google)
            }
        }
    }
    @IBAction func facebookButtonAction(_ sender: Any) {
        
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: [.email], viewController: self) { (result) in
            switch result {
            case .success(granted: let granted, declined: let declined, token: let token):
                
                let credential = FacebookAuthProvider.credential(withAccessToken: token?.tokenString ?? "")
                
                Auth.auth().signIn(with: credential) { result, error in
                    self.showHome(result: result, error: error, provider: .facebook)
                    
                }
            case .cancelled:
                break
            case .failed(_):
                break
            }
        }
    }
}

