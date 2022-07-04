//
//  AgregarPromocionViewController.swift
//  TrabajoFinal
//
//  Created by Mac 14 on 4/07/22.
//

import UIKit
import AVFAudio
import AVFoundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseCoreDiagnostics

class AgregarPromocionViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var botonGrabar: UIButton!
    @IBOutlet weak var duracionOutlet: UILabel!
   
    @IBOutlet weak var agregarPromocion: UIButton!
    @IBOutlet weak var nombrePromocionTextField: UITextField!
    @IBOutlet weak var categoriasPickerView: UIPickerView!
    @IBOutlet weak var botonPlay: UIButton!
    
    
    
    var promociones:[Promocion] = []

        var audioID = NSUUID().uuidString

        var grabarAudio:AVAudioRecorder?
        var reproducirAudio:AVAudioPlayer?
        var audioURL:URL?

        var timer: Timer?
        var audioUrl = ""

        var tiempo:Timer = Timer()

        let categoria = ["Comidas","Electrodomesticos","Ropa","Comida", "Bebidas" ]
        var categoriaSeleccionada:String = ""

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return categoria.count
        }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            categoriaSeleccionada = categoria[row]
            print(categoriaSeleccionada)
        }

        func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
            let attrb = NSAttributedString(string: categoria[row])
            return attrb
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            categoriasPickerView.delegate = self
            categoriasPickerView.dataSource = self
     
            botonGrabar.layer.cornerRadius = botonGrabar.frame.width / 2
            botonGrabar.layer.masksToBounds = true

            botonPlay.layer.cornerRadius = botonPlay.frame.width / 2
            botonPlay.layer.masksToBounds = true
            configurarGrabacion()
            botonPlay.isEnabled = false
        }
    
    
    
    @IBAction func grabarTapped(_ sender: Any) {
        if grabarAudio!.isRecording {
                    grabarAudio?.stop()
                    botonGrabar.setTitle("GRABAR", for: .normal)
                    let image = UIImage(named: "google.png")
                    botonGrabar.setImage(image, for: .normal)
                    botonPlay.isEnabled = true
                    agregarPromocion.isEnabled = true
                    tiempo.invalidate()
                } else {
                    grabarAudio?.record()
                    botonGrabar.setTitle("DETENER", for: .normal)
                    tiempo = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(tiempoTotal), userInfo: nil, repeats: true)
                    agregarPromocion.isEnabled = false
                }
    }
    

    @IBAction func botonPlayTapped(_ sender: Any) {
        do {
                    try reproducirAudio = AVAudioPlayer(contentsOf: audioURL!)
                    reproducirAudio!.play()
                    print("Reproduciendo")
                } catch {
                    print("Error al reproducir el audio")
                }
    }
    
     @IBAction func botonAgregarTapped(_ sender: Any) {
         self.agregarPromocion.isEnabled = false
                 let audioFolder = Storage.storage().reference().child("audios")
                 let audioData = NSData(contentsOf: audioURL!)! as Data
                 let cargarAudio =  audioFolder.child("\(audioID).m4a")
                 cargarAudio.putData(audioData, metadata: nil) { (metadata, error) in
                     if error != nil {
                         self.mostrarAlerta(titulo: "Error", mensaje: "Se produjo un error al subir el audio. Verifique su conexion a internet y vuelva a intentarlo", accion: "Aceptar")
                         self.agregarPromocion.isEnabled = true
                         print("Ocurrio un error al subir el audio: (error)")
                         return
                     } else {
                         cargarAudio.downloadURL(completion: {(url, error) in
                             guard let enlaceURL = url else {
                                 self.mostrarAlerta(titulo: "Error", mensaje: "Se produjo un error al obtener informacion de audio", accion: "Cancelar")
                                 self.agregarPromocion.isEnabled = true
                                 print("Ocurrio un error al obtener informacion de imagen (error)")
                                 return
                             }
                             self.navigationController?.popViewController(animated: true)
                         })
                     }
                   }
                  // Guardar en Firebase como una nueva coleccion
         let grabacion = ["nombreAudio": nombrePromocionTextField.text!, "audioID":audioID, "audioURL": audioUrl + "m4a", "categoria":categoriaSeleccionada] as [String : Any]
                 Database.database().reference().child("promociones").childByAutoId().setValue(grabacion)

     }
    func mostrarAlerta(titulo: String, mensaje: String, accion: String) {
            let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
            let btnCANCELOK = UIAlertAction(title: accion, style: .default, handler: nil)
            alerta.addAction(btnCANCELOK)
            present(alerta, animated: true, completion: nil)
        }
    
    
    
    
    func configurarGrabacion(){
            do {
                // creando sesion del audio
                let session = AVAudioSession.sharedInstance()
                try session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: [])
                try session.overrideOutputAudioPort(.speaker)
                try session.setActive(true)

                // creando direccion para el archivo del audio
                let basePath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                let pathComponents = [basePath,"audio.m4a"]
                audioURL = NSURL.fileURL(withPathComponents: pathComponents)!

                // impresion de rutas
                print("**")
                print(audioURL!)
                print("**")
                // crear opciones para el grabador de audio
                var settings:[String:AnyObject] = [:]

                settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
                settings[AVSampleRateKey] = 44100.0 as AnyObject?
                settings[AVNumberOfChannelsKey] = 2 as AnyObject?

                // crear el objeto de grabacion
                grabarAudio = try AVAudioRecorder(url: audioURL!, settings:  settings)
                grabarAudio!.prepareToRecord()

            } catch let error as NSError {
                print(error)
            }
        }

        @objc func tiempoTotal()-> Void{
            let tiempoEnHora = Int(grabarAudio!.currentTime)
            let minuto = (tiempoEnHora % 3600) / 60
            let segundo = (tiempoEnHora % 3600) % 60
            var tiempoConFormato = ""
            tiempoConFormato += String(format:"%02d", minuto)
            tiempoConFormato += ":"
            tiempoConFormato += String(format: "%02d", segundo)
            tiempoConFormato += ""
            duracionOutlet.text! = tiempoConFormato
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
