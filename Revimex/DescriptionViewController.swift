//
//  DescriptionViewController.swift
//  Revimex
//
//  Created by Seifer on 30/10/17.
//  Copyright © 2017 Revimex. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var vistasContainer: UIView!
    
    var info:UIViewController?
    var ubication:UIViewController?
    
    var arrayViews:[UIViewController?]!;
    
    private var actualViewController: UIViewController?{
        didSet{
            removeInactiveViewController(inactiveViewController: oldValue);
            updateActiveViewController();
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        propiedad = Details(Id: "",calle: "",colonia: "",construccion: "",cp: "",estacionamiento: "",estado: "",habitaciones: "",idp: "",lat: "0",lon: "0",municipio: "",niveles: "",origen_propiedad: "",patios: "",precio: "",terreno: "",tipo: "",descripcion: "",pros: "",wcs: "",fotos: [])
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        info = storyboard.instantiateViewController(withIdentifier: "Info") as! InfoController
        ubication = storyboard.instantiateViewController(withIdentifier: "Ubication") as! UbicationContoller
        
        arrayViews = [info,ubication]
        
        actualViewController = arrayViews[0];
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func removeInactiveViewController(inactiveViewController: UIViewController?){
        if let inactiveVC = inactiveViewController{
            inactiveVC.willMove(toParentViewController: nil);
            inactiveVC.view.removeFromSuperview();
            inactiveVC.removeFromParentViewController();
        }
    }
    
    private func updateActiveViewController(){
        if let activeVC = actualViewController{
            addChildViewController(activeVC);
            activeVC.view.frame = vistasContainer.bounds;
            vistasContainer.addSubview(activeVC.view);
            activeVC.didMove(toParentViewController: self);
        }
    }

    @IBAction func showDescription(_ sender: Any) {
        actualViewController = arrayViews[0];
    }
    
    @IBAction func showServices(_ sender: Any) {
        actualViewController = arrayViews[1];
    }
    
}
