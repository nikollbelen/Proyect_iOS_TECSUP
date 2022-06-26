//
//  homeViewController.swift
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

class homeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView!
    var usuarios:[Usuario] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        tableView = UITableView(frame: view.bounds,style: .plain)
        //tableView.backgroundColor = UIColor.blue
        
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "postCell")
        view.addSubview(tableView)
        
        var layoutGuide:UILayoutGuide!
        
        if #available(iOS 11.0, *) {
            layoutGuide = view.safeAreaLayoutGuide
        }else{
            layoutGuide = view.layoutMarginsGuide
        }
        
        tableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        
        //let usuario = usuarios[indexPath.row]
        //cell.imageView?.image = sd_setImage(with: URL(string: usuario.imagenURL), completed: nil)
        //cell.textLabel?.text = usuario.email
        //cel correcto esta abajo
        //cell.set(usuario: usuarios[indexPath.row])
        /*
        cell.imagen.sd_setImage(with: URL(string: usuario.imagenURL))
        cell.imagenView
        */
        return cell
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
