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

    var controller: PostController!
    
    func configureView() {
        guard let articleData = controller?.selectedArticleData() else {
            // show error
            self.articleImage.image = UIImage(named: "NoImage")
            return
        }
        
        articleTitle.text = articleData.title
        self.title = articleData.author
        
        controller.fullImage(at: controller.selectedPostIndex) { image in
            guard let image = image else {
                self.articleImage.image = UIImage(named: "NoImage")
                return
            }
            DispatchQueue.main.async {
                self.articleImage.image = image
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
}

