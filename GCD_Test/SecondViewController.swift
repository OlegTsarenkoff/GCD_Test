//
//  SecondViewController.swift
//  GCD_Test
//
//  Created by Oleg Tsarenkoff on 12.10.21.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        delay(3) {
            self.loginAlert()
        }
    }
    
    fileprivate func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "Зарегистрирован?", message: "Введите ваше логин и пароль", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (userNameTF) in
            userNameTF.placeholder = "Введите логин"
        }
        ac.addTextField { (userPasswordF) in
            userPasswordF.placeholder = "Введите пароль"
            userPasswordF.isSecureTextEntry = true
        }
        
        self.present(ac, animated: true, completion: nil)
    }
    
    fileprivate func fetchImage() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        imageURL = URL(string: "https://klike.net/uploads/posts/2020-01/1578212659_1.jpeg")
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
