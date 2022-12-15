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
    
    private var trackName: String?
    
    private var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
       
    }
    private func configView() {
        title = "Detail Screen"
    }
    override func viewWillAppear(_ animated: Bool) {
        congfigSong()
    }
 

    @IBAction func previousSongTapped(_ sender: Any) {
    }

    func congfigSong() {

        let urlString = Bundle.main.path(forResource: "HayTraoChoAnh-SonTungMTPSnoopDogg-6010660", ofType: ".mp3")
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
            player.play()
            
        } catch {
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        if let player = player, player.isPlaying {
            player.stop()
            
        } else {
            return
        }
    }
     
    @IBAction func playSongTapped(_ sender: Any) {
        
        if player?.isPlaying == true {
            playSongButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player?.pause()
           
        } else {
            playSongButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            player?.play()
            
        }
        
      
    }
    func setUpView(song: Song) {
        songImageView.image = UIImage(named: song.imageName)
        nameSongLabel.text = song.name
        artistSongLabel.text = song.artistName
        trackName = song.trackName
        
    }
    
    @IBAction func nextSongTapped(_ sender: Any) {
    }
    
    
}
