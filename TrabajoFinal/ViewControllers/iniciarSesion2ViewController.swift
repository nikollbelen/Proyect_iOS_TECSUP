//
//  ViewController.swift
//  TrabajoFinal
//
//  Created by Mac 14 on 16/06/22.
//
import UIKit

import FirebaseAuth
import FirebaseDatabase

import GoogleSignIn


class iniciarSesion2ViewController: UIViewController, GIDSignInDelegate {
    
    var idUsuario = ""
    
    

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var googleButton: UIButton!
    
    var radius = 22
    //iniciar sesion con el servicio de correo
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print("Intentando Inicar Sesion")
            if error != nil{
                        print("El esta siendo creado")
                        let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario: \(self.emailTextField.text!) No se reconocio el usuario debera de registrarse", preferredStyle: .alert)
                        let btnOK = UIAlertAction(title: "Crear", style: .default, handler: { (UIAlertAction) in
                            self.performSegue(withIdentifier: "crearusuariosegue", sender: nil)
                        })
                          let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (UIAlertAction) -> Void in })
                        alerta.addAction(btnOK)
                        alerta.addAction(cancel)
                        self.present(alerta, animated: true, completion: nil)
            }else{
                print("Inicio de sesion crear")
                self.idUsuario = user!.user.uid
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }
    
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
    
    
    //Iniciar sesion con el servicio de Google
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil && user.authentication != nil {
            let credential = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
            Auth.auth().signIn(with: credential) { (result, error) in
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: self.idUsuario)
                
            }
        }
    }
    
    //enviar el id del usuario al menu principal para almacenarlo en una variable
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino = segue.destination as! UINavigationController
        let tarjetController = destino.topViewController
        let siguienteVC = tarjetController as? menuPrincipalViewController
        siguienteVC?.id_user = idUsuario
        print(idUsuario)
    }
    
    
//google button con inicio y cierre de sesion
    @IBAction func googleButtonAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    
    
}



