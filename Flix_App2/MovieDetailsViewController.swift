//
//  MovieDetailsViewController.swift
//  Flix_App2
//
//  Created by Katrina Tsun on 11/29/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    var movie: [String:Any]!

    @IBOutlet weak var backdropView: UIImageView!
    
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/"
        let posterSize = "w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterSize + posterPath)

        posterView.af.setImage(withURL: posterUrl!)
        
        let backdropSize = "w780"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: baseUrl + backdropSize + backdropPath)

        backdropView.af.setImage(withURL: backdropUrl!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
