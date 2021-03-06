//
//  VieViewControllerArgument.swift
//  PCPrototype
//
//  Created by Diego Monteverde on 12/13/17.
//  Copyright © 2017 ihelperdevelop. All rights reserved.
//

import UIKit

class ViewControllerArgument: UIViewController {

    @IBOutlet weak var argumentText: UITextView!
    
    var stance: Bool?
    var caseId: String = "1"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if DBManager.shared.getStance(id: caseId) == "1"{
            stance = true
        } else {
            stance = false
        }
        
        let argument = DBManager.shared.getArgument(id: caseId, stance: stance!)
        self.argumentText.text = argument
        
        argumentText.isEditable = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
