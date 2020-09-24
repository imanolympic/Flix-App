//
//  MoviesViewController.swift
//  flixster
//
//  Created by Theron Mansilla on 9/23/20.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    var movies = [[String:Any]]()
    let imageBaseURL:String = "https://image.tmdb.org/t/p/w185"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
              
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            self.moviesTableView.reloadData()
           }
        }
        task.resume()
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
}


extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movie Cell") as! MovieTableViewCell
        
        let movie = movies[indexPath.row]
        print(movie)
 
        let movieTitle = movie["title"] as! String
        let movieSynopsis = movie["overview"] as! String
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: self.imageBaseURL + posterPath)
        
        cell.configure(title: movieTitle, synopsis: movieSynopsis, posterURL: posterURL!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
