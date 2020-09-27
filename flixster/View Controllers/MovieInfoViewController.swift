//
//  MovieInfoViewController.swift
//  flixster
//
//  Created by Theron Mansilla on 9/26/20.
//

import UIKit
import AlamofireImage

class MovieInfoViewController: UIViewController {

    var movie:[String:Any]!
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = (movie["title"] as! String)
        titleLabel.sizeToFit()
        
        synopsisLabel.text = (movie["overview"] as! String)
        synopsisLabel.sizeToFit()
        
        let posterBaseURL:String = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: posterBaseURL + posterPath)
        posterImageView.af_setImage(withURL: posterURL!)
        
        let backdropBaseURL:String = "https://image.tmdb.org/t/p/w780"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: backdropBaseURL + posterPath)
        backDropImageView.af_setImage(withURL: backdropURL!)
    }
}
