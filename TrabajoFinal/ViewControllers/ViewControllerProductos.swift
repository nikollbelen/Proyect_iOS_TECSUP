//
//  ViewControllerProductos.swift
//  TrabajoFinal
//
//  Created by Mac 14 on 1/07/22.
//


import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage
import AVFoundation
import SDWebImage

class ViewControllerProductos: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Productos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        //let cell = UITableViewCell()
        let producto = Productos[indexPath.row]
        cell.textLabel?.text = producto.Nombre_Producto
        cell.detailTextLabel?.text = producto.cantidad
        cell.imageView?.sd_setImage(with: URL(string: producto.imagenURL_producto))
        return cell
    }
    
    var sucursal = Sucursal()
    var Productos:[Productos] = []
    
    var editar: [String] = []
    
    
    //var editar = [self.Productos] as [Any]
    @IBOutlet weak var listaProductos: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(sucursal.id)
        listaProductos.delegate=self
        listaProductos.dataSource=self
        listaProductos.isEditing = true
        listaProductos.allowsSelectionDuringEditing = true
        
        
        Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("sucursales").child(sucursal.id).child("productos").observe(DataEventType.childAdded, with: { (snapshot) in
            let prod = TrabajoFinal.Productos()
            prod.Nombre_Producto = (snapshot.value! as! NSDictionary)["Nombre_Producto"] as! String
            prod.cantidad = (snapshot.value! as! NSDictionary)["cantidad"] as! String
            prod.precio = (snapshot.value! as! NSDictionary)["precio"] as! String
            prod.imagenID = (snapshot.value! as! NSDictionary)["imagenID"] as! String
            prod.imagenURL_producto = (snapshot.value! as! NSDictionary)["imagenURL_producto"] as! String
            
            
            
            
            prod.id = snapshot.key
            self.Productos.append(prod)
            self.listaProductos.reloadData()
        })
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func agregarprosucto(_ sender: Any) {
        self.performSegue(withIdentifier: "AgregarProducto", sender: sucursal)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AgregarProducto" {
            let siguienteVC = segue.destination as! crearProductoViewController
            siguienteVC.sucursal = sender as! Sucursal
        }else{
            let siguienteVC = segue.destination as! crearProductoViewController
            siguienteVC.editar = editar
            
        }
        
    }
    
    //Funcion para eliminar datos y su respectiva imagen del usuario
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            var elemento = Productos[indexPath.row]
            Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("sucursales").child(sucursal.id).child("productos").child(elemento.id).removeValue()
            
            Storage.storage().reference().child("imagenProducto").child("\(elemento.imagenID).jpg").delete()
            print(elemento.imagenID)
            var posicion = indexPath.row
            Productos.remove(at: posicion)
            listaProductos.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let producto = Productos[indexPath.row]
       
        print(producto)
        editar.append(producto.Nombre_Producto)
        editar.append(producto.imagenID)
        editar.append(producto.imagenURL_producto)
        editar.append(producto.precio)
        editar.append(producto.cantidad)
        editar.append(producto.id)
        editar.append(sucursal.id)
       
        print(editar)
        performSegue(withIdentifier: "segueEditar", sender: editar)
        
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
