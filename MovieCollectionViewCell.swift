//
//  MovieCollectionViewCell.swift
//  flixster
//
//  Created by Theron Mansilla on 9/26/20.
//

import UIKit
import AlamofireImage

class MovieCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    func configure(posterURL:URL) {
        self.moviePosterImageView.af_setImage(withURL: posterURL)
    }
    
}
