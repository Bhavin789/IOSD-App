//
//  WorkoutLogOfExercisesViewController.swift
//  iosdApp
//
//  Created by Bhavin on 23/04/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import UIKit

class WorkoutLogOfExercisesViewController: UIViewController {
    
    var count: Int?
    var totalReps: Int?
    var comment: String?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "TOTAL EXERCISES"
        // label.backgroundColor = UIColor.green
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    let repsLabel: UILabel = {
        let label = UILabel()
        label.text = "TOTAL REPS PERFORMED"
        // label.backgroundColor = UIColor.green
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "COMMENT"
        // label.backgroundColor = UIColor.green
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        button.setTitle("DONE", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        return button
    }()
    
    let exerciseLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        // label.backgroundColor = UIColor.green
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    let totalRepsLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        // label.backgroundColor = UIColor.green
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    let givenCommentLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        // label.backgroundColor = UIColor.green
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        view.addSubview(repsLabel)
        view.addSubview(commentLabel)
        view.addSubview(doneButton)
        view.addSubview(exerciseLabel)
        view.addSubview(totalRepsLabel)
        view.addSubview(givenCommentLabel)
        
        exerciseLabel.text = "\(count!)"
        totalRepsLabel.text = "\(totalReps!)"
        givenCommentLabel.text = comment!
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        exerciseLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        exerciseLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        exerciseLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        exerciseLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        repsLabel.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 10).isActive = true
        repsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        repsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        repsLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        totalRepsLabel.topAnchor.constraint(equalTo: repsLabel.bottomAnchor, constant: 8).isActive = true
        totalRepsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        totalRepsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        totalRepsLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        commentLabel.topAnchor.constraint(equalTo: totalRepsLabel.bottomAnchor, constant: 10).isActive = true
        commentLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        commentLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        commentLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        givenCommentLabel.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 8).isActive = true
        givenCommentLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        givenCommentLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        givenCommentLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        doneButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        doneButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        // Do any additional setup after loading the view.
    }
    
    @objc func handleDone(){
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
