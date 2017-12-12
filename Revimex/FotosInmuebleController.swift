//
//  FotosInmuebleController.swift
//  Revimex
//
//  Created by Maquina 53 on 11/12/17.
//  Copyright © 2017 Revimex. All rights reserved.
//

import UIKit

class FotosInmuebleController: UIViewController,UITableViewDataSource{
    
    @IBOutlet public weak var tableFotosInmueble: UITableView!;
    
    public struct cell{
        var img:UIImage!;
        var textLabel:String!;
    }
    
    private var data:[cell] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableFotosInmueble.dequeueReusableCell(withIdentifier:"cellFotosInmueble") as! FotosInmuebleCellController;
        
        //item.labelPerspectiva.text = data[]
        
        return item;
    }

}
