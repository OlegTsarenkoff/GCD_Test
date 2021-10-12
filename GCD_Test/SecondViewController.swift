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
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://klike.net/uploads/posts/2020-01/1578212659_1.jpeg")
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
        self.image = UIImage(data: imageData)
    }
}
