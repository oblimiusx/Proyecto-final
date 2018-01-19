//
//  ViewControllerPreviousOpinion.swift
//  PCPrototype
//
//  Created by Diego Monteverde on 12/13/17.
//  Copyright © 2017 ihelperdevelop. All rights reserved.
//

import UIKit

class ViewControllerPreviousOpinion: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.text = DBManager.shared.getWhy(id: "1")
        textView.isEditable = false
        if navigationController != nil {
            self.navigationController!.navigationBar.topItem!.title = "Atrás"
        }
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
