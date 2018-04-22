//
//  ExerciseLogViewController.swift
//  iosdApp
//
//  Created by Bhavin on 22/04/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import UIKit

class ExerciseLogViewController: UIViewController {
    
    var name: String?
    var count: Int?
    var timer: Timer?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let saveLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        lbl.textAlignment = .center
        lbl.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let repCountLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        lbl.textAlignment = .center
        lbl.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(saveLabel)
        view.addSubview(repCountLabel)
        
        saveLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        saveLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        saveLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350).isActive = true
        saveLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        //repCountLabel.leftAnchor.constraint(equalTo: saveLabel.leftAnchor, constant: 20).isActive = true
        repCountLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        repCountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        repCountLabel.topAnchor.constraint(equalTo: saveLabel.bottomAnchor, constant: 20).isActive = true
        repCountLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
        saveLabel.text = "Saving log for \(name!)"
        repCountLabel.text = "\(count!) reps"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func update(){
        print("this is fired")
        self.timer?.invalidate()
        self.timer = nil
        var newPerformed = PerformedExercise(name: name!, repCount: count!, repDone: count!)
        appDelegate.currentWorkout.exercises?.append(newPerformed)
        self.dismiss(animated: true, completion: nil)
    }

}
