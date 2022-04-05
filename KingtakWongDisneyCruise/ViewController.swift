//
//  ViewController.swift
//  KingtakWongDisneyCruise
//
//  Created by Kingtak Justin Wong on 4/4/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var comicViewModel: ComicsViewModel = ComicsViewModel(endpoint: ComicEndpoint(credential: ProdInformation.shared))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isHidden = true
        tableView.register(UINib(nibName: "ComicTableCell", bundle: .main), forCellReuseIdentifier: "ComicTableCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(setupLoadingScreen), name: .loadingComics, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideLoadingScreen), name: .finishedLoadingComics, object: nil)
        
        Task {
            do {
                try await comicViewModel.initalizeData()
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    @objc func setupLoadingScreen() {
    }
    
    @objc func hideLoadingScreen() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.loadingView.isHidden = true
        }
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicViewModel.comics.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !comicViewModel.isFetching else { return }

        // If 2/3rds the way through the data, pull new data
        let partialWayAmount = comicViewModel.comics.count * 2 / 3
        let currentRow = indexPath.row
        
        if currentRow >= partialWayAmount {
            do {
                try comicViewModel.getMoreComics()
            } catch {
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let comicCell = tableView.dequeueReusableCell(withIdentifier: "ComicTableCell", for: indexPath) as? ComicTableCell else { return UITableViewCell() }

        comicCell.configure(with: comicViewModel.comics[indexPath.row])
        
        return comicCell
    }
    
}
