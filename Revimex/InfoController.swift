//
//  InfoController.swift
//  Revimex
//
//  Created by Seifer on 11/12/17.
//  Copyright © 2017 Revimex. All rights reserved.
//

import UIKit

class InfoController: UIViewController {
    
    @IBOutlet weak var descripcion: UITextView!
    @IBOutlet weak var contenedorCarousel: UIScrollView!
    @IBOutlet weak var favoritosBtn: UIButton!
    
    //variable para el carousel
    var vistaCarouselGrande = UIView()
    var contenedorCarouselGrande = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritosBtn.setBackgroundImage(UIImage(named: "favorites.png") as UIImage?, for: .normal)
        
        //verificar favoritos
        self.revisarFavoritos()
        
        //request a detalles
        requestDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //llamado a los detalles de la propiedad seleccionada
    func requestDetails() {
        
        let urlRequestDetails = "http://18.221.106.92/api/public/propiedades/detalle"
        
        let parameters = "id=" + idOfertaSeleccionada
        
        guard let url = URL(string: urlRequestDetails) else { return }
        
        var request = URLRequest (url: url)
        request.httpMethod = "POST"
        
        let httpBody = parameters.data(using: .utf8)
        
        request.httpBody = httpBody
        
        let session  = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            
            if let data = data {
                
                do {
                    let json = try JSONSerialization.jsonObject (with: data) as! [String:Any?]
                    
                    
                    if let propiedadSeleccionada = json["propiedad"] as? NSDictionary {
                        print("*********Propiedad seleccionada***********")
                        print(propiedadSeleccionada)
                        
                        if  let id = propiedadSeleccionada["Id"] as? String { propiedad.Id = id }
                        if  let calle = propiedadSeleccionada["calle"] as? String { propiedad.calle = calle }
                        if  let colonia = propiedadSeleccionada["colonia"] as? String { propiedad.colonia = colonia }
                        if  let construccion = propiedadSeleccionada["construccion"] as? String { propiedad.construccion = "Metros de construccion: " + construccion + "\n"}
                        if  let cp = propiedadSeleccionada["cp"] as? String { propiedad.cp = "C.P. " + cp }
                        if  let estacionamiento = propiedadSeleccionada["estacionamiento"] as? String { propiedad.estacionamiento = "Estacionamientos: " + estacionamiento + "\n"}
                        if  let estado = propiedadSeleccionada["estado"] as? String { propiedad.estado = estado }
                        if  let habitaciones = propiedadSeleccionada["habitaciones"] as? String { propiedad.habitaciones = "Habitaciones: " + habitaciones + "\n"}
                        if  let idp = propiedadSeleccionada["idp"] as? String { propiedad.idp = idp }
                        if  let lat = propiedadSeleccionada["lat"] as? String { propiedad.lat = lat }
                        if  let lon = propiedadSeleccionada["lon"] as? String { propiedad.lon = lon }
                        if  let municipio = propiedadSeleccionada["municipio"] as? String { propiedad.municipio = municipio }
                        if  let niveles = propiedadSeleccionada["niveles"] as? String { propiedad.niveles = "Niveles: " + niveles + "\n"}
                        if  let origen_propiedad = propiedadSeleccionada["origen_propiedad"] as? String { propiedad.origen_propiedad = origen_propiedad }
                        if  let patios = propiedadSeleccionada["patios"] as? String { propiedad.patios = "Patios: " + patios + "\n"}
                        if  let precio = propiedadSeleccionada["precio"] as? String { propiedad.precio = "Precio: $" + precio + "\n"}
                        if  let terreno = propiedadSeleccionada["terreno"] as? String { propiedad.terreno = "Metros de terreno: " + terreno + "\n"}
                        if  let tipo = propiedadSeleccionada["tipo"] as? String { propiedad.tipo = "Tipo de inmuble: " + tipo + "\n"}
                        if  let descripcion = propiedadSeleccionada["descripcion"] as? String { propiedad.descripcion = descripcion }
                        if  let pros = propiedadSeleccionada["pros"] as? String { propiedad.pros = pros }
                        if  let wcs = propiedadSeleccionada["wcs"] as? String { propiedad.wcs = wcs }
                        
                        if  let files = propiedadSeleccionada["files"] as? Array<Any?> {
                            for element in files{
                                if let file = element as? NSDictionary {
                                    if  let linkPublico = file["linkPublico"]! as? String{
                                        propiedad.fotos.append(linkPublico)
                                        print(propiedad.fotos)
                                    }
                                }
                            }
                        }
                    }
                    
                    
                } catch {
                    print("El error es: ")
                    print(error)
                }
                
                OperationQueue.main.addOperation({
                    self.incio()
                })
                
            }
        }.resume()
        
    }
    
    func incio() {
        
        print("***********Datos de la propiedad***************")
        print(propiedad.Id)
        print(propiedad.calle)
        print(propiedad.colonia)
        print(propiedad.construccion)
        print(propiedad.cp)
        print(propiedad.estacionamiento)
        print(propiedad.estado)
        print(propiedad.habitaciones)
        print(propiedad.idp)
        print(propiedad.lat)
        print(propiedad.lon)
        print(propiedad.municipio)
        print(propiedad.niveles)
        print(propiedad.origen_propiedad)
        print(propiedad.patios)
        print(propiedad.precio)
        print(propiedad.terreno)
        print(propiedad.tipo)
        print(propiedad.wcs)
        print(propiedad.fotos)
        
        //inicia asignacion de valores a descripcion
        if propiedad.descripcion != ""{
            descripcion.text = propiedad.descripcion
        }
        else if propiedad.pros != ""{
            descripcion.text = propiedad.pros
        }
        else {
            descripcion.text = "Descripcion no disponible"
        }
        
        descripcion.text = descripcion.text + "\n\nUBICACION\n"+propiedad.calle+" "+" "+propiedad.colonia+", "+propiedad.municipio+" "+propiedad.estado+" "+propiedad.cp+"."
        
        descripcion.text = descripcion.text + "\n\nINFORMACION\n"+propiedad.tipo+propiedad.habitaciones+propiedad.estacionamiento+propiedad.niveles+propiedad.patios+propiedad.terreno+propiedad.construccion+propiedad.precio
        
        descripcion.isEditable = false
        
        //muestra las fotos
        showPhotos()
        
    }
    
    //muestra las fotos
    func showPhotos() {
        
        let ancho = contenedorCarousel.bounds.width
        let largo = contenedorCarousel.bounds.height
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(carouselTapped(tapGestureRecognizer:)))
        contenedorCarousel.isUserInteractionEnabled = true
        contenedorCarousel.addGestureRecognizer(tapGestureRecognizer)
        
        contenedorCarousel.contentSize = CGSize(width: ancho * CGFloat(propiedad.fotos.count), height: largo)
        contenedorCarousel.isPagingEnabled = true
        contenedorCarousel.showsHorizontalScrollIndicator = false
        
        for (index, url) in propiedad.fotos.enumerated() {
            
            let marco = UIImageView(image: Utilities.traerImagen(urlImagen: url))
            
            marco.frame.origin.x = ancho * CGFloat(index)
            marco.frame.origin.y = 0
            marco.frame.size = CGSize(width: ancho, height: largo)
            contenedorCarousel.addSubview(marco)
            
        }
        
        
    }
    
    
    //accion al presionar en el carousel de fotos pequeño
    @objc func carouselTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        vistaCarouselGrande.frame = CGRect(x: 0 ,y: 0 ,width: self.view.frame.width,height: self.view.frame.height)
        vistaCarouselGrande.backgroundColor = UIColor.black
        vistaCarouselGrande.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        
        let ancho = view.bounds.width
        let largo = view.bounds.height
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageBigCarouselTapped(tapGestureRecognizer:)))
        vistaCarouselGrande.isUserInteractionEnabled = true
        vistaCarouselGrande.addGestureRecognizer(tapGestureRecognizer)
        
        
        contenedorCarouselGrande.frame.size = CGSize(width: view.bounds.width, height: view.bounds.width * (0.8))
        contenedorCarouselGrande.contentSize = CGSize(width: ancho * CGFloat(propiedad.fotos.count), height: view.bounds.width * (0.8))
        contenedorCarouselGrande.frame.origin.x = 0
        contenedorCarouselGrande.frame.origin.y = largo/4
        contenedorCarouselGrande.isPagingEnabled = true
        contenedorCarouselGrande.showsHorizontalScrollIndicator = false
        
        
        for (index, url) in propiedad.fotos.enumerated() {
            
            let marco = UIImageView(image: Utilities.traerImagen(urlImagen: url))
            
            marco.frame.origin.x = ancho * CGFloat(index)
            marco.frame.origin.y = 0
            marco.frame.size = CGSize(width: ancho, height: view.bounds.width * (0.8))
            contenedorCarouselGrande.addSubview(marco)
            
        }
        
        vistaCarouselGrande.addSubview(contenedorCarouselGrande)
        
        view.addSubview(vistaCarouselGrande)
    }
    
    //oculta el carousel grande
    @objc func imageBigCarouselTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        contenedorCarouselGrande.removeFromSuperview()
        vistaCarouselGrande.removeFromSuperview()
    }
    
    
    //***************************funciones favoritos**********************************
    @IBAction func favoritos(_ sender: Any) {
        
        if let userId = UserDefaults.standard.object(forKey: "userId") as? Int{
            
            let urlRequestFavoritos = "http://18.221.106.92/api/public/user/favorito"
            
            guard let url = URL(string: urlRequestFavoritos) else { return }
            
            var request = URLRequest (url: url)
            request.httpMethod = "POST"
            
            let parameters: [String:Any] = [
                "user_id" : userId,
                "prop_id" : idOfertaSeleccionada
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            print(userId)
            print(idOfertaSeleccionada)
            
            let session  = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
                
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    
                    do {
                        let json = try JSONSerialization.jsonObject (with: data) as! [String:Any?]
                        
                        print(json)
                        
                    } catch {
                        print("El error es: ")
                        print(error)
                    }
                    
                    OperationQueue.main.addOperation({
                        cambioFavoritos = true
                        self.revisarFavoritos()
                    })
                    
                }
                }.resume()
        }
        else{
            navBarStyleCase = 2
            performSegue(withIdentifier: "descriptionToLogin", sender: nil)
        }
        
    }
    
    
    
    func revisarFavoritos(){
        
        if let userId = UserDefaults.standard.object(forKey: "userId") as? Int{
            
            var favoritos: [Int] = []
            
            let urlRequestFavoritos = "http://18.221.106.92/api/public/user/favorito"
            
            guard let url = URL(string: urlRequestFavoritos) else { return }
            
            var request = URLRequest (url: url)
            request.httpMethod = "POST"
            
            let parameters: [String:Any] = [
                "user_id" : userId,
                "consulta" : 1
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            print(userId)
            print(idOfertaSeleccionada)
            
            let session  = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
                
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    
                    do {
                        let json = try JSONSerialization.jsonObject (with: data) as! [String:Any?]
                        
                        print(json)
                        
                        if let jsonFavoritos = json["favoritos"] as? [Int]{
                            favoritos = jsonFavoritos
                        }
                        
                    } catch {
                        print("El error es: ")
                        print(error)
                    }
                    
                    OperationQueue.main.addOperation({
                        for favorito in favoritos{
                            if String(favorito) == idOfertaSeleccionada{
                                self.favoritosBtn.setBackgroundImage(UIImage(named: "favoritoSeleccionado.png") as UIImage?, for: .normal)
                                break
                            }
                            else{
                                self.favoritosBtn.setBackgroundImage(UIImage(named: "favorites.png") as UIImage?, for: .normal)
                            }
                        }
                    })
                    
                }
            }.resume()
        }
        
    }
    
    @IBAction func compartir(_ sender: Any) {
        
        if let userId = UserDefaults.standard.object(forKey: "userId") as? Int{
            
        }
        else{
            navBarStyleCase = 2
            performSegue(withIdentifier: "descriptionToLogin", sender: nil)
        }
        
    }
    

}
