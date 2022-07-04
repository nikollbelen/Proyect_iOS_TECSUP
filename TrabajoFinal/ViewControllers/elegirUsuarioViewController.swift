//
//  elegirUsuarioViewController.swift
//  TrabajoFinal
//
//  Created by Mac 11 on 21/06/22.
//


import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage
import AVFoundation
import SDWebImage



class elegirUsuarioViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var listaUsuarios: UITableView!
    
    
    @IBOutlet weak var imagen: UIImageView!
    
    
    //var data = [CellData]()

    
    var usuarios:[Usuario] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let usuario = Usuario()
        //data = [CellData.init(image: "guido", message: "portal")]
        listaUsuarios.delegate=self
        listaUsuarios.dataSource=self
     
        //extraer de la base de datos los datos del nodo usuarios
    Database.database().reference().child("usuarios").observe(DataEventType.childAdded,
        with: {(snapshot) in
            print(snapshot)
        
        let usuario = Usuario()
        usuario.email = (snapshot.value as! NSDictionary) ["username"] as! String
        usuario.imagenURL = (snapshot.value as! NSDictionary) ["imagenURL"] as! String
        usuario.uid = snapshot.key
        self.usuarios.append(usuario)
        self.listaUsuarios.reloadData()
        }
                                                              
        )

        // Do any additional setup after loading the view.
    }
    //numero de usuarios que se mostrara en el tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return usuarios.count
    }
    
    //datos que se coloca en el tableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let cell = UITableViewCell()
        let usuario = usuarios[indexPath.row]
        cell.textLabel?.text = usuario.email
               
        cell.imageView?.sd_setImage(with: URL(string: usuario.imagenURL))
        
        
         return cell
        

    }
    
   

}
