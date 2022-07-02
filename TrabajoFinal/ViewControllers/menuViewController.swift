//
//  menuViewController.swift
//  TrabajoFinal
//
//  Created by Mac 14 on 1/07/22.
//

import UIKit

class menuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func empleadosTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "empleadossegue", sender: nil)
        
    }
    
    @IBAction func productosTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "productossegue", sender: nil)
    }
    
    
    
    @IBAction func ubicacionTapped(_ sender: Any) {
    }
    
    
    @IBAction func ofertasTapped(_ sender: Any) {
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
