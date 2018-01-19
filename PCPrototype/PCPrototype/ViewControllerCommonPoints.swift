//
//  ViewControllerCommonPoints.swift
//  PCPrototype
//
//  Created by Diego Monteverde on 12/13/17.
//  Copyright © 2017 ihelperdevelop. All rights reserved.
//

import UIKit

class ViewControllerCommonPoints: UIViewController {

    @IBOutlet weak var instructionsText: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var stance: Bool?
    var caseId: String = "1"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if DBManager.shared.getStance(id: caseId) == "1"{
            stance = true
        } else {
            stance = false
        }
        
        addCheckboxes()
        instructionsText.isEditable = false
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
    
    func addCheckboxes () {
        let width = scrollView.bounds.size.width
        let height = scrollView.bounds.size.height
        let xCoord:CGFloat = scrollView.bounds.minX + 10
        var yCoord:CGFloat = scrollView.bounds.minY + 10
        let cbWidth:CGFloat = 25
        let cbHeight:CGFloat = 25
        let cbTextWidth:CGFloat = width/3 * 2.2
        let cbTextHeight:CGFloat = height/4
        
        let data = DBManager.shared.getArgumentFragments(id: caseId, stance: stance!)
        
        
        for i in 0 ... data!.count-1{
            let btnCheckbox:UIButton = UIButton(type: UIButtonType.custom) as UIButton
            btnCheckbox.frame = CGRect.init(x: xCoord, y: yCoord, width: cbWidth, height: cbHeight)
            btnCheckbox.setBackgroundImage(UIImage(named: "checkbox_off.png"), for: .normal)
            btnCheckbox.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
            let cbText:UITextView = UITextView()
            cbText.frame = CGRect.init(x: xCoord + cbWidth + 5, y: yCoord - 3, width: cbTextWidth, height: cbTextHeight)
            cbText.text = data![i]
            cbText.textColor = UIColor.white
            cbText.font = UIFont (name: "Quicksand", size: 16)
            cbText.backgroundColor = UIColor(white: 1, alpha: 0.0)
            cbText.isEditable = false
            
            self.scrollView.addSubview(btnCheckbox)
            self.scrollView.addSubview(cbText)
            
            yCoord += cbTextHeight - 10
        }
        
        self.scrollView.contentSize = CGSize.init(width: scrollView.bounds.size.width, height:scrollView.bounds.size.height + yCoord)

    }
    
    @objc func btnAction(cbBtn:UIButton){
        cbBtn.isSelected = !cbBtn.isSelected
        if cbBtn.isSelected {
            cbBtn.setBackgroundImage(UIImage(named: "checkbox_on.png"), for: .normal)
        } else {
            cbBtn.setBackgroundImage(UIImage(named: "checkbox_off.png"), for: .normal)
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
