//
//  ViewControllerScenePresentation.swift
//  PCPrototype
//
//  Created by Diego Monteverde on 11/20/17.
//  Copyright © 2017 ihelperdevelop. All rights reserved.
//

import UIKit

class ViewControllerScenePresentation: UIViewController {

    @IBOutlet weak var caseView: UITextView!
    @IBOutlet weak var caseTitleView: UILabel!
    
    var caseSelected = ""
    
    @IBAction func startBtn(_ sender: UIButton) {
        DBManager.shared.insertSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let caseData = DBManager.shared.getCaseData(id: caseSelected)
        self.caseTitleView.text = caseData?[0]
        caseView.text = caseData![1] + "\n\n" + caseData![2]
        caseView.isEditable = false
        //caseView.text = "Recientemente salió una nota periodística sobre la iniciativa de una universidad para instalar baños mixtos. \n ¿Estás de acuerdo con la propuesta?"
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
