//
//  mapaViewController.swift
//  TrabajoFinal
//
//  Created by Mac 14 on 4/07/22.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore
import FirebaseStorage
import AVFoundation
class mapaViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var ubicacion = CLLocationManager()
    var selectedAnnotation: MKPointAnnotation?
    var anotacion  = MKPointAnnotation()
    var ubisave:[Double] = []
    var latitud: Double = 0
    var longitud: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ubicacion.delegate = self
                //autorizamos que la aplicaciones pueda acceder a la ubicacion
                if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
                    mapa.showsUserLocation = true
                    ubicacion.startUpdatingLocation()
                    
                }else{
                    ubicacion.requestWhenInUseAuthorization()
                }
                
                mapa.showsUserLocation
                
                mapa.delegate = self
    }
    
    @objc func handleTap(_ gestureReconizer:UILongPressGestureRecognizer) {
            //con esto eliminaremos la anotacion anterior
            mapa.removeAnnotation(anotacion as! MKAnnotation)
            //agreagaremos la nueva annotacion
            let location = gestureReconizer.location(in: mapa)
            let coordinate = mapa.convert(location, toCoordinateFrom: mapa)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "latitud:" + String(format: "%0.02f", annotation.coordinate.latitude)+"& longitud:" + String(format: "%0.02F", annotation.coordinate.longitude)
            //con esto le daremos una anotacion sobre la latitud y longitud
            mapa.addAnnotation(annotation)
        
        latitud = coordinate.latitude
        longitud = coordinate.longitude
            anotacion = annotation
            
        }
        
       
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            
            
            let longPressRecn = UILongPressGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            longPressRecn.minimumPressDuration = 0.5
            
            //esto reconocera que precionamos por 0.5 segundos la pantallas
            mapa.addGestureRecognizer(longPressRecn)
            
            mapa.mapType = MKMapType.standard
            //esto es la locacion en la que se encuentra el usuario
            let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(Float(ubicacion.location!.coordinate.latitude)), longitude: CLLocationDegrees(Float(ubicacion.location!.coordinate.longitude)))
            
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let regin = MKCoordinateRegion(center: location, span: span)
            
            mapa.setRegion(regin, animated: true)
            
            // con esto agregaremos una anotacion a nuestra ubicacion
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "yo"
            annotation.subtitle = "Estas aqui"
            
            mapa.addAnnotation(annotation)
            
            
            
            print("Ubicacion actualizada")
            
        }
        
        
    
    @IBAction func guardarubicacion(_ sender: Any) {
        
        ubisave.append(Double(latitud))
        ubisave.append(Double(longitud))
        self.performSegue(withIdentifier: "segueLat", sender: ubisave)
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
