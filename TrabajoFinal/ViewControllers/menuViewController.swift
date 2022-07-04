//
//  menuViewController.swift
//  TrabajoFinal
//
//  Created by Mac 14 on 1/07/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class menuViewController: UIViewController {
    var id_user = ""
    
    var sucursal = Sucursal()
    
    @IBOutlet weak var nombreScl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreScl.text = sucursal.sucursal
        print(id_user)

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("sucursales").child(sucursal.id)//.removeValue()
    
       
            print("se elimino correctamente")
        
    }
    
    
    
    @IBAction func empleadosTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "empleadosegue", sender: sucursal)
        
    }
    
    @IBAction func productosTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "productossegue", sender: nil)
    }
    
    
    
    @IBAction func ubicacionTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "ProductosSegue", sender: sucursal)
    }
    
    
    @IBAction func ofertasTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "promocionSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductosSegue" {
            
            let siguienteVC = segue.destination as! ViewControllerProductos
            siguienteVC.sucursal = sender as! Sucursal
        }
        else if (segue.identifier == "promocionSegue"){
            print("asdasdasd")
        }
        else{
            let siguienteVC = segue.destination as! listaEmpleadosViewController
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
