//
//  ViewController.swift
//  PCPrototype
//
//  Created by Diego Monteverde on 11/20/17.
//  Copyright © 2017 ihelperdevelop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneMenuView: UIView!
    @IBOutlet weak var caseImage: UIImageView!
    @IBOutlet weak var caseTitle: UILabel!
    
    var selectedCase = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sceneMenuView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func sceneOne(_ sender: UIButton) {
        sceneMenuView.isHidden = false
        prepareContent(id: "1")
        selectedCase = "1"
    }
    
    func prepareContent (id: String) {
        let caseData = DBManager.shared.getCaseData(id: id)
        self.caseTitle.text = caseData?[0]
        let imageName = caseData![3] + ".png"
        self.caseImage.image = UIImage(named: imageName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! ViewControllerScenePresentation
        
        dvc.caseSelected = selectedCase
    }
    
}

