//
//  crearProductoViewController.swift
//  TrabajoFinal
//
//  Created by Mac 14 on 2/07/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore
import FirebaseStorage
import AVFoundation
import SDWebImage

class crearProductoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationBarDelegate, UINavigationControllerDelegate{
    
    var sucursal = Sucursal()
    var producto = Productos()
    var editar:[String] = []
    

    
    @IBOutlet weak var imagenView: UIImageView!
    
    
    @IBOutlet weak var nombre: UITextField!
    
    @IBOutlet weak var precio: UITextField!
    
    @IBOutlet weak var cantidad: UITextField!
    
    var imagePicker = UIImagePickerController()
    var imagenID = NSUUID().uuidString
    var imagenURL:URL?
    
    @IBAction func CrearProducto(_ sender: Any) {
        let imagenesFolder = Storage.storage().reference().child("imagenProducto")
        let imagenData = self.imagenView.image?.jpegData(compressionQuality: 0.50)
        let cargarImagen = imagenesFolder.child("\(self.imagenID).jpg")
            cargarImagen.putData(imagenData!, metadata: nil)
        { [self](matadata, error) in
            if error != nil {
                print(error)
            }else{
                cargarImagen.downloadURL(completion: { [self](url, error) in
                   
                    let snap = ["Nombre_Producto" : self.nombre.text!,"precio" : self.precio.text!,"cantidad" : self.cantidad.text!,"imagenURL_producto": url?.absoluteString,"imagenID": imagenID]
                    
                    Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("sucursales").child(sucursal.id).child("productos").childByAutoId().setValue(snap)
                    
                   
                    }
                )}
                                         
        }
    }
    
    @IBAction func imagenes(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion:  nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imagenView.image = image
        imagenView.backgroundColor = UIColor.clear
        //elegirContactoBoton.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagenView.layer.cornerRadius = imagenView.bounds.height / 2
        
        
        print(editar)
        if editar != []{
            print("editar")
            
            
            nombre.text = editar[0]
            precio.text = editar[3]
            cantidad.text = editar[4]
            
            
            imagenView.sd_setImage(with: URL(string: editar[2]),completed:nil)
            
        }
            
            
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func Actualizar(_ sender: Any) {
        
        
        
        
        Storage.storage().reference().child("imagenProducto").child("\(editar[1]).jpg").delete()
        let imagenesFolder = Storage.storage().reference().child("imagenProducto")
        let imagenData = self.imagenView.image?.jpegData(compressionQuality: 0.50)
        let cargarImagen = imagenesFolder.child("\(self.imagenID).jpg")
            cargarImagen.putData(imagenData!, metadata: nil)
        { [self](matadata, error) in
            if error != nil {
                print(error)
            }else{
                cargarImagen.downloadURL(completion: { [self](url, error) in
                   
                    let snap = ["Nombre_Producto" : self.nombre.text!,"precio" : "55","cantidad" : self.cantidad.text!,"imagenID": imagenID,"imagenURL_producto": url?.absoluteString]
                    
                    Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("sucursales").child(editar[6]).child("productos").child(editar[5]).updateChildValues(snap)
                    
                   
                    }
                )}
                                         
        }
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
