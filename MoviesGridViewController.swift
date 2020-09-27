//
//  MoviesGridViewController.swift
//  flixster
//
//  Created by Theron Mansilla on 9/26/20.
//

import UIKit

class MoviesGridViewController: UIViewController {
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        let layout = moviesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        let height = (view.frame.width * 2) / 3
        layout.itemSize = CGSize(width: width, height: height)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
              
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            self.moviesCollectionView.reloadData()
           }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Capture the cell requesting to be displayed
        let cell = sender as! MovieCollectionViewCell
        
        // Capture the movie to be displayed
        let indexPath = moviesCollectionView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        let movieDetailsViewController = segue.destination as! MovieDetailsViewController
        movieDetailsViewController.movie = movie
    }
}

extension MoviesGridViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Movie Grid Cell", for: indexPath) as! MovieCollectionViewCell
        
        let movie = movies[indexPath.row]
        
        let imageBaseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: imageBaseURL + posterPath)
        
        cell.configure(posterURL: posterURL!)
        
        return cell
    } 
}
