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


/*struct CellData {
    let image : UIImage?
    let message: String?
}*/

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usuarios.count
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let cell = UITableViewCell()
        let usuario = usuarios[indexPath.row]
        cell.textLabel?.text = usuario.email
               
        cell.imageView?.sd_setImage(with: URL(string: usuario.imagenURL))
        
        
    
        /*cell.imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://music.bronynet.com/retrieve_artwork.php?artist_id=%@", cellValue.artistID]] placeholderImage:[UIImage imageNamed:@"artistPlaceholder.png"]*/
        //imagen url
        //cell.textLabel?.text = usuario.imagenURL
        /*
        let imagennombres: String = usuario.imagenURL
        cell.imageView?.image = UIImage(named: imagennombres)
        cell.imageView.sd_setImage(with: URL(string:get[indexPath.row].imagenURL), placeholderImage: UIImage(named: "placeholder.png"))
        //solo imagen
        let rango: Int = usuarios.count
        
        
        
        for i in 1...rango {
            imagen.sd_setImage(with: URL(string: usuario.imagenURL))
            print("Val \(i)")
        }*/
        /*
        let profileImageUrl = usuario.imagenURL
        
          if profileImageUrl == usuario.imagenURL {
              let url = URL(string: profileImageUrl)
              URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
                  if error != nil {
                      print(error)
                      return
                  }
                  
                  DispatchQueue.main.async {
                      cell.imageView?.image = UIImage(data: data!)
                  }
              }).resume()
          }*/
        
         return cell
        
       
        
        //cell.imageView?.sd_setImage(with: URL(imageURL), completed: nil)
       // cell.imageView?.image(with: URL(string: usuario.imageURL), completed: nil)
        
        
        //cell.imageView?.image = UIImage.init(contentsOfFile: usuario.imagenURL)
        
        
        //cell.imageView?.image = usuario.imagenURL[indexPath.row]
        
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
