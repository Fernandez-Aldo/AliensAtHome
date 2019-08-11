//
//  DetailViewController.swift
//  AliensAtHome
//
//  Created by MAC Consultant on 8/9/19.
//  Copyright © 2019 Aldo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!

    
    var networking: Networking = Networking()
    var articleData: PostData?
    
    func configureView() {
        
        articleTitle.text = articleData?.title
        self.title = articleData?.author
        
        if let image = articleData?.preview?.images.first?.source.url {
            networking.loadImage(image: image) { image in
                DispatchQueue.main.async {
                    self.articleImage.image = image
                }
            }
        } else {
            self.articleImage.image = UIImage(named: "NoImage")
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

