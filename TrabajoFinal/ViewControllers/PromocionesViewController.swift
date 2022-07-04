//
//  PromocionesViewController.swift
//  TrabajoFinal
//
//  Created by Mac 14 on 4/07/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore
import FirebaseStorage
import AVFoundation

class PromocionesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationBarDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
    

    @IBOutlet weak var tablaPromociones: UITableView!
    var promociones:[Promocion] = []
        override func viewDidLoad() {
            super.viewDidLoad()
            tablaPromociones.dataSource = self
            tablaPromociones.delegate = self

            // Do any additional setup after loading the view.
            Database.database().reference().child("promociones").observe(DataEventType.childAdded, with: { (snapshot) in
                // modelo
                let promocion = Promocion()
                promocion.audioURL = (snapshot.value as! NSDictionary)["audioURL"] as! String
                promocion.nombreAudio = (snapshot.value as! NSDictionary)["nombreAudio"] as! String
                promocion.categoria = (snapshot.value as! NSDictionary)["categoria"] as! String
                promocion.audioID = (snapshot.value as! NSDictionary)["audioID"] as! String
                promocion.id = snapshot.key
                self.promociones.append(promocion)
                self.tablaPromociones.reloadData()
            })
        }

    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return promociones.count
        }
     
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let promocion = promociones[indexPath.row]
            cell.textLabel?.text = promocion.nombreAudio
            cell.detailTextLabel?.text = promocion.categoria
            return cell
        }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete{
                var elemento = promociones[indexPath.row]
                Database.database().reference().child("promociones").child(elemento.id).removeValue()
                
                Storage.storage().reference().child("imagenEmpleado").child("\(elemento.audioID).m4a").delete()
                
                var posicion = indexPath.row
                promociones.remove(at: posicion)
                tablaPromociones.reloadData()
                
            }
        }
        
    

}
