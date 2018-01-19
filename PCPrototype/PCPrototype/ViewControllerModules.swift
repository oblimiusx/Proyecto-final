//
//  ViewControllerModules.swift
//  PCPrototype
//
//  Created by Diego Monteverde on 12/6/17.
//  Copyright © 2017 ihelperdevelop. All rights reserved.
//

import UIKit

class ViewControllerModules: UIViewController {

    @IBOutlet weak var moduleOne: UIButton!
    @IBOutlet weak var moduleTwo: UIButton!
    @IBOutlet weak var moduleThree: UIButton!
    @IBOutlet weak var moduleOneImage: UIImageView!
    @IBOutlet weak var moduleTwoImage: UIImageView!
    @IBOutlet weak var moduleThreeImage: UIImageView!
    @IBOutlet weak var doneLbl: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navigationController != nil {
            self.navigationController!.navigationBar.topItem!.title = "Atrás"
        }
        prepareModules()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareModules() {
        var clearedModules = DBManager.shared.getModules(id: "1")
        moduleTwo.isEnabled = false
        moduleThree.isEnabled = false
        
        if clearedModules![0] == "1"{
            self.moduleTwo.isEnabled = true
            self.moduleOne.isEnabled = false
            self.moduleOneImage.image = UIImage(named: "success.png")
        }
        
        if clearedModules![1] == "1"{
            self.moduleThree.isEnabled = true
            self.moduleTwo.isEnabled = false
            self.moduleTwoImage.image = UIImage(named: "success.png")
            
        } 
        
        if clearedModules![2] == "1"{
            self.moduleThreeImage.image = UIImage(named: "success.png")
            //self.moduleThree.isEnabled = false
        }
        
        if clearedModules![0] == "1" && clearedModules![1] == "1" && clearedModules![2] == "1" {
            doneLbl.text = "Escenario terminado"
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
