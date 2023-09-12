//
//  DownloadsVC.swift
//  Netflix Clone
//
//  Created by Haytham on 28/08/2023.
//

import UIKit

class DownloadsVC: UIViewController {
    
    private var shows: [ShowItem] = [ShowItem]()
    
    private let downloadedTable: UITableView = {
        let tableview = UITableView()
        tableview.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(downloadedTable)
        
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .label
        
        downloadedTable.delegate = self
        downloadedTable.dataSource = self
        
        fetchingLocalStorageForDownload()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadedTable.frame = view.bounds
    }
    
    private func fetchingLocalStorageForDownload() {
        DataPersistenceManager.shared.fetchingShowsFromDatabase { [weak self] result in
            switch result {
            case .success(let shows):
                self?.shows = shows
                self?.downloadedTable.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}
extension DownloadsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  TitleTableViewCell.identifier, for: indexPath) as?  TitleTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: TitleViewModel(titleName: shows[indexPath.row].original_title ?? "Unkonwn Name!!", posterURL: shows[indexPath.row].poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistenceManager.shared.deleteShowWith(model: shows[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print("Deleted from Database")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.shows.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
        
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
