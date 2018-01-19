//
//  ViewControllerQuiz.swift
//  PCPrototype
//
//  Created by Diego Monteverde on 11/23/17.
//  Copyright © 2017 ihelperdevelop. All rights reserved.
//

import UIKit

class ViewControllerQuiz: UIViewController {

    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var cbTwoNo: UIButton!
    @IBOutlet weak var cbTwoYes: UIButton!
    @IBOutlet weak var cbOneNo: UIButton!
    @IBOutlet weak var cbOneYes: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.btnContinue.isEnabled = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cbQuestionOne(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender == cbOneYes {
            cbOneNo.isEnabled = false
        } else {
            cbOneYes.isEnabled = false
        }
        enableContinueBtn ()
    }
    

    @IBAction func cbQuestionTwo(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender == cbTwoYes {
            cbTwoNo.isEnabled = false
        } else {
            cbTwoYes.isEnabled = false
        }
        enableContinueBtn () 
    }
    
    func enableContinueBtn () {
        var questionOne: Bool = false
        var questionTwo: Bool = false
        
        if cbOneYes.isSelected || cbOneNo.isSelected {
            questionOne = true
        }
        
        if cbTwoYes.isSelected || cbTwoNo.isSelected {
            questionTwo = true
        }
        
        if questionOne && questionTwo {
            btnContinue.isEnabled = true
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
