//
//  crearSesionViewController.swift
//  TrabajoFinal
//
//  Created by Mac 11 on 21/06/22.
//
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore
import FirebaseStorage
import AVFoundation

class crearSesionViewController:  UIViewController, UIImagePickerControllerDelegate, UINavigationBarDelegate, UINavigationControllerDelegate {
    

    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var txtApellido: UITextField!
    
    
    var imagePicker = UIImagePickerController()
    var imagenID = NSUUID().uuidString
    var imagenURL:URL?
    
    var usuarios:[Usuario] = []
  
    
    
    var username2 = "guido"
    //crear sesion para ingresar como administrador
    @IBAction func crearSssionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (user, error) in
        print("Intentando Inicar Sesion")
            
            if error != nil{
                print("Se presento el siguient error: \(error)")
                Auth.auth().createUser(withEmail: self.txtEmail.text!, password: self.txtPassword.text!, completion:  { [self](user, error) in
                    print("Intentando crear un usuario")
                    if error != nil{
                        print("Se presento el siguiente error al crear el usuario: \(error)")
                    }else{
                        print("El usuario fue creado exitosamente")
                        
                        //subir imagen a Firebase
                        let imagenesFolder = Storage.storage().reference().child("imagenes")
                        let imagenData = self.imageView.image?.jpegData(compressionQuality: 0.50)
                        let cargarImagen = imagenesFolder.child("\(self.imagenID).jpg")
                            cargarImagen.putData(imagenData!, metadata: nil)
                        { [self](matadata, error) in
                            if error != nil {
                                self.mostrarAlerta(titulo: "Error", mensaje: "Se produjo un error al subir la imagen verifique que tiene accesi a internet", accion: "Aceptar")
                                //self.elegirContactoBoton.isEnabled = true
                                print("Ocurrio un error al subir imagen: \(error) ")
                            }else{
                                cargarImagen.downloadURL(completion: { [self](url, error) in
                                    print(url?.absoluteString)
                                    let snap = ["username" : self.txtNombre.text!,"apellido" : self.txtApellido.text!,"gmail" : self.txtEmail.text!,"imagenURL": url?.absoluteString,"imagenID": imagenID]
                                    Database.database().reference().child("usuarios")
                                        .child(user!.user.uid).setValue(snap)
                                    
                                    guard let enlaceURL = url else{
                                        self.mostrarAlerta(titulo: "Error", mensaje: "Se obtubo un error al obtener informacion de la imagen", accion: "Cancelar")
                                       
                                        //self.elegirContactoBoton.isEnabled = true
                                        print("Ocurrio un error al obtener la informacion de imagen \(error)")
                                        return
                                    }
                                    
                                })
                                                        
                            }
                        }
                        //Alerta
                       
                        let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario: \(self.txtEmail.text!) se creo correctamente.", preferredStyle: .alert)
                        
                        let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: { (UIAlertAction) in
                            self.performSegue(withIdentifier: "regresar", sender: nil)
                            
                        })
                        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (UIAlertAction) -> Void in })
                        alerta.addAction(btnOK)
                        alerta.addAction(cancel)
                        self.present(alerta, animated: true, completion: nil)
                        
                    }
                })
            }else{
                //registro correcto
                let alerta = UIAlertController(title: "Alerta", message: "Usuario: \(self.txtEmail.text!) Ya esta registrado.", preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: "Aceptar", style: .destructive, handler: { (UIAlertAction) -> Void in })
               
                alerta.addAction(cancel)
                self.present(alerta, animated: true, completion: nil)
                
            }
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

        // Do any additional setup after loading the view.
    }
    
    
    //viaje por el outlet
    @IBAction func regresarTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "regresar", sender: nil)
    }
    
    
    //funcion de carga de la imagen
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion:  nil)
    }
    
    //funcion para cargar la imagen de la galeria
    
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
