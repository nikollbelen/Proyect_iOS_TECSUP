//
//  empledoViewController.swift
//  TrabajoFinal
//
//  Created by Mac 14 on 2/07/22.
//


import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage
import AVFoundation
import SDWebImage

class empledoViewController: UIViewController {
    var sucursal = Sucursal()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //self.performSegue(withIdentifier: "AgregarProducto", sender: sucursal)
    

    @IBAction func crearEmpleados(_ sender: Any) {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "crearEmpleado" {
            let siguienteVC = segue.destination as! crearEmpleadoViewController
            siguienteVC.sucursal = sender as! Sucursal
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */}}

