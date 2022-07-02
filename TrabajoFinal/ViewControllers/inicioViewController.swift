//
//  inicioViewController.swift
//  TrabajoFinal
//
//  Created by Mac 14 on 1/07/22.
//

import UIKit

class inicioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ingresarTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "ingresar", sender: nil)
    }
    
    
    @IBAction func registrarTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "registrar", sender: nil)
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
