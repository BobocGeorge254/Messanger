//
//  ViewController.swift
//  Messanger
//
//  Created by George Boboc on 16.06.2023.
//

import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let logged_in = UserDefaults.standard.bool(forKey: "logged_in")
        
        if (!logged_in) {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
            
        }
    }
    
    

}

