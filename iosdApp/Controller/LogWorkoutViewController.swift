//
//  LogWorkoutViewController.swift
//  iosdApp
//
//  Created by Bhavin on 22/04/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import UIKit

class LogWorkoutViewController: UIViewController, UITextFieldDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "ENTER WORKOUT NAME"
        // label.backgroundColor = UIColor.green
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    let repsLabel: UILabel = {
        let label = UILabel()
        label.text = "ENTER REPS PERFORMED"
        // label.backgroundColor = UIColor.green
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "ENTER COMMENT"
        // label.backgroundColor = UIColor.green
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        button.setTitle("Save Workout", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    let nameTextField: UITextField = {
        let nameField = UITextField()
        
        nameField.placeholder = "Enter..."
        nameField.translatesAutoresizingMaskIntoConstraints = false
        
        return nameField
    }()
    
    let repsTextField: UITextField = {
        let repsField = UITextField()
        
        repsField.placeholder = "Enter..."
        repsField.translatesAutoresizingMaskIntoConstraints = false
        
        return repsField
    }()
    
    let commentTextField: UITextField = {
        let commentField = UITextField()
        
        commentField.placeholder = "Enter..."
        commentField.translatesAutoresizingMaskIntoConstraints = false
        
        return commentField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        view.addSubview(repsLabel)
        view.addSubview(commentLabel)
        view.addSubview(saveButton)
        view.addSubview(nameTextField)
        view.addSubview(repsTextField)
        view.addSubview(commentTextField)
        
        nameTextField.delegate = self
        repsTextField.delegate = self
        commentTextField.delegate = self
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        repsLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        repsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        repsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        repsLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        repsTextField.topAnchor.constraint(equalTo: repsLabel.bottomAnchor, constant: 8).isActive = true
        repsTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        repsTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        repsTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        commentLabel.topAnchor.constraint(equalTo: repsTextField.bottomAnchor, constant: 10).isActive = true
        commentLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        commentLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        commentLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        commentTextField.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 8).isActive = true
        commentTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        commentTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        commentTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        // Do any additional setup after loading the view.
    }
    
    @objc func handleSave(){
        
        if let name = nameTextField.text{
            appDelegate.currentWorkout.name = name
        }
        
        if let count = repsTextField.text{
            appDelegate.currentWorkout.totalReps = Int(count)
        }
        
        if let comment = commentTextField.text{
            appDelegate.currentWorkout.comments = comment
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
