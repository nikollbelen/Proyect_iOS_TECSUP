//
//  PostTableViewCell.swift
//  TrabajoFinal
//
//  Created by Mac 11 on 24/06/22.
//

import UIKit

import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage
import AVFoundation
import SDWebImage

class PostTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imagentext: UIImageView!
    
    @IBOutlet weak var usuariotext: UILabel!
    
    @IBOutlet weak var apellidotext: UILabel!
    
    @IBOutlet weak var emailtxt: UILabel!
    
    
    var usuarios:[Usuario] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imagentext.layer.cornerRadius = imagentext.bounds.height / 2
        
        //Desempaquetando los datos de usuarios
        Database.database().reference().child("usuarios").observe(DataEventType.childAdded,
            with: {(snapshot) in
                print(snapshot)
            
            let usuario = Usuario()
            usuario.username = (snapshot.value as! NSDictionary) ["username"] as! String
            usuario.imagenURL = (snapshot.value as! NSDictionary) ["imagenURL"] as! String
            usuario.gmail = (snapshot.value as! NSDictionary) ["gmail"] as! String
            usuario.apellido = (snapshot.value as! NSDictionary) ["apellido"] as! String
            usuario.uid = snapshot.key
            self.usuarios.append(usuario)
           
            }
                                                                  
            )
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    //modelo o estructura que se genear para el TableView
    func set(usuario:Usuario) {
        
        print(usuario.imagenURL)
        usuariotext.text = usuario.username
        apellidotext.text = usuario.apellido
        emailtxt.text = usuario.gmail
        imagentext.sd_setImage(with: URL(string: usuario.imagenURL), completed: nil)
        
        
        
    }
    
}
