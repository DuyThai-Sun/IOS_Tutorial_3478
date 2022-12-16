//
//  SongTableViewCell.swift
//  Tutorial3478
//
//  Created by Duy Thái on 13/12/2022.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    let identifier = "songCell"
    @IBOutlet private weak var songImageView: UIImageView!
    @IBOutlet private weak var authorOfSong: UILabel!
    @IBOutlet private weak var nameOfSong: UILabel!
    private var song = Song()
    
    override func awakeFromNib() {
    super.awakeFromNib()
        layer.backgroundColor = UIColor.black.cgColor
    }
    
    override func layoutSubviews() {
        self.configView()
    }
    
    private func configView() {
        self.songImageView.image = UIImage(named: song.imageName)
        self.authorOfSong.text = song.artistName
        self.nameOfSong.text = song.name
    }
    
    func configSong(song: Song) {
        self.song = song
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
