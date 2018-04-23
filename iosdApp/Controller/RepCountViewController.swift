//
//  RepCountViewController.swift
//  iosdApp
//
//  Created by Bhavin on 22/04/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import UIKit

class RepCountViewController: UIViewController, UITextFieldDelegate {
    
    var count: String!
    var countInt: Int!
    var currentExercise: Exercise?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let repCountLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Enter Rep Counts"
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        lbl.textAlignment = .center
        lbl.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let countField: UITextField = {
        let txtField = UITextField()
        
        txtField.placeholder = "0"
        txtField.translatesAutoresizingMaskIntoConstraints = false
        
        return txtField
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(repCountLabel)
        view.addSubview(countField)
        
        self.navigationController?.isNavigationBarHidden = false
        
        count = ""
        countInt = 0
        
        print(currentExercise?.name)
        
        countField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "NEXT", style: .plain, target: self, action: #selector(handleNext))

        repCountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        repCountLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        repCountLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350).isActive = true
        repCountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        //countField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        countField.topAnchor.constraint(equalTo: repCountLabel.bottomAnchor, constant: 10).isActive = true
        countField.heightAnchor.constraint(equalToConstant: 100).isActive = true
        countField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        countField.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handleNext(){
        print("next")
        let practiceViewController = PracticeViewController()
        practiceViewController.currentExercise = currentExercise!
        if let countInt = Int(count){
            practiceViewController.currentRepCount = countInt
        }else{
            practiceViewController.currentRepCount = 0
        }
        navigationController?.pushViewController(practiceViewController, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        count = countField.text
        print("The count after return is \(count)")
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        count = countField.text
        print("The count after touches is \(count)")
        print(count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
