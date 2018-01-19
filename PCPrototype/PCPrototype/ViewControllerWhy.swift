//
//  ViewControllerWhy.swift
//  PCPrototype
//
//  Created by Diego Monteverde on 12/7/17.
//  Copyright © 2017 ihelperdevelop. All rights reserved.
//

import UIKit

class ViewControllerWhy: UIViewController {

    @IBOutlet weak var editText: UITextView!
    @IBOutlet weak var editTextTopConstraint: NSLayoutConstraint!
    
    var keyBoardUp: Bool=false
    var topLength: CGFloat = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //editText.text = DBManager.shared.getStance(id: "1")
    }
    
    @IBAction func touchDetection(_ sender: Any) {
        self.editText.resignFirstResponder()
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        DBManager.shared.updateWhy(why: editText.text)
        DBManager.shared.updateModule(module: "1")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector:#selector(self.tecladoSube), name:.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(tecladoBaja), name:.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tecladoSube(_ notif:Notification){
        if !self.keyBoardUp{
            if let userInfo = notif.userInfo {
                let keyboardInfo = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
                let frameTeclado = keyboardInfo.cgRectValue
                let nuevoFrame = self.editText.frame
                topLength = nuevoFrame.origin.y - frameTeclado.size.height + 200
                
                self.editTextTopConstraint.constant = -topLength
                self.keyBoardUp = true
                
            }
        }
    }
    
    @objc func tecladoBaja(_ notif:Notification){
        if self.keyBoardUp{
            if let userInfo = notif.userInfo {
                let keyboardInfo = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
                let frameTeclado = keyboardInfo.cgRectValue
                //en la estructura frame teclado, tengo el alt del teclado. Hay que subir la vista lo necesario para que no se bloquee con el teclado
                var nuevoFrame = self.editText.frame
                nuevoFrame.origin.y += frameTeclado.size.height
                self.editText.frame = nuevoFrame
                self.editTextTopConstraint.constant = self.editTextTopConstraint.constant + topLength
                self.keyBoardUp = false
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
