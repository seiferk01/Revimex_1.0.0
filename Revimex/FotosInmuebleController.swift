//
//  FotosInmuebleController.swift
//  Revimex
//
//  Created by Maquina 53 on 11/12/17.
//  Copyright © 2017 Revimex. All rights reserved.
//

import UIKit

class FotosInmuebleController: UIViewController,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet public weak var tableFotosInmueble: UITableView!;
    
    public var sizeMax:CGRect!;
    
    public struct Cell{
        var img:UIImage!;
        var textLabel:String!;
        init(_ textLabel:String!) {
            self.textLabel = textLabel;
        }
    }
    
    private var data:[Cell] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableFotosInmueble.frame = self.view.frame;
        tableFotosInmueble.layer.bounds = self.view.layer.bounds;
        tableFotosInmueble.isScrollEnabled = false;
        
        data.append(Cell("Perspectiva Frontal"));
        data.append(Cell("Perspectiva Izquierda"));
        data.append(Cell("Perspectiva Derecha"));
        data.append(Cell("Perspectiva Posterior"));
        
        tableFotosInmueble.dataSource = self;
        tableFotosInmueble.translatesAutoresizingMaskIntoConstraints = true;
        
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
