//
//  UserInfoCell.swift
//  Revimex
//
//  Created by Maquina 53 on 14/12/17.
//  Copyright © 2017 Revimex. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {

    public static let KEY = "CELL_USER";
    @IBOutlet weak var contenedor: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgUser.contentMode = .scaleAspectFit;
        imgUser.image = UIImage.fontAwesomeIcon(name: .userO, textColor: UIColor.black, size: CGSize(width: 100, height: 100));
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
