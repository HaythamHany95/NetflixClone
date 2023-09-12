//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Haytham on 01/09/2023.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonImage = UIImage(systemName: "play.circle" ,withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let titlePosterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePosterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        
        applayConstraints()
    }
    
    
    private func applayConstraints(){
        let titlePosterImageConstraints = [
            titlePosterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            titlePosterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titlePosterImage.widthAnchor.constraint(equalToConstant: 100),
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterImage.trailingAnchor,constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: playTitleButton.leadingAnchor,constant: -50),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let playTitleButtonConstraints = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(titlePosterImageConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playTitleButtonConstraints)
        
    }
    
    public func configure(with model: TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else {return}
        
        titlePosterImage.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}


