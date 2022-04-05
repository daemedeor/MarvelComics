//
//  ComicTableCell.swift
//  KingtakWongDisneyCruise
//
//  Created by Kingtak Justin Wong on 4/4/22.
//

import Foundation
import UIKit

class ComicTableCell: UITableViewCell {
    
    @IBOutlet weak var comicName: UILabel!
    @IBOutlet weak var comicVolume: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var comicImage: UIImageView!
    
    var currentDownload: URLSessionDataTask?

    override func prepareForReuse() {
        super.prepareForReuse()
        currentDownload?.cancel()
    }
    
    func configure(with comic: Comic) {
        comicName.text = comic.title
        comicVolume.text = comic.creators.items.reduce("") { partialResult, current in
            partialResult + " " + current.name
        }
        
        if let comicPath = URL(string: comic.thumbnail.path + "." + comic.thumbnail.extension) {
            self.downloadImage(from: comicPath)
        }
    }
    
    private func downloadImage(from url: URL) {
        currentDownload = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
    
            DispatchQueue.main.async { [weak self] in
                self?.comicImage.image = UIImage(data: data)
                self?.currentDownload = nil
            }
            
        }
        
        currentDownload?.resume()
    }
}
