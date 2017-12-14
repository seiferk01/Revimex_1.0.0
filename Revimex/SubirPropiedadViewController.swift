//
//  SubirPropiedadViewController.swift
//  Revimex
//
//  Created by Maquina 53 on 06/12/17.
//  Copyright © 2017 Revimex. All rights reserved.
//

import UIKit

class SubirPropiedadViewController: UIViewController{
    
    
    @IBOutlet weak var anchoBtnAnt: NSLayoutConstraint!
    @IBOutlet weak var altoBtnAnt: NSLayoutConstraint!
    @IBOutlet weak var anchoBtnSig: NSLayoutConstraint!
    @IBOutlet weak var altoBtnSig: NSLayoutConstraint!
    
    
    @IBOutlet weak var cnVwFormularios: UIView!
    
    @IBOutlet weak var btnSig: UIButton!
    @IBOutlet weak var btnAnt: UIButton!
    
    private struct orgBtn{
        private var orgAnt: UIButton!;
        private var orgSig: UIButton!;
        init(orgAnt:UIButton!,orgSig:UIButton!) {
            self.orgAnt = orgAnt;
            self.orgSig = orgSig;
        }
        
        func getOrgAnt()->UIButton!{
            return self.orgAnt;
        }
        
        func getOrgSig()->UIButton!{
            return self.orgSig;
        }
        
    };
    
    private var org_Btn:orgBtn!;
    
    
    var detallesInmueble: DetallesInmuebleController!;
    var ubicacionInmueble: UbicacionInmuebleController!;
    var fotosInmueble: FotosInmuebleController!;
    
    var views:[UIViewController?]!;
    
    var cont: Int!;
    
    private var actualViewController: UIViewController?{
        didSet{
            removeInactiveViewController(inactiveViewController: oldValue);
            updateActiveViewController();
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cont = 0;
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        
        detallesInmueble = storyboard.instantiateViewController(withIdentifier: "DetallesInmueble") as! DetallesInmuebleController ;
        ubicacionInmueble = storyboard.instantiateViewController(withIdentifier: "UbicacionInmueble") as! UbicacionInmuebleController;
        fotosInmueble = storyboard.instantiateViewController(withIdentifier: "FotosInmueble") as! FotosInmuebleController;
        
        fotosInmueble.sizeMax = cnVwFormularios.frame;
        
        
        views = [detallesInmueble,ubicacionInmueble,fotosInmueble];
        
        
        
        btnSig = Utilities.genearSombras(btnSig);
        btnSig.tag = 2;
        
        let laySig = btnSig.layer;
        laySig.cornerRadius = 18;
        btnSig = cambiarBtn(titulo: String.fontAwesomeIcon(name: .chevronRight), btn: btnSig,id: 1, layer: laySig, font: UIFont.fontAwesome(ofSize: 34), accion: #selector(actSig(_:)));
        
        btnAnt = Utilities.genearSombras(btnAnt);
        btnAnt.tag = 1;
        let layAnt = btnAnt.layer;
        layAnt.cornerRadius = 18;
        btnAnt = cambiarBtn(titulo: String.fontAwesomeIcon(name: .chevronLeft), btn: btnAnt, id: 1, layer: layAnt, font: UIFont.fontAwesome(ofSize: 34), accion: #selector(actAnt(_:)));
        
        actualizar();
        
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
            activeVC.view.frame = cnVwFormularios.bounds;
            cnVwFormularios.addSubview(activeVC.view);
            activeVC.didMove(toParentViewController: self);
        }
    }
    
    private func actualizar(){
        if(cont == 0){
            let layAnt = btnAnt.layer;
            layAnt.cornerRadius = 0;
            btnAnt = cambiarBtn(titulo: "Cancelar", btn: btnAnt, id: 0, layer: layAnt, font: UIFont(name: "HelveticaNeue-Bold", size: 20)!, accion: #selector(cancelar));
        }else{
            let layAnt = btnAnt.layer;
            layAnt.cornerRadius = 18;
            btnAnt = cambiarBtn(titulo: String.fontAwesomeIcon(name: .chevronLeft), btn: btnAnt, id: 1, layer: layAnt, font: UIFont.fontAwesome(ofSize: 34), accion: #selector(actAnt(_:)));
        }
        if(cont == 2){
            let laySig = btnSig.layer;
            laySig.cornerRadius = 0;
            btnSig = cambiarBtn(titulo: "Guardar", btn: btnSig,id: 0,layer: laySig,font: UIFont(name: "HelveticaNeue-Bold", size: 20)!,accion: #selector(guardar));
        }else{
            let laySig = btnSig.layer;
            laySig.cornerRadius = 18;
            btnSig = cambiarBtn(titulo: String.fontAwesomeIcon(name: .chevronRight), btn: btnSig,id: 1, layer: laySig, font: UIFont.fontAwesome(ofSize: 34), accion: #selector(actSig(_:)));
        }
        actualViewController = views[cont];
    }
    
    @IBAction func actSig(_ sender: UIButton) {
        if(validar()){
            if(cont<3){
                cont = cont + 1;
                actualizar();
            }
        }else{
            present(Utilities.showAlertSimple("Aviso", "Por favor llene los campos en rojo"), animated: true);
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true;
    }
    
    @IBAction func actAnt(_ sender: UIButton) {
        if(cont>0){
            cont = cont - 1;
            actualizar();
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func validar()->Bool{
        let actual = actualViewController as! FormValidate;
        return actual.esValido();
    }
    
    private func cambiarBtn(titulo:String,btn:UIButton,id:Int,layer: CALayer,font:UIFont,accion: Selector)->UIButton{
        
        btn.layer.cornerRadius = layer.cornerRadius;
        
        btn.titleLabel?.font = font ;

        btn.setTitle(titulo, for: .normal);
        
        btn.removeTarget(nil, action: nil, for: .allEvents);
        btn.addTarget(self, action:accion, for: .touchUpInside);
        
        switch id {
        case 0:
            if(btn.tag == 1){
                altoBtnAnt.constant = 16;
                anchoBtnAnt.constant = 260;
            }else{
                altoBtnSig.constant = 16;
                anchoBtnSig.constant = 260;
            }
            break;
        case 1:
            if(btn.tag == 1){
                altoBtnAnt.constant = 8;
                anchoBtnAnt.constant = 319;
            }else{
                altoBtnSig.constant = 8;
                anchoBtnSig.constant = 319;
            }
            break;
        default:
            print("ERROR");
        }
        
        return btn;
        
    }
    
    @objc func cancelar(){
        navigationController?.popViewController(animated:true);
        self.dismiss(animated: true, completion: nil);
    }
    
    @objc func guardar(){
        if(actualViewController as! FormValidate).esValido(){
            let rowsDetalles = (detallesInmueble)?.obtValores()!;
            let rowsUbicacion = (ubicacionInmueble)?.obtValores()!;
            let rowsFotos = (fotosInmueble)?.obtValores()!;
            let rowTotal = [
                "detallesInmueble" : rowsDetalles!,
                "ubicacionInmueble" : rowsUbicacion!,
                "fotosInmueble" : rowsFotos!
            ];
            print(rowTotal);
        };
    }
    
}
