//
//  NoSavedWorkoutViewController.swift
//  iosdApp
//
//  Created by Bhavin on 23/04/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import UIKit

class NoSavedWorkoutViewController: UIViewController {
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "No Saved Workout"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        lbl.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        button.setTitle("DONE", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(nameLabel)
        view.addSubview(doneButton)
        
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 16).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        doneButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        doneButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Do any additional setup after loading the view.
    }
    
    @objc func handleSave(){
        self.dismiss(animated: true, completion: nil)
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
