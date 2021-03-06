//
//  MainViewController.swift
//  iosdApp
//
//  Created by Bhavin on 22/04/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let workoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        button.setTitle("Start Workout", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleShow), for: .touchUpInside)
        return button
    }()
    
    let savedWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        button.setTitle("Saved Workouts", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleShowSaved), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentWorkNum = UserDefaults.standard.value(forKey: "currentWorkoutNumber") as? Int{
            print("Current work num is from viewwill\(currentWorkNum)")
            //UserDefaults.standard.set(currentWorkNum + 1, forKey: "currentWorkoutNumber")
        }
        
        print("exercises from view will appear main view controller \(appDelegate.workouts.count)")
    }

    override func viewDidLoad() {
        if let mute = UserDefaults.standard.value(forKey: "isMute") as? Bool{
            
            //UserDefaults.standard.set(currentWorkNum + 1, forKey: "currentWorkoutNumber")
        }else{
            UserDefaults.standard.set(false, forKey: "isMute")
        }
        
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(workoutButton)
        view.addSubview(savedWorkoutButton)
        
        UserDefaults.standard.set(-1, forKey: "currentWorkoutNumber")
        
        print("current work count \(appDelegate.currentWorkout.exercises?.count)")
        if let currentWorkNum = UserDefaults.standard.value(forKey: "currentWorkoutNumber") as? Int{
            print("Current work num is \(currentWorkNum)")
            //UserDefaults.standard.set(currentWorkNum + 1, forKey: "currentWorkoutNumber")
        }else{
           // UserDefaults.standard.set(1, forKey: "currentWorkoutNumber")
        }

        workoutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        workoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        workoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
        workoutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        savedWorkoutButton.topAnchor.constraint(equalTo: workoutButton.bottomAnchor, constant: 10).isActive = true
        savedWorkoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        savedWorkoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
        savedWorkoutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Do any additional setup after loading the view.
    }
    
    @objc func handleShow(){
        print("showing ")
        var vc = ViewController()
        let viewController = UINavigationController(rootViewController: vc)
        present(viewController, animated: true, completion: nil)
    }
    
    @objc func handleShowSaved(){
        print("showing saved")
        if(appDelegate.workouts.count == 0){
            let vc = NoSavedWorkoutViewController()
            present(vc, animated: true, completion: nil)
        }else{
            let vc = WorkoutHistoryTableViewController()
            let navBarController = UINavigationController(rootViewController: vc)
            present(navBarController, animated: true, completion: nil)
        }
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
