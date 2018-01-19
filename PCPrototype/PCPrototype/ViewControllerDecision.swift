//
//  ViewControllerDecision.swift
//  PCPrototype
//
//  Created by Diego Monteverde on 11/20/17.
//  Copyright © 2017 ihelperdevelop. All rights reserved.
//

import UIKit

class ViewControllerDecision: UIViewController {

    
    @IBAction func inFavorBtn(_ sender: UIButton) {
        DBManager.shared.updatetStance(stance: "1")
    }

    @IBAction func againstBtn(_ sender: UIButton) {
        DBManager.shared.updatetStance(stance: "0")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
