import UIKit
import Eureka

class DetallesInmuebleController: FormViewController{
    
    let tipoInmueble = ["Casa","Departamento","Residencia"];
    let nums = ["0","1","2","3","4","5"];
    let serviciosBasicos = ["Vigilancia","Elevador","Interfon","Mantenimeinto"];
    let detalles = ["Amueblado","Acceso a Discapasitados","Posible Ampliación"];
    let areas = ["Área de Mascotas","Área de Juegos","Área de Descanso","Closet","Cuarto de TV","Cocina","Sala Comedor","Cuarto de Lavado","Terraza","Balcón","Zotehuela","Cisterna","Jardín","Bodega","Salón de Eventos","Gimnasio","Piscina","Roofgarden"];
    let entorno = ["Zona Ruidosa","Zona de Riesgo","Fraccionamiento Privado"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Detalles del Inmueble")
            <<< ActionSheetRow<String>(){ row in
                row.title = "Tipo de inmueble";
                row.options = tipoInmueble;
                row.selectorTitle = "Seleccione el tipo de inmueble";
                row.value = "";
            }<<<ActionSheetRow<String>(){ row in
                row.title = "Recámaras"
                row.options = nums;
                row.selectorTitle = "Número de recámaras";
                row.value = row.options?[0];
            }<<<ActionSheetRow<String>(){ row in
                row.title = "Baños";
                row.options = nums;
                row.selectorTitle = "Número de baños"
                row.value = row.options?[0];
            }<<<IntRow(){ row in
                row.title = "Superficie del terreno";
                row.placeholder = "0";
            }<<<IntRow(){ row in
                row.title = "Superficie de Construcciòn"
                row.placeholder = "0";
            }<<<ActionSheetRow<String>(){ row in
                row.title = "Niveles";
                row.options = nums;
                row.selectorTitle = "Cantidad de niveles";
                row.value = row.options?[0];
            }<<<ActionSheetRow<String>(){ row in
                row.title = "Estacionamiento";
                row.options = nums;
                row.selectorTitle = "Plazas de estacionamiento"
                row.value = row.options?[0];
            }<<<IntRow(){ row in
                row.title = "Años de Atiguedad";
                row.placeholder = "0";
            }<<<TextAreaRow("Seleccione los servicios con los que cuente"){ row in
                row.title = "Ingrese una Descripción de su inmueble"
                row.placeholder="Descripción...";
            }+++Section("Servicios con los que Cuente")<<<MultipleSelectorRow<String>(){ row in
                row.title = "Servicios Básicos";
                row.options = serviciosBasicos;
                row.selectorTitle = "Seleccione los Servicios";
            }<<<MultipleSelectorRow<String>{ row in
                row.title = "Áreas";
                row.options = areas;
                row.selectorTitle = "Seleccione áreas que tenga su propiedad";
            }<<<MultipleSelectorRow<String>{ row in
                row.title = "Detalles";
                row.options = detalles;
                row.selectorTitle = "Detalles de su propiedad"
            }<<<MultipleSelectorRow<String>{ row in
                row.title = "Entorno";
                row.options = entorno;
                row.selectorTitle = "Entorno en el que se encuentra su propiedad";
        }
        
        rowKeyboardSpacing = 10;
        
        /*print("········");
         for i in (tableView.tableHeaderView?.subviews)!{
         print(i.isHidden);
         }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
