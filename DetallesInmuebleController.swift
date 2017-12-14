import UIKit
import Eureka

class DetallesInmuebleController: FormViewController,FormValidate{
    var rows: [String : Any?]?
    
    let tipoInmuebleArray = ["Casa","Departamento","Residencia"];
    let numsC = ["0","1","2","3","4","5"];
    let nums = ["1","2","3","4","5"];
    let serviciosBasicosArray = ["Agua","Luz Eléctrica","Gas","Teléfono","Internet","Vigilancia","Elevador","Interfon","Mantenimeinto"];
    let detallesArray = ["Amueblado","Accesos para Discapasitados","Posible Ampliación"];
    let areasArray = ["Área de Mascotas","Área de Juegos","Área de Descanso","Closet","Cuarto de TV","Cocina","Sala Comedor","Cuarto de Lavado","Terraza","Balcón","Zotehuela","Cisterna","Jardín","Bodega","Salón de Eventos","Gimnasio","Piscina","Roofgarden"];
    let entornoArray = ["Zona Ruidosa","Zona de Riesgo","Fraccionamiento Privado"];
    
    public var tipoInmueble:ActionSheetRow<String>!;
    public var recamaras:ActionSheetRow<String>!;
    public var banos:ActionSheetRow<String>!;
    public var terreno:IntRow!;
    public var construccion:IntRow!;
    public var niveles:ActionSheetRow<String>!;
    public var estacionamiento:ActionSheetRow<String>!
    public var antiguedad:IntRow!;
    public var descripcion:TextAreaRow!;
    public var serviciosBasicos:MultipleSelectorRow<String>!;
    public var areas:MultipleSelectorRow<String>!;
    public var detalles:MultipleSelectorRow<String>!;
    public var entorno:MultipleSelectorRow<String>!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rows = [:];
        tipoInmueble = ActionSheetRow<String>(){ row in
            row.tag = "tipoInm";
            row.title = "Tipo de inmueble";
            row.options = tipoInmuebleArray;
            row.selectorTitle = "Seleccione el tipo de inmueble";
            row.add(rule: RuleRequired());
        };
        
        recamaras = ActionSheetRow<String>(){ row in
            row.tag = "rcms";
            row.title = "Recámaras"
            row.options = nums;
            row.selectorTitle = "Número de recámaras";
            row.value = row.options?[0];
            row.add(rule: RuleRequired());
        };
        
        banos = ActionSheetRow<String>(){ row in
            row.tag = "bns";
            row.title = "Baños";
            row.options = nums;
            row.selectorTitle = "Número de baños"
            row.value = row.options?[0];
            row.add(rule: RuleRequired());
        }
        
        terreno = IntRow(){ row in
            row.tag = "trrn";
            row.title = "Superficie del terreno";
            row.placeholder = "0";
            row.add(rule: RuleRequired());
        };
        
        construccion = IntRow(){ row in
            row.tag = "cnst";
            row.title = "Superficie de Construcciòn"
            row.placeholder = "0";
            row.add(rule: RuleRequired());
        };
        
        niveles = ActionSheetRow<String>(){ row in
            row.tag = "nvls";
            row.title = "Niveles";
            row.options = nums;
            row.selectorTitle = "Cantidad de niveles";
            row.value = row.options?[0];
            row.add(rule: RuleRequired());
        };
        
        estacionamiento = ActionSheetRow<String>(){ row in
            row.tag = "estcn";
            row.title = "Estacionamiento";
            row.options = numsC;
            row.selectorTitle = "Plazas de estacionamiento"
            row.value = row.options?[0];
            row.add(rule: RuleRequired());
        };
        
        antiguedad = IntRow(){ row in
            row.tag = "antg";
            row.title = "Años de Atiguedad";
            row.placeholder = "0";
            row.add(rule: RuleRequired());
        };
        
        descripcion = TextAreaRow("Seleccione los servicios con los que cuente"){ row in
            row.tag = "dscrp";
            row.title = "Ingrese una Descripción de su inmueble"
            row.placeholder="Descripción...";
            row.add(rule: RuleRequired());
        };
        
        serviciosBasicos = MultipleSelectorRow<String>(){ row in
            row.tag = "srvBsc";
            row.title = "Servicios Básicos";
            row.options = serviciosBasicosArray;
            row.selectorTitle = "Seleccione los Servicios";
            row.tag = "sb"
            row.add(rule: RuleRequired());
        };
        
        areas = MultipleSelectorRow<String>{ row in
            row.tag = "ars";
            row.title = "Áreas";
            row.options = areasArray;
            row.selectorTitle = "Seleccione áreas que tenga su propiedad";
            row.tag = "ars"
        }
        
        detalles = MultipleSelectorRow<String>{ row in
            row.tag = "dtlls";
            row.title = "Detalles";
            row.options = detallesArray;
            row.selectorTitle = "Detalles de su propiedad"
            row.tag = "dtll"
        };
        
        entorno = MultipleSelectorRow<String>{ row in
            row.tag = "entrn";
            row.title = "Entorno";
            row.options = entornoArray;
            row.selectorTitle = "Entorno en el que se encuentra su propiedad";
            row.tag = "ent"
        };
        
        form +++ Section("Detalles del Inmueble")<<<tipoInmueble<<<recamaras<<<banos<<<terreno<<<construccion<<<niveles<<<estacionamiento<<<antiguedad<<<descripcion+++Section("Servicios con los que Cuente")<<<serviciosBasicos<<<areas<<<detalles<<<entorno;
        
        rowKeyboardSpacing = 5;
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validar(){
        rows![tipoInmueble.tag!] = self.tipoInmueble.validate();
        rows![recamaras.tag!] = self.recamaras.validate();
        rows![banos.tag!] = self.banos.validate();
        rows![terreno.tag!] = self.terreno.validate();
        rows![construccion.tag!] = self.construccion.validate();
        rows![niveles.tag!] = self.niveles.validate();
        rows![estacionamiento.tag!] = self.estacionamiento.validate();
        rows![antiguedad.tag!] = self.antiguedad.validate();
        rows![descripcion.tag!] = self.descripcion.validate();
        rows![serviciosBasicos.tag!] = self.serviciosBasicos.validate();
        rows![areas.tag!] = self.areas.validate();
        rows![detalles.tag!] = self.detalles.validate();
        rows![entorno.tag!] = self.entorno.validate();
    }
    
    func obtValores()->[String:Any?]!{
        rows![tipoInmueble.tag!] = self.tipoInmueble.value!;
        rows![recamaras.tag!] = self.recamaras.value!;
        rows![banos.tag!] = self.banos.value!;
        rows![terreno.tag!] = self.terreno.value!;
        rows![construccion.tag!] = self.construccion.value!;
        rows![niveles.tag!] = self.niveles.value!;
        rows![estacionamiento.tag!] = self.estacionamiento.value!;
        rows![antiguedad.tag!] = self.antiguedad.value!;
        rows![descripcion.tag!] = self.descripcion.value!;
        rows![serviciosBasicos.tag!] = self.serviciosBasicos.value!;
        rows![areas.tag!] = self.areas.value;
        rows![detalles.tag!] = self.detalles.value;
        rows![entorno.tag!] = self.entorno.value;
        return self.rows;
    }

    func esValido() -> Bool {
        var valido = true;
        validar();
        let keys = rows?.keys;
        for key in keys!{
            if(rows![key] as! [ValidationError?]).count>0{
                let row = form.rowBy(tag: key);
                row?.baseCell.textLabel?.textColor = .red;
                if(row is TextAreaRow){
                    let row = row as! TextAreaRow;
                    row.placeholder = "Descripción \n\n Este campo es Obligatorio...";
                }
                valido = false
            }else{
                
            }
        }
        return valido;
    }
    
}
