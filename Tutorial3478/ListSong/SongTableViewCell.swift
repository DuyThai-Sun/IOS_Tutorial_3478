//
//  SongTableViewCell.swift
//  Tutorial3478
//
//  Created by Duy Thái on 13/12/2022.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    let identifier = "songCell"
    
    @IBOutlet weak var imgSong: UIImageView!
    
    @IBOutlet weak var authorOfSong: UILabel!
    @IBOutlet weak var nameOfSong: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.backgroundColor = UIColor.red.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
