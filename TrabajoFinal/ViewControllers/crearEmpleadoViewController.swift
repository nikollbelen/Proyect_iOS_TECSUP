//
//  crearEmpleadoViewController.swift
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

class crearEmpleadoViewController:  UIViewController, UIImagePickerControllerDelegate, UINavigationBarDelegate, UINavigationControllerDelegate {
    

    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var txtApellido: UITextField!
    
    
    var imagePicker = UIImagePickerController()
    var imagenID = NSUUID().uuidString
    var imagenURL:URL?
    
    var usuarios:[Usuario] = []
    var sucursal = Sucursal()
    var editar:[String] = []
  
    
    
    var username2 = "guido"
    
    @IBAction func crearSssionTapped(_ sender: Any) {
        let imagenesFolder = Storage.storage().reference().child("imagenEmpleado")
        let imagenData = self.imageView.image?.jpegData(compressionQuality: 0.50)
        let cargarImagen = imagenesFolder.child("\(self.imagenID).jpg")
            cargarImagen.putData(imagenData!, metadata: nil)
        { [self](matadata, error) in
            if error != nil {
                print(error)
            }else{
                cargarImagen.downloadURL(completion: { [self](url, error) in
                   
                    let snap = ["Nombre_Empleado" : self.txtNombre.text!,"Apellido_Empleado" : self.txtApellido.text!,"Email_Empleado" : self.txtEmail.text!,"Contraseña_Empleado" : self.txtPassword.text!,"imagenEmpleadoURL": url?.absoluteString,"imagenID": imagenID]
                    
                    Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("sucursales").child(sucursal.id).child("empleados").childByAutoId().setValue(snap)
                    
                   
                    }
                )}
                                         
        }
        
                        
                        
                                    
                        
                }
    func mostrarAlerta(titulo: String, mensaje: String, accion: String) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let btnCANCELOK = UIAlertAction(title: accion, style: .default, handler: nil)
        alerta.addAction(btnCANCELOK)
        present(alerta, animated: true, completion: nil)
            
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        
        print("lo anterior es editar")

        if editar != []{
            print("editar")
            
            
            txtNombre.text = editar[0]
            txtApellido.text = editar[3]
            txtEmail.text = editar[4]
            txtPassword.text = editar[5]
            
            
            imageView.sd_setImage(with: URL(string: editar[2]),completed:nil)
            
        }
        print(sucursal.id)
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func actualizarTapped(_ sender: Any) {
        
        Storage.storage().reference().child("imagenEmpleado").child("\(editar[1]).jpg").delete()
        let imagenesFolder = Storage.storage().reference().child("imagenEmpleado")
        let imagenData = self.imageView.image?.jpegData(compressionQuality: 0.50)
        let cargarImagen = imagenesFolder.child("\(self.imagenID).jpg")
            cargarImagen.putData(imagenData!, metadata: nil)
        { [self](matadata, error) in
            if error != nil {
                print(error)
            }else{
                cargarImagen.downloadURL(completion: { [self](url, error) in
                   
                    let snap = ["Nombre_Empleado" : self.txtNombre.text!,"Apellido_Empleado" : self.txtApellido.text!,"Contraseña_Empleado" : self.txtPassword.text!,"Email_Empleado" : self.txtEmail.text!,"imagenID": imagenID,"imagenURL_producto": url?.absoluteString]
                    
                    Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("sucursales").child(editar[7]).child("empleados").child(editar[6]).updateChildValues(snap)
                    
                   
                    }
                )}
                                         
        }
    }
    
    
    
    @IBAction func regresarTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "regresar", sender: nil)
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion:  nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        //elegirContactoBoton.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
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
