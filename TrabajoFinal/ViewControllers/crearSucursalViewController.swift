//
//  crearSucursalViewController.swift
//  TrabajoFinal
//
//  Created by Mac 14 on 1/07/22.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore

class crearSucursalViewController: UIViewController {
    
    @IBOutlet weak var Nombretxt: UITextField!
    
    var id_user = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func crearTapped(_ sender: Any) {
        let sucursal = ["sucursal" : self.Nombretxt.text!]
        
                
        Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("sucursales").childByAutoId().setValue(sucursal)
        
        
        
        let alerta = UIAlertController(title: "Creacion de Sucursal", message: "Sucursal: \(self.Nombretxt.text!) se creo correctamente.", preferredStyle: .alert)
        
        let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: { (UIAlertAction) in
           
            
        })
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (UIAlertAction) -> Void in })
        alerta.addAction(btnOK)
        alerta.addAction(cancel)
        self.present(alerta, animated: true, completion: nil)
        
        
        
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
