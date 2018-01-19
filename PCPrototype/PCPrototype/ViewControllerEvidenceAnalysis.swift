//
//  ViewControllerEvidenceAnalysis.swift
//  PCPrototype
//
//  Created by Diego Monteverde on 11/23/17.
//  Copyright © 2017 ihelperdevelop. All rights reserved.
//

import UIKit

class ViewControllerEvidenceAnalysis: UIViewController {

    @IBOutlet weak var lblFeedback: UILabel!
    @IBOutlet weak var cbYes: UIButton!
    @IBOutlet weak var cbNo: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btnNext.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkboxTouch(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender == cbYes {
            cbNo.isEnabled = false
            lblFeedback.text = "¡Muy bien!"
            btnNext.isEnabled = true
        } else {
            cbYes.isEnabled = false
            lblFeedback.text = "Incorrecto"
            btnNext.isEnabled = true
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
