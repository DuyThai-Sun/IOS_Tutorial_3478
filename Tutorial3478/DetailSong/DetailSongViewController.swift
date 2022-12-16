//
//  DetailSongViewController.swift
//  Tutorial3478
//
//  Created by Duy Thái on 13/12/2022.
//

import UIKit
import AVFoundation

final class DetailSongViewController: UIViewController {
    @IBOutlet private weak var songImageView: UIImageView!
    @IBOutlet private weak var nameSongLabel: UILabel!
    @IBOutlet private weak var previousSongButton: CircleUIButton!
    @IBOutlet private weak var playSongButton: CircleUIButton!
    @IBOutlet private weak var nextSongButton: CircleUIButton!
    @IBOutlet private weak var artistSongLabel: UILabel!
    @IBOutlet private weak var progressSongSlider: UISlider!
    
    private var trackName: String?
    private var song = Song()
    private var listSong = [Song]()
    private var indexOfSong: Int = 0
    private var player: AVAudioPlayer?
    private var repeatFunctionUpadateSlider: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        title = "Detail Screen"
        self.songImageView?.image = UIImage(named: song.imageName)
        self.nameSongLabel?.text = song.name
        self.artistSongLabel?.text = song.artistName
        self.trackName = song.trackName
    }

    override func viewWillAppear(_ animated: Bool) {
        congfigSong()
    }
    
    private func congfigSong() {
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: ".mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else {
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            guard let player = player else {
                return
            }
            let timeOfSong = Float(player.duration)
            progressSongSlider.maximumValue = timeOfSong
            player.play()
            repeatFunctionUpadateSlider = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateprogressSongSlider), userInfo: nil, repeats: true)
        } catch  {
            let storyBoard = UIStoryboard(name: "PopUpScreen", bundle: nil)
            let popUpView = storyBoard.instantiateViewController(withIdentifier: "popUpView") as! PopUpControllerViewController
            self.addChild(popUpView)
            popUpView.setNotice(notice: "\(error)")
            popUpView.view.frame = self.view.frame
            self.view.addSubview(popUpView.view)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let player = player, player.isPlaying {
            player.stop()
            repeatFunctionUpadateSlider?.invalidate()
        } else {
            return
        }
    }

    @IBAction func progressSongAction(_ sender: Any) {
        var currentValue = progressSongSlider.value
        progressSongSlider.value = currentValue
        player!.currentTime = TimeInterval(currentValue)
    }
    
    @objc private func updateprogressSongSlider(){
        progressSongSlider.value = Float(player!.currentTime)
        if progressSongSlider.value >= Float(player!.duration - 0.5) {
            repeatFunctionUpadateSlider?.invalidate()
            player?.stop()
            progressSongSlider.value = 0
            playSongButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @IBAction func previousSongTapped(_ sender: Any) {
        if indexOfSong == 0 {
            let storyBoard = UIStoryboard(name: "PopUpScreen", bundle: nil)
            let popUpView = storyBoard.instantiateViewController(withIdentifier: "popUpView") as! PopUpControllerViewController
            self.addChild(popUpView)
            popUpView.setNotice(notice: "Đây là bài đầu")
            popUpView.view.frame = self.view.frame
            self.view.addSubview(popUpView.view)
        } else {
                indexOfSong -= 1
                self.song = listSong[indexOfSong]
                congfigSong()
                configView()
        }

    }
   
    @IBAction func playSongTapped(_ sender: Any) {
        if player?.isPlaying == true {
            playSongButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player?.pause()
            repeatFunctionUpadateSlider?.invalidate()
        } else {
            playSongButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            player?.play()
            repeatFunctionUpadateSlider = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateprogressSongSlider), userInfo: nil, repeats: true)
        }
    }
    
    func setUpView(song: Song, listSong: [Song], indexOfSong: Int) {
        self.song = song
        self.listSong = listSong
        self.indexOfSong = indexOfSong
    }
   
    @IBAction func nextSongTapped(_ sender: Any) {
        if indexOfSong == listSong.count - 1 {
            let storyBoard = UIStoryboard(name: "PopUpScreen", bundle: nil)
            let popUpView = storyBoard.instantiateViewController(withIdentifier: "popUpView") as! PopUpControllerViewController
            self.addChild(popUpView)
            popUpView.setNotice(notice: "Đây là bài cuối")
            popUpView.view.frame = self.view.frame
            self.view.addSubview(popUpView.view)
        } else {
                indexOfSong += 1
                self.song = listSong[indexOfSong]
                congfigSong()
                configView()
        }
    }
    
    func repeatSong() {
        player?.play()
        repeatFunctionUpadateSlider = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateprogressSongSlider), userInfo: nil, repeats: true)
        playSongButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)

    }
    
}
