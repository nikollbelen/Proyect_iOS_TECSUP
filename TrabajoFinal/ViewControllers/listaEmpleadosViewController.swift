//
//  listaEmpleadosViewController.swift
//  TrabajoFinal
//
//  Created by Mac 14 on 3/07/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage
import AVFoundation
import SDWebImage
class listaEmpleadosViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Empleados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        //let cell = UITableViewCell()
        let empleado = Empleados[indexPath.row]
        cell.textLabel?.text = empleado.Nombre_Empleado
        cell.detailTextLabel?.text = empleado.Apellido_Empleado
        cell.imageView?.sd_setImage(with: URL(string: empleado.imagenEmpleadoURL))
        return cell
        
    }
    
    
    var sucursal = Sucursal()
    var Empleados:[Empleados] = []
    var editar: [String] = []
    
    @IBOutlet weak var listaEmpleados: UITableView!
    
    private let floatingButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        
        //raidoo del buttin
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemPink
        
        let image = UIImage(systemName: "plus",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        listaEmpleados.delegate=self
        listaEmpleados.dataSource=self
        listaEmpleados.isEditing = true
        listaEmpleados.allowsSelectionDuringEditing = true
        
        
        Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("sucursales").child(sucursal.id).child("empleados").observe(DataEventType.childAdded, with: { (snapshot) in
            let prod = TrabajoFinal.Empleados()
            prod.Nombre_Empleado = (snapshot.value! as! NSDictionary)["Nombre_Empleado"] as! String
            prod.Apellido_Empleado = (snapshot.value! as! NSDictionary)["Apellido_Empleado"] as! String
            prod.Contraseña_Empleado = (snapshot.value! as! NSDictionary)["Contraseña_Empleado"] as! String
            
            prod.Email_Empleado = (snapshot.value! as! NSDictionary)["Email_Empleado"] as! String
            prod.imagenID = (snapshot.value! as! NSDictionary)["imagenID"] as! String
            prod.imagenEmpleadoURL = (snapshot.value! as! NSDictionary)["imagenEmpleadoURL"] as! String
            prod.id = snapshot.key
            self.Empleados.append(prod)
            self.listaEmpleados.reloadData()
        })

        // Do any additional setup after loading the view.
    }
    
    @objc private func didTapButton() {
        self.performSegue(withIdentifier: "crearempleado", sender: sucursal)
        print("crear productos")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(
            x: view.frame.size.width - 70,
            y: view.frame.size.width - 100,
            width: 60,
            height: 60
        )
    }
    
    
    
    
    @IBAction func crearEmpleados(_ sender: Any) {
        self.performSegue(withIdentifier: "crearempleado", sender: sucursal)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "crearempleado" {
            let siguienteVC = segue.destination as! crearEmpleadoViewController
            siguienteVC.sucursal = sender as! Sucursal
        }else{
            let siguienteVC = segue.destination as! crearEmpleadoViewController
            siguienteVC.editar = editar
            
        }
        
}
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            var elemento = Empleados[indexPath.row]
            Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("sucursales").child(sucursal.id).child("empleados").child(elemento.id).removeValue()
            
            Storage.storage().reference().child("imagenEmpleado").child("\(elemento.imagenID).jpg").delete()
            print(elemento.imagenID)
            var posicion = indexPath.row
            Empleados.remove(at: posicion)
            listaEmpleados.reloadData()
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let empleado = Empleados[indexPath.row]
        print("ghaaaaaaaaaaaaaaaaaaaaaa")
        print(empleado)
        editar.append(empleado.Nombre_Empleado)
        editar.append(empleado.imagenID)
        editar.append(empleado.imagenEmpleadoURL)
        editar.append(empleado.Apellido_Empleado)
        editar.append(empleado.Email_Empleado)
        editar.append(empleado.Contraseña_Empleado)
        editar.append(empleado.id)
        editar.append(sucursal.id)
        print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
        print(editar)
        performSegue(withIdentifier: "segueEditar", sender: editar)
        
    }
}
