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
    
    var usuarios:[Usuario] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imagentext.layer.cornerRadius = imagentext.bounds.height / 2
        
        Database.database().reference().child("usuarios").observe(DataEventType.childAdded,
            with: {(snapshot) in
                print(snapshot)
            
            let usuario = Usuario()
            usuario.email = (snapshot.value as! NSDictionary) ["username"] as! String
            usuario.imagenURL = (snapshot.value as! NSDictionary) ["imagenURL"] as! String
            usuario.uid = snapshot.key
            self.usuarios.append(usuario)
           
            }
                                                                  
            )
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(usuario:Usuario) {
        /*Database.database().reference().child("usuarios").observe(DataEventType.childAdded,
            with: {(snapshot) in
                print(snapshot)
            
           // let usuario = Usuario()
            usuario.email = (snapshot.value as! NSDictionary) ["username"] as! String
            usuario.imagenURL = (snapshot.value as! NSDictionary) ["imagenURL"] as! URL
            usuario.uid = snapshot.key
            self.usuarios.append(usuario)
           
            }
                                                                  
            )*/
        print(usuario.imagenURL)
        /*ImageService.downloadImage(withURL: usuario.imagenURL) { image in
            self.imagentext.image = image
        }*/
        
        
        apellidotext.text = usuario.email
        imagentext.sd_setImage(with: URL(string: usuario.imagenURL), completed: nil)
        
        
        
    }
    
}
