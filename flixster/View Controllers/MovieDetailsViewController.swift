//
//  MovieDetailsViewController.swift
//  flixster
//
//  Created by Theron Mansilla on 9/27/20.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movie:[String:Any]!
    
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBAction func posterViewTappped(_ sender: UITapGestureRecognizer) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(movie)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieTrailerViewController = segue.destination as! MovieTrailerViewController
        
        movieTrailerViewController.movieID = movie["id"] as! Int
    }
}
