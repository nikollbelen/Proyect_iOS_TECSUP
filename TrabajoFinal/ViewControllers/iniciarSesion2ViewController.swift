//
//  ViewController.swift
//  TrabajoFinal
//
//  Created by Mac 14 on 16/06/22.
//
import UIKit

import FirebaseAuth
import FirebaseDatabase
import FacebookCore
import FacebookLogin
import GoogleSignIn
import FirebaseAnalytics

class iniciarSesion2ViewController: UIViewController, GIDSignInDelegate {
    
    
    
    

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var googleButton: UIButton!
    
    var radius = 22
    
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
                print("Inicio de sesion crear")
                
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
        
            }}}
    
    @IBAction func registrarseTepped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "crearusuariosegue", sender: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        emailTextField.layer.cornerRadius = CGFloat(radius)
        passwordTextField.layer.cornerRadius = CGFloat(radius)
        googleButton.layer.cornerRadius = CGFloat(radius)
       
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
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil && user.authentication != nil {
            let credential = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
            Auth.auth().signIn(with: credential) { (result, error) in
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                
            }
        }
    }
    

    @IBAction func googleButtonAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    
    
}



