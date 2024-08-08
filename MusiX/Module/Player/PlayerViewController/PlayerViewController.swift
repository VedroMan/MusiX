//
//  PlayerViewController.swift
//  MusiX
//
//  Created by Timofey on 14.07.24.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer: AVAudioPlayer?
    var trackTimer: Timer?
    var currentTrackIndex: Int = 0
    
    private var repeatTapped = 0
    private var shuffleTapped = 0
    
    var tracks: [(image: UIImage?, track: String, artist: String)] = []
    
    //MARK: -- UI Elements
    
    //setup play/pause button
    private lazy var playerButton: UIButton = {
        let playBtn = UIButton(type: .system)
        playBtn.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        playBtn.tintColor = .black
        playBtn.translatesAutoresizingMaskIntoConstraints = false
        playBtn.addTarget(self, action: #selector(playPauseMusic), for: .touchUpInside)
        return playBtn
    }()
    
    //setup nextButton
    private lazy var nextButton: UIButton = {
        let next = UIButton(type: .system)
        next.setBackgroundImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        next.tintColor = .black
        next.translatesAutoresizingMaskIntoConstraints = false
        next.addTarget(self, action: #selector(nextButtonTap), for: .touchUpInside)
        return next
    }()
    
    //setup pastButton
    private lazy var pastButton: UIButton = {
        let past = UIButton(type: .system)
        past.setBackgroundImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        past.tintColor = .black
        past.translatesAutoresizingMaskIntoConstraints = false
        past.addTarget(self, action: #selector(pastButtonTap), for: .touchUpInside)
        return past
    }()
    
    //setup trackLabel
    private lazy var trackLabel: UILabel = {
        let label = UILabel()
        label.text = "Track Name"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // setup autor label
    private lazy var autorLabel: UILabel = {
        let label = UILabel()
        label.text = "Autor Name"
        label.textColor = AppColors.mainRed
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //setup slider
    private lazy var musicSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.0
        slider.value = 0.0
        slider.maximumValue = 1.0
        slider.isContinuous = true
        slider.tintColor = AppColors.mainRed
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    //setup trackImage
    private lazy var trackImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "music.note")
        image.tintColor = AppColors.mainRed
        image.backgroundColor = .systemGray4
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // setup trackTimers
    private lazy var trackStartTimer: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trackEndTimer: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // setup repeat track button
    private lazy var repeatTrackButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .systemGray
        btn.setBackgroundImage(UIImage(systemName: "repeat"), for: .normal)
        btn.addTarget(self, action: #selector(repeatButtonTap), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // setup shuffle track button
    private lazy var shuffleTracksButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .systemGray
        btn.setBackgroundImage(UIImage(systemName: "shuffle"), for: .normal)
        btn.addTarget(self, action: #selector(shuffleTracksButtonTap), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

//MARK: -- Setup Layer
private extension PlayerViewController {
    func setup() {
        view.backgroundColor = AppColors.lightGrayMain
        setupConstraints()
        setupAudioPlayer()
        
    }
    //setupConstraints
    func setupConstraints() {
        
        view.addSubview(musicSlider)
        view.addSubview(playerButton)
        view.addSubview(trackLabel)
        view.addSubview(autorLabel)
        view.addSubview(nextButton)
        view.addSubview(pastButton)
        view.addSubview(trackStartTimer)
        view.addSubview(trackEndTimer)
        view.addSubview(trackImage)
        view.addSubview(repeatTrackButton)
        view.addSubview(shuffleTracksButton)
        
        NSLayoutConstraint.activate([
            
            // setup constraints for play/pause button
            playerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerButton.bottomAnchor.constraint(equalTo: musicSlider.topAnchor, constant: -15),
            playerButton.heightAnchor.constraint(equalToConstant: 50),
            playerButton.widthAnchor.constraint(equalToConstant: 45),
            
            // setup constraints for musicSlider
            musicSlider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            musicSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            musicSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            musicSlider.heightAnchor.constraint(equalToConstant: 40),
            
            // setup constraints for trackLabel
            trackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackLabel.topAnchor.constraint(equalTo: trackImage.bottomAnchor, constant: 3),
            
            // setup constraints for autorLabel
            autorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            autorLabel.topAnchor.constraint(equalTo: trackLabel.bottomAnchor, constant: 5),
            
            // setup constraints for next/past button
            nextButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 60),
            nextButton.bottomAnchor.constraint(equalTo: musicSlider.topAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.widthAnchor.constraint(equalToConstant: 40),
            
            pastButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -60),
            pastButton.bottomAnchor.constraint(equalTo: musicSlider.topAnchor, constant: -20),
            pastButton.heightAnchor.constraint(equalToConstant: 40),
            pastButton.widthAnchor.constraint(equalToConstant: 40),
            
            // setup constraints for trackTimers
            trackStartTimer.leadingAnchor.constraint(equalTo: musicSlider.leadingAnchor),
            trackStartTimer.bottomAnchor.constraint(equalTo: musicSlider.topAnchor),
            trackEndTimer.trailingAnchor.constraint(equalTo: musicSlider.trailingAnchor),
            trackEndTimer.bottomAnchor.constraint(equalTo: musicSlider.topAnchor),
            
            // setup constraints for trackImage
            trackImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            trackImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackImage.heightAnchor.constraint(equalToConstant: 350),
            trackImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.89),
            
            // setup constraints for repeat
            repeatTrackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            repeatTrackButton.bottomAnchor.constraint(equalTo: trackStartTimer.topAnchor, constant: -20),
            repeatTrackButton.heightAnchor.constraint(equalToConstant: 35),
            repeatTrackButton.widthAnchor.constraint(equalToConstant: 40),
            
            // setup constraints for shuffle
            shuffleTracksButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            shuffleTracksButton.bottomAnchor.constraint(equalTo: trackEndTimer.topAnchor, constant: -20),
            shuffleTracksButton.heightAnchor.constraint(equalToConstant: 34),
            shuffleTracksButton.widthAnchor.constraint(equalToConstant: 38)
        ])
    }
    
}

//MARK: -- Setup Audio Player
extension PlayerViewController {
    private func setupAudioPlayer() {
        
        guard currentTrackIndex >= 0, currentTrackIndex < tracks.count else { return }
        guard let trackName = tracks[safe: currentTrackIndex] else { return }
        guard let url = Bundle.main.url(forResource: trackName.track, withExtension: "mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.delegate = self
            trackLabel.text = trackName.track
            autorLabel.text = trackName.artist
            updateTrackTimer()
            
        } catch {
            print("Error initializing player \(error)")
        }
        
    }
    
    // setup track switching
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            currentTrackIndex = (currentTrackIndex + 1) % tracks.count
            setupAudioPlayer()
            audioPlayer?.play()
            playerButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
}


//MARK: -- OBJC
private extension PlayerViewController {
    
    //setup play/pause music function
    @objc func playPauseMusic() {
        if audioPlayer?.isPlaying == true {
            audioPlayer?.pause()
            playerButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            stopTrackTimer()
            
        } else {
            
            audioPlayer?.play()
            playerButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            startTrackTimer()
            
        }
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        audioPlayer?.currentTime = TimeInterval(sender.value) * audioPlayer!.duration
        updateTrackTimer()
    }
    
    @objc func updateTrackTimer() {
        
        guard let audioPlayer = audioPlayer else { return }
        musicSlider.value = Float(audioPlayer.currentTime / audioPlayer.duration)
        let startTime = audioPlayer.currentTime
        let endTime = audioPlayer.duration - startTime
        let startTimeString = String(format: "%01d:%02d", Int(startTime) / 60, Int(startTime) % 60)
        let endTimeString = String(format: "%01d:%02d", Int(endTime) / 60, Int(endTime) % 60)
        print(#function)
        
        // setup track time
        trackStartTimer.text = startTimeString
        trackEndTimer.text = endTimeString
    }
    
    // setup next/past track button functions
    @objc func nextButtonTap() {
        if audioPlayer?.isPlaying == true {
            
            currentTrackIndex = (currentTrackIndex + 1) % tracks.count
            setupAudioPlayer()
            audioPlayer?.play()
            playerButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            currentTrackIndex = (currentTrackIndex + 1) % tracks.count
            setupAudioPlayer()
            audioPlayer?.pause()
            playerButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @objc func pastButtonTap() {
        if audioPlayer?.isPlaying == true {
            
            currentTrackIndex = (currentTrackIndex - 1) % tracks.count
            setupAudioPlayer()
            audioPlayer?.play()
            playerButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            currentTrackIndex = (currentTrackIndex - 1) % tracks.count
            setupAudioPlayer()
            audioPlayer?.pause()
            playerButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @objc func repeatButtonTap() {
        repeatTapped += 1
        
        switch repeatTapped {
        case 1:
            repeatTrackButton.tintColor = AppColors.mainRed
            repeatTrackButton.setBackgroundImage(UIImage(systemName: "repeat"), for: .normal)
            //functional
            
        case 2:
            repeatTrackButton.tintColor = AppColors.mainRed
            repeatTrackButton.setBackgroundImage(UIImage(systemName: "repeat.1"), for: .normal)
            //functional
            
        case 3:
            repeatTrackButton.tintColor = .systemGray
            repeatTrackButton.setBackgroundImage(UIImage(systemName: "repeat"), for: .normal)
            repeatTapped = 0
        default:
            break
        }
    }
    
    @objc func shuffleTracksButtonTap() {
        shuffleTapped += 1
        
        switch shuffleTapped {
        case 1:
            shuffleTracksButton.tintColor = AppColors.mainRed
            shuffleTracksButton.setBackgroundImage(UIImage(systemName: "shuffle"), for: .normal)
            //functional
            
        case 2:
            shuffleTracksButton.tintColor = .systemGray
            shuffleTracksButton.setBackgroundImage(UIImage(systemName: "shuffle"), for: .normal)
            shuffleTapped = 0
            
        default:
            break
        }
    }
    
    func startTrackTimer() {
        trackTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTrackTimer), userInfo: nil, repeats: true)
    }
    
    func stopTrackTimer() {
        trackTimer?.invalidate()
        trackTimer = nil
        
    }
}

//MARK: -- Setup Delegate
extension PlayerViewController: LibraryViewControllerDelegate {
    
    // setup delegate
    func didSelectedSong(image: UIImage?, track: String, artist: String) {
        let newTrack = (image: image, track: track, artist: artist)
        
        tracks.append(newTrack)
        currentTrackIndex = tracks.count - 1
        setupAudioPlayer()
        audioPlayer?.play()
        startTrackTimer()
        playerButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
}

#Preview { TabBarViewController() }
