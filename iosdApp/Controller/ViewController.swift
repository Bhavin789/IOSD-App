//
//  ViewController.swift
//  iosdApp
//
//  Created by Bhavin on 21/04/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var flag: Int?
    var exercises = [Exercise]()
    var player : AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    var currentExercise: Exercise?
    var currentExerciseIndex: Int?
    var maxExercises: Int?
    var isPlayerMuted: Bool?
    var time: CMTime?
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 58/255, green: 128/255, blue: 188/255, alpha: 1)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.restorationIdentifier="loginbutton"
        
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    let prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 58/255, green: 128/255, blue: 188/255, alpha: 1)
        button.setTitle("prev", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 58/255, green: 128/255, blue: 188/255, alpha: 1)
        button.setTitle("next", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 58/255, green: 128/255, blue: 188/255, alpha: 1)
        button.setTitle("play", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        return button
    }()
    
    let stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 58/255, green: 128/255, blue: 188/255, alpha: 1)
        button.setTitle("stop", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleStop), for: .touchUpInside)
        return button
    }()
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 58/255, green: 128/255, blue: 188/255, alpha: 1)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        return button
    }()
    
    let muteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 58/255, green: 128/255, blue: 188/255, alpha: 1)
        button.setTitle("mute", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleMute), for: .touchUpInside)
        return button
    }()
    
    let VideoPlayerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
        
    }()
    
    let controlView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
        
    }()
    
    let testView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
        
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.white
        exercises.append(appDelegate.ex1)
        exercises.append(appDelegate.ex2)
        
        self.navigationController?.isNavigationBarHidden = true
        
        if let currentWorkNum = UserDefaults.standard.value(forKey: "currentWorkoutNumber") as? Int{
            UserDefaults.standard.set(currentWorkNum + 1, forKey: "currentWorkoutNumber")
        }else{
            UserDefaults.standard.set(1, forKey: "currentWorkoutNumber")
        }
        
        flag = 0
        isPlayerMuted = false
        maxExercises = exercises.count
        currentExerciseIndex = 0
        currentExercise = exercises[currentExerciseIndex!]
        
        view.addSubview(VideoPlayerView)
        let tapped = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        let videoPlayerFrame = CGRect(x: 0, y: 120, width: view.frame.width, height: view.frame.height - 320)
        
        view.addSubview(loginRegisterButton)
        view.addSubview(controlView)
        view.addSubview(muteButton)
        view.addSubview(doneButton)
        view.addGestureRecognizer(tapped)
        view.isUserInteractionEnabled = true
        
        controlView.addSubview(playButton)
        controlView.addSubview(stopButton)
        controlView.addSubview(prevButton)
        controlView.addSubview(nextButton)
        
        controlView.isHidden = true
        
        VideoPlayerView.frame = videoPlayerFrame
        print("HI there")
        setupPlayerWithUrl(currentExercise?.repUrl!)
        
        
        loginRegisterButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        //loginRegisterButton.bottomAnchor.constraint(equalTo: VideoPlayerView.topAnchor, constant: -12).isActive = true
        loginRegisterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 200).isActive = true
        loginRegisterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        doneButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        doneButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -200).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        controlView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        controlView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        controlView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        controlView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        print((view.frame.width))
        prevButton.topAnchor.constraint(equalTo: controlView.topAnchor, constant: 8).isActive = true
        prevButton.leftAnchor.constraint(equalTo: controlView.leftAnchor, constant: 8).isActive = true
        prevButton.rightAnchor.constraint(equalTo: controlView.rightAnchor, constant: -(3*((view.frame.width)/4) + 8)).isActive = true
        prevButton.bottomAnchor.constraint(equalTo: controlView.bottomAnchor, constant: -8).isActive = true
        
        playButton.topAnchor.constraint(equalTo: controlView.topAnchor, constant: 8).isActive = true
        playButton.leftAnchor.constraint(equalTo: prevButton.rightAnchor, constant: 8).isActive = true
        playButton.rightAnchor.constraint(equalTo: controlView.rightAnchor, constant: -(2*((view.frame.width)/4) + 8)).isActive = true
        playButton.bottomAnchor.constraint(equalTo: controlView.bottomAnchor, constant: -8).isActive = true
        
        stopButton.topAnchor.constraint(equalTo: controlView.topAnchor, constant: 8).isActive = true
        stopButton.leftAnchor.constraint(equalTo: playButton.rightAnchor, constant: 8).isActive = true
        stopButton.rightAnchor.constraint(equalTo: controlView.rightAnchor, constant: -(1*((view.frame.width)/4) + 8)).isActive = true
        stopButton.bottomAnchor.constraint(equalTo: controlView.bottomAnchor, constant: -8).isActive = true
        
        nextButton.topAnchor.constraint(equalTo: controlView.topAnchor, constant: 8).isActive = true
        nextButton.leftAnchor.constraint(equalTo: stopButton.rightAnchor, constant: 8).isActive = true
        nextButton.rightAnchor.constraint(equalTo: controlView.rightAnchor, constant: -8).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: controlView.bottomAnchor, constant: -8).isActive = true
        
        //muteButton.topAnchor.constraint(equalTo: VideoPlayerView.bottomAnchor, constant: 10).isActive = true
        muteButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 200).isActive = true
        muteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        muteButton.bottomAnchor.constraint(equalTo: controlView.topAnchor, constant: -8).isActive = true
        muteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //playerLayer.frame = VideoPlayerView.bounds
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        print("tapped")
        if(flag == 0){
            player.pause()
            controlView.isHidden = false
            flag = 1
        }else{
            player.play()
            controlView.isHidden = true
            flag = 0
        }
    }
    
    @objc func handleLoginRegister(){
        
        print("reg")
        player.pause()
        time = CMTimeMake(0, 10)
        player.seek(to: time!)
        player.pause()
        let countViewController = RepCountViewController()
        countViewController.currentExercise = currentExercise!
        self.navigationController?.pushViewController(countViewController, animated: true)
        
    }
    
    @objc func handlePrevious(){
        playerLayer.removeFromSuperlayer()
        playerLayer = nil
        player = nil
        
        player = AVPlayer()
        playerLayer = AVPlayerLayer()
        
        var temp = currentExerciseIndex! - 1
        if(temp < 0){
            currentExerciseIndex = maxExercises! - 1
        }else{
            currentExerciseIndex = currentExerciseIndex! - 1
        }
        currentExercise = exercises[currentExerciseIndex!]
        print(currentExercise?.name)
        setupPlayerWithUrl(currentExercise?.tutorialUrl)
        
        print("reg")
    }
    
    @objc func handlePlay(){
        player.play()
        print("reg")
    }
    
    @objc func handleStop(){
        player.pause()
        showAlertForStop("Do you want to finish this workout?")
        print("reg")
    }
    
    @objc func handleDone(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNext(){
        player.pause()
        playerLayer.removeFromSuperlayer()
        playerLayer = nil
        player = nil
        
        player = AVPlayer()
        playerLayer = AVPlayerLayer()
        
        currentExerciseIndex = (currentExerciseIndex! + 1)%maxExercises!
        currentExercise = exercises[currentExerciseIndex!]
        print(currentExercise?.name)
        setupPlayerWithUrl(currentExercise?.tutorialUrl!)
        
    }
    
    @objc func handleMute(){
        if isPlayerMuted!{
            player.isMuted = false
            muteButton.setTitle("Mute", for: .normal)
            isPlayerMuted = !isPlayerMuted!
        }else{
            player.isMuted = true
            muteButton.setTitle("Unmute", for: .normal)
            isPlayerMuted = !isPlayerMuted!
        }
    }
    

    
    fileprivate func setupPlayerWithUrl(_ urlString: String!){
        if let videoUrl = URL(string: urlString){
            player = AVPlayer(url: videoUrl)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = .resize
            VideoPlayerView.layer.addSublayer(playerLayer)
            playerLayer.frame = VideoPlayerView.bounds
            //viewDidLayoutSubviews()
            //playerLayer.frame = VideoPlayerView.frame
            player.play()
        }
        
    }
    @objc func handleYes(action: UIAlertAction){
        player.pause()
        playerLayer.removeFromSuperlayer()
        playerLayer = nil
        player = nil
        
        //dismiss(animated: true, completion: nil)
        let saveViewController = LogWorkoutViewController()
        present(saveViewController, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
        print("Handle yes")
        
    }
    
    
    func showAlertForStop(_ msg: String){
        let alert = UIAlertController(title: "Workout", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: handleYes))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

