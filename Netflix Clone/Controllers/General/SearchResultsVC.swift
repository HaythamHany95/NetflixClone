//
//  SearchResultsVC.swift
//  Netflix Clone
//
//  Created by Haytham on 02/09/2023.
//

import UIKit

protocol SearchResultsVCDelegate: AnyObject {
    func searchResultsVCDelegateDidTapShow(_ viewModel: TitlePreviewViewModel)
}

class SearchResultsVC: UIViewController {
    
    public var shows: [Show] = [Show]()
    
    public weak var delegate: SearchResultsVCDelegate?
    
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 7 , height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
    
    
}

extension SearchResultsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: shows[indexPath.row].poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let show = shows[indexPath.row]
        let showName = show.original_title ?? ""
        APICaller.shared.getMovies(with: showName) {[weak self] result in
            
            switch result {
            case.success(let videoElement):
                self?.delegate?.searchResultsVCDelegateDidTapShow(TitlePreviewViewModel(title: show.original_title ?? "", youtubeView: videoElement, titleOverview: show.overview ?? "" ))
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

