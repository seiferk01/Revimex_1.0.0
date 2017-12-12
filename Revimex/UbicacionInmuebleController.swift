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
    
    private let tipoCalleArray = ["Andador","Avenida","Bulevar","Calle","Callejón","Calzada","Camino Cerrada","Circuito","Conjunto Habitacional","Pasaje","Privada","Prolongación"];
    
    private var manualFlag:Bool!;
    
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
        manualFlag = false;
        
        codeZip = ZipCodeRow(){ row in
            row.title = "Código Postal";
            row.placeholder = "XXXXX";
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
            row.options = [];
            row.selectorTitle = "Por favor ingrese antes su Código Postal";
            row.tag = "col";
        }
        
        calle = TextRow(){ row in
            row.title = "Calle";
            row.placeholder = "...";
            row.tag = "calle";
        }
        
        numExt = IntRow(){row in
            row.title = "Número Exterior";
            row.tag = "numExt";
            row.placeholder = "Nº.  "
        }
        
        mnz = TextRow(){row in
            row.title = "Manzana";
            row.placeholder = "...";
            row.tag = "mnz";
        }
        
        lote = TextRow(){row in
            row.title = "Lote";
            row.placeholder = "...";
            row.tag = "lote";
        }
        
        tipoCalle = ActionSheetRow<String>(){row in
            row.title = "Tipo de Calle";
            row.options = tipoCalleArray;
            row.value = row.options?[0];
            row.tag = "tipoCalle";
        }
        
        form+++Section("Ubicacion de su Inmueble")<<<codeZip<<<edo<<<mun<<<col<<<calle<<<numExt<<<mnz<<<lote<<<tipoCalle;
        
        fillEstados{datos in
            OperationQueue.main.addOperation {
                self.edo.options = datos;
                self.edo.value = self.edo.options?[0];
            }
        };
        
        eventsCodeZip();
        eventsEstado();
        colEvent();
    }
    
    private func eventsCodeZip(){
        codeZip.onChange({row in
            if(row.value != nil && self.codeZip.isHighlighted){
                if(Utilities.isValidZip((row.value)!)){
                    let urlZip = Utilities.ZIPCODES_URL+(row.value?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines))!;
                    self.datosByZipCode(urlZip){datosZip in
                        OperationQueue.main.addOperation {
                            self.manualFlag = false;
                            
                            self.col.options = (datosZip["colonias"] as! [String]);
                            self.col.selectorTitle = "Ingrese su Colonia";
                            self.col.value = (self.col.options)?[0];
                            
                            self.col.reload();
                            
                            self.mun.value = datosZip["municipio"] as? String;
                            self.mun.reload();
                            
                            self.edo.value = datosZip["estado"] as? String;
                            self.edo.reload();
                            
                        }
                    }
                }
            }
        })
    }
    
    private func eventsEstado(){
        edo.onCellSelection({ alert,action in
            self.manualFlag = true;
        })
        
        edo.onChange({ row in
            if(row.value != nil && self.manualFlag){
                self.manualFlag = false;
                self.codeZip.value = "";
                let idEstado = (self.edo.options?.index(of: self.edo.value!))!+1;
                print(idEstado);
                self.getMunicipios(idEstado){datos in
                    
                    OperationQueue.main.addOperation {
                        self.mun.options = datos;
                        self.mun.value = self.mun.options?[0];
                        self.mun.updateCell();
                        
                        self.col.options = [];
                        self.col.value  = "";
                        self.col.selectorTitle = "Por favor ingrese antes su Código postal";
                        self.col.updateCell();
                    }
                    
                }
            }
        });
        
    }
    
    private func colEvent(){
        col.onCellSelection({ alert, action in
            if(self.col.options?.count as Int! <= 0){
                
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
                        datos["estado"] = datosD["estado"] as! String;
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
    
  
    // El id del Estado es la posicion en el arreglo + 1
    private func getMunicipios(_ idEstado:Int! ,completado:@escaping(_ datos:[String])->Void){
        let parametros:[String:Any?] = [
            "idEstado": idEstado
        ];
        
        if let url = URL(string: Utilities.MUNICIPIOS){
            var request = URLRequest(url: url);
            request.httpMethod = "POST";
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros, options: .prettyPrinted);
            }catch{
                print(error);
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type");
            let session = URLSession.shared;
            
            session.dataTask(with: request){(data,response,error) in
                
                if let data = data{
                    do {
                        let json = try JSONSerialization.jsonObject(with: data) as! [String:Any?];
                        let municipios = json["municipios"] as! NSArray;
                        var stringArray:[String] = [];
                        for mun in municipios{
                            let municipio = mun as? NSDictionary;
                            stringArray.append(municipio!["Municipio"] as! String);
                        }
                        completado(stringArray);
                    }catch{
                        print(error);
                    }
                }
                
                }.resume();
            
        }
    }
    
    private func fillEstados(completado:@escaping(_ datos:[String])->Void){
        if let url = URL(string: Utilities.ESTADOS){
            var request = URLRequest(url: url);
            request.httpMethod = "POST";
            let session = URLSession.shared;
            session.dataTask(with: request){(data,response,error) in
                if let data = data {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data) as! [String:Any?];
                        let estadoArray = json["estados"] as! NSArray;
                        var stringArray:[String] = [];
                        for element in estadoArray{
                            let estado = element as? NSDictionary;
                            stringArray.append(estado!["estado"] as! String);
                        }
                        completado(stringArray);
                    }catch{
                        OperationQueue.main.addOperation {
                            self.present(Utilities.showAlertSimple("ERROR", "Error en servidor de Estados"), animated: true);
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
