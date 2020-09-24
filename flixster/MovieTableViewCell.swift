//
//  MovieTableViewCell.swift
//  flixster
//
//  Created by Theron Mansilla on 9/23/20.
//

import UIKit
import AlamofireImage

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSynopsisLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title:String, synopsis:String, posterURL:URL) {
        self.movieTitleLabel.text = title
        self.movieSynopsisLabel.text = synopsis
        
        self.movieImageView.af_setImage(withURL: posterURL)
    }
    
}
