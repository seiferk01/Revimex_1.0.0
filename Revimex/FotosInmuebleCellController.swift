//
//  FotosInmuebleCellController.swift
//  Revimex
//
//  Created by Maquina 53 on 11/12/17.
//  Copyright © 2017 Revimex. All rights reserved.
//

import UIKit
import FontAwesome_swift

class FotosInmuebleCellController: UITableViewCell {
    
    
    @IBOutlet weak var labelPerspectiva: UILabel!
    @IBOutlet weak var imgPerspectiva: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgPerspectiva.image = UIImage.fontAwesomeIcon(name: .camera,textColor: UIColor.black,size: CGSize(width: 100, height: 100));
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
