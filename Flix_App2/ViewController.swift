//
//  ViewController.swift
//  Flix_App2
//
//  Created by Katrina Tsun on 11/19/21.
//

import UIKit
import AlamofireImage


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.textLabel!.text = "row: \(indexPath.row)"
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"]
        cell.titleLabel.text = title as? String

        let synopsis = movie["overview"] as? String
        cell.synopsisLabel.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)

        cell.posterView.af.setImage(withURL: posterUrl!)
        
        return cell
    }
    

    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        print("hello")
        tableView.rowHeight = 150
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print("got data")
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    self.movies = dataDictionary["results"] as! [[String:Any]]
                    print("got movies")
                    print(self.movies)
                    // TODO: Reload your table view data
                    self.tableView.reloadData()
                    print("reloaded table")
             }
        }
        task.resume()
    }


}

