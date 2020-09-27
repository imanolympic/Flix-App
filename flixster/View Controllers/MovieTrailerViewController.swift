//
//  MovieTrailerViewController.swift
//  flixster
//
//  Created by Theron Mansilla on 9/27/20.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController {
    
    var movieID:Int!
    
    @IBOutlet weak var movieTrailerWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTrailerWebView.uiDelegate = self
        view = movieTrailerWebView
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID!)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let movieTrailers = dataDictionary["results"] as! [[String:Any]]
                let movieTrailer = movieTrailers[0]
                let movieTrailerKey = movieTrailer["key"]
                
                let myURL = URL(string:"https://www.youtube.com/watch?v=\(movieTrailerKey!)")
                let myRequest = URLRequest(url: myURL!)
                self.movieTrailerWebView.load(myRequest)
            }
        }
        task.resume()
    }
    
}

extension MovieTrailerViewController: WKUIDelegate {
    
    
}
