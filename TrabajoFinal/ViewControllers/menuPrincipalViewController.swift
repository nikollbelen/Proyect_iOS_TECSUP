//
//  menuPrincipalViewController.swift
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

class menuPrincipalViewController: UIViewController {
    
    @IBOutlet weak var imagen: UIImageView!
    
    
    @IBOutlet weak var nombreLbl: UILabel!
    
    var usuarios:[Usuario] = []
        
    
    var id_user = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //nombreLbl.text =
        
       
        //imagen.sd_setImage(with: URL(string: usuarios.username), completed: nil)
        
        Database.database().reference().child("usuarios").observe(DataEventType.childAdded,
            with: {(snapshot) in
                print(snapshot)
            let usuario = Usuario()
            usuario.username = (snapshot.value as! NSDictionary) ["username"] as! String
            usuario.imagenURL = (snapshot.value as! NSDictionary) ["imagenURL"] as! String
            usuario.uid = snapshot.key
            print(usuario.username)
            
            var lista:[String] = []
            
            lista.append(usuario.username)
            lista.append(usuario.imagenURL)
            self.nombreLbl.text = lista[0]
            self.imagen.sd_setImage(with: URL(string: usuario.imagenURL), completed: nil)
           
            }
                                                                  
            )
        
      

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func sucursalesTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "sucursalessegue", sender: nil)
    }
    
    
    
    @IBAction func adminTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "usuariosSegue", sender: nil)
    }
    
    
    @IBAction func cerrarSesion(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
