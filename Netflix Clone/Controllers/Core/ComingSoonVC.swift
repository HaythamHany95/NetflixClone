//
//  ComingSoonVC.swift
//  Netflix Clone
//
//  Created by Haytham on 28/08/2023.
//

import UIKit

class ComingSoonVC: UIViewController {
    
    var shows: [Show] = [Show]()
    
    private let upcomingTable: UITableView = {
        let tableview = UITableView()
        tableview.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        navigationController?.navigationBar.tintColor = .label
        
        fetchUpcomingMovies()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    private func fetchUpcomingMovies(){
        APICaller.shared.getUpComingMovies { [weak self] results in
            switch results {
            case .success(let shows):
                self?.shows = shows
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
    }
}
extension ComingSoonVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: TitleViewModel(titleName: shows[indexPath.row].original_title ?? "Unkown",
                                            posterURL: shows[indexPath.row].poster_path ?? "Unkown"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let show = shows[indexPath.row]
        guard let showName = show.original_title ?? show.original_name else {
            return
        }
        
        APICaller.shared.getMovies(with: showName) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let videoElement):
                    let vc = TitlePreviewVC()
                    vc.configure(with: TitlePreviewViewModel(title: showName, youtubeView: videoElement, titleOverview: show.overview ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

