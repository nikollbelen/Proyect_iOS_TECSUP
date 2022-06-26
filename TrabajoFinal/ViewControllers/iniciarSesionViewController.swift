//
//  iniciarSesionViewController.swift
//  TrabajoFinal
//
//  Created by Mac 11 on 21/06/22.
//

import UIKit

import FirebaseAuth
import FirebaseDatabase


class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var googlebtn: UIButton!
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print("Intentando Inicar Sesion")
            if error != nil{
                
                        print("El esta siendo creado")
                        /*Database.database().reference().child("usuarios")
                            .child(user!.user.uid).child("email").setValue(user!.user.email)*/
                        
            
                        
                        let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario: \(self.emailTextField.text!) No se reconocio el usuario debera de registrarse", preferredStyle: .alert)
                        
                        let btnOK = UIAlertAction(title: "Crear", style: .default, handler: { (UIAlertAction) in
                            self.performSegue(withIdentifier: "crearusuariosegue", sender: nil)
                        })
                        /*
                        let btnCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: { (UIAlertAction) in
                            self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                        })*/
                        
                        // Cancel button
                          let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (UIAlertAction) -> Void in })

                        alerta.addAction(btnOK)
                        alerta.addAction(cancel)
                        self.present(alerta, animated: true, completion: nil)
                        
                    
            }else{
                print("Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
        
            }}}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /*Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
     print("Intentando Inicar Sesion")
         if error != nil{
             print("Se presento el siguient error: \(error)")
             Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion:  {(user, error) in
                 print("Intentando crear un usuario")
                 if error != nil{
                     print("Se presento el siguiente error al crear el usuario: \(error)")
                 }else{
                     print("El usuario fue creado exitosamente")
                     
                     Database.database().reference().child("usuarios")
                         .child(user!.user.uid).child("email").setValue(user!.user.email)
                     
                     let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario: \(self.emailTextField.text!) se creo correctamente.", preferredStyle: .alert)
                     
                     let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: { (UIAlertAction) in
                         self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                     })
                     alerta.addAction(btnOK)
                     self.present(alerta, animated: true, completion: nil)
                     
                 }
             })
         }else{
             print("Inicio de sesion exitoso")
             self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
         }
     }*/


}

