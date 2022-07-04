//
//  Home2ViewController.swift
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


/*struct CellData {
    let image : UIImage?
    let message: String?
}*/

class Home2ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var listaUsuarios: UITableView!
    
    

    @IBOutlet weak var mensaje: UITextField!
    
    
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
        usuario.apellido = (snapshot.value as! NSDictionary) ["apellido"] as! String
        usuario.username = (snapshot.value as! NSDictionary) ["username"] as! String
        usuario.imagenURL = (snapshot.value as! NSDictionary) ["imagenURL"] as! String
        usuario.gmail = (snapshot.value as! NSDictionary) ["gmail"] as! String
        usuario.uid = snapshot.key
        self.usuarios.append(usuario)
        self.listaUsuarios.reloadData()
        }
                                                              
        )
        
       
        //tableView.backgroundColor = UIColor.blue
        
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        listaUsuarios.register(cellNib, forCellReuseIdentifier: "postCell")
        view.addSubview(listaUsuarios)
        
        var layoutGuide:UILayoutGuide!
        
        if #available(iOS 11.0, *) {
            layoutGuide = view.safeAreaLayoutGuide
        }else{
            layoutGuide = view.layoutMarginsGuide
        }
        
        listaUsuarios.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        listaUsuarios.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        listaUsuarios.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        listaUsuarios.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true

        // Do any additional setup after loading the view.
        
       
        listaUsuarios.reloadData()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usuarios.count
    }
    /*
    @IBAction func enviarMensajeTapped(_ sender: Any) {
        //let usuario = usuarios[indexPath.row]
        /*
        let snap = ["from" : Auth.auth().currentUser?.email, "descripcion" : descrip, "imagenURL" : imagenURL,
                   "imagenID" : imagenID]
        
        //let snap = ["from" : Auth.auth().currentUser?.email]
        
            Database.database().reference().child("usuarios").child(usuario.uid)
            .child("snaps").childByAutoId().setValue(snap)
        navigationController?.popViewController(animated: true)*/
        
        let mens = ["casilla" : self.mensaje.text!]
        Database.database().reference().child("mensajes")
            .childByAutoId().setValue(mens)
           // .child(user!.user.uid).setValue(mens)
        
        
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        
        cell.set(usuario: usuarios[indexPath.row])
    
        
         return cell
        
       
        
        //cell.imageView?.sd_setImage(with: URL(imageURL), completed: nil)
       // cell.imageView?.image(with: URL(string: usuario.imageURL), completed: nil)
        
        
        //cell.imageView?.image = UIImage.init(contentsOfFile: usuario.imagenURL)
        
        
        //cell.imageView?.image = usuario.imagenURL[indexPath.row]
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hola")
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
