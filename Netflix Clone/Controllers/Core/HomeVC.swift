//
//  HomeVC.swift
//  Netflix Clone
//
//  Created by Haytham on 28/08/2023.
//

import UIKit


enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTvs    = 1
    case Popular        = 2
    case UpComingMovies = 3
    case TopRated       = 4
}


class HomeVC: UIViewController {
    
    private var randomTrendingMovie: Show?
    private var headerView: HeroHeaderView?
    
    let sectionTitles : [String] = ["Trending Movies", "Trending TV", "Popular", "Upcoming Movies", "Top Rated"]
    
    private let homeFeedTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTableView)
        
        
        homeFeedTableView.delegate = self
        homeFeedTableView.dataSource = self
        
        headerView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTableView.tableHeaderView = headerView
        
        configureNavBar()
        configureHeroHeaderView()
    }
    
    private func configureHeroHeaderView() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let shows):
                let selectedShow = shows.randomElement()
                self?.randomTrendingMovie = selectedShow
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedShow?.original_title ?? selectedShow?.original_name ?? "", posterURL: selectedShow?.poster_path ?? ""))
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTableView.frame = view.bounds
        
    }
    
    
    
    
    private func configureNavBar() {
        // Left BarButton is not in its right position
        
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image:UIImage(systemName:"person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image:UIImage(systemName:"play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .label
    }
    
    
}
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
            
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { results in
                switch results {
                case .success(let shows):
                    cell.configure(with: shows)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TrendingTvs.rawValue:
            APICaller.shared.getTrendingTvs { results in
                switch results {
                case .success(let shows):
                    cell.configure(with: shows)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Popular.rawValue:
            APICaller.shared.getPopular { results in
                switch results {
                case .success(let shows):
                    cell.configure(with: shows)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.UpComingMovies.rawValue:
            APICaller.shared.getUpComingMovies { results in
                switch results {
                case .success(let shows):
                    cell.configure(with: shows)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRatedMovies { results in
                switch results {
                case .success(let shows):
                    cell.configure(with: shows)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18,weight: .semibold)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    //To make navigationBar disappear when the user scrolls down
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform =  .init(translationX: 0, y: min(0,-offset))
    }
}
extension HomeVC: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async {
            let vc = TitlePreviewVC()
            vc.configure(with: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
