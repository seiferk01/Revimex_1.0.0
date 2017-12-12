//
//  UbicacionInmuebleController.swift
//  Revimex
//
//  Created by Maquina 53 on 07/12/17.
//  Copyright © 2017 Revimex. All rights reserved.
//

import UIKit
import Eureka

class UbicacionInmuebleController: FormViewController {
    
    public var codeZip:ZipCodeRow!;
    public var edo: ActionSheetRow<String>!;
    public var mun: ActionSheetRow<String>!;
    public var col:ActionSheetRow<String>!;
    public var calle:TextRow!;
    public var numExt:IntRow!;
    public var mnz:TextRow!;
    public var lote:TextRow!;
    public var tipoCalle:ActionSheetRow<String>!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeZip = ZipCodeRow(){ row in
            row.title = "Código Postal";
            row.value = "";
            row.tag = "code_zip";
        };
        
        edo = ActionSheetRow<String>(){row in
            row.title = "Estado";
            row.options = [""];
            row.value = "";
            row.tag = "edo";
        };
        
        mun = ActionSheetRow<String>(){row in
            row.title = "Municipio";
            row.options = [""];
            row.value = "";
            row.tag = "mun"
        };
        
        col = ActionSheetRow<String>{row in
            row.title = "Colonia";
            row.options = [""];
            row.value = "";
            row.tag = "col";
        }
        
        calle = TextRow(){ row in
            row.title = "Calle";
            row.value = "...";
            row.tag = "calle";
        }
        
        numExt = IntRow(){row in
            row.title = "Número Exterior";
            row.tag = "numExt";
        }
        
        mnz = TextRow(){row in
            row.title = "Manzana";
            row.value = "...";
            row.tag = "mnz";
        }
        
        lote = TextRow(){row in
            row.title = "Lote";
            row.value = "...";
            row.tag = "lote";
        }
        
        tipoCalle = ActionSheetRow<String>(){row in
            row.title = "Tipo de Calle";
            row.options = [""];
            row.value = "";
            row.tag = "tipoCalle";
        }
        
        form+++Section("Ubicacion de su Inmueble")<<<codeZip<<<edo<<<mun<<<col<<<calle<<<numExt<<<mnz<<<lote<<<tipoCalle;
        events();
    }
    
    private func events(){
        codeZip.onChange({ row in
            if(row.value != nil){
                if(Utilities.isValidZip((row.value)!)){
                    
                    let urlZip = Utilities.ZIPCODES_URL+(row.value?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines))!;
                    self.datosByZipCode(urlZip){datos in
                        OperationQueue.main.addOperation {
                            self.col.options = (datos["colonias"] as! [String]);
                        }
                    }
                }
            }
        })
    }
    
    
    private func datosByZipCode(_ urlZip:String!,completado:@escaping (_ datos:[String:Any?])->Void){
        var datos:[String:Any?] = [:];
        if let url = URL(string: urlZip){
            var request = URLRequest(url: url);
            request.httpMethod = "GET";
            let session = URLSession.shared;
            session.dataTask(with: request){(data,response,error) in
                if let data = data{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data) as! [String:Any?];
                        let datosD = json as NSDictionary;
                        datos["colonias"] = datosD["colonias"] as! NSArray;
                        datos["municipio"] = datosD["municipio"] as! String;
                        completado(datos as [String:Any?]);
                    }catch{
                        OperationQueue.main.addOperation {
                            self.present(Utilities.showAlertSimple("ERROR", "Error en JSON_ZIP_CODE"), animated: true);
                        }
                    }
                }
                
                }.resume();
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
