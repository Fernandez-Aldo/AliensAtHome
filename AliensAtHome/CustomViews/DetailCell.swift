//
//  DetailCell.swift
//  AliensAtHome
//
//  Created by MAC Consultant on 8/9/19.
//  Copyright © 2019 Aldo. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var created: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
