//
//  sucursalViewController.swift
//  TrabajoFinal
//
//  Created by Mac 14 on 1/07/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

class sucursalViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var listaSucursales: UITableView!
    var sucursales:[Sucursal] = []
    var nombre = ""
    var id_user = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaSucursales.delegate=self
        listaSucursales.dataSource=self
        /*
        Database.database().reference().child("usuarios").child(id_user).child("sucursales").observe(DataEventType.childAdded, with: {(snap)  in
            let sucu = Sucursal()
            //sucu.sucursal = (snap.value! as! NSDictionary)["sucursal"] as! String
            self.sucursales.append(sucu)
            self.listaSucursales.reloadData()
        })*/
        
        Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("sucursales").observe(DataEventType.childAdded, with: { (snapshot) in
            let sucu = Sucursal()
            sucu.sucursal = (snapshot.value! as! NSDictionary)["sucursal"] as! String
            sucu.id = snapshot.key
            self.sucursales.append(sucu)
            self.listaSucursales.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sucursales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let sucursal1 = sucursales[indexPath.row]
        cell.textLabel?.text = sucursal1.sucursal
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sucursal = sucursales[indexPath.row]
        performSegue(withIdentifier: "menusucursal", sender: sucursal)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menusucursal" {
            let siguienteVC = segue.destination as! menuViewController
            siguienteVC.sucursal = sender as! Sucursal
        }
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

