//
//  HeroHeaderView.swift
//  Netflix Clone
//
//  Created by Haytham on 29/08/2023.
//

import UIKit

class HeroHeaderView: UIView {
    
    private let playButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let downloadButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let heroHeaderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    //For Making the hero header view colors gradient
    
    private func addGradients(){
        let gradieentLayer = CAGradientLayer()
        gradieentLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.tertiaryLabel.cgColor
        ]
        gradieentLayer.frame = bounds
        layer.addSublayer(gradieentLayer)

    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroHeaderImageView)
        addSubview(playButton)
        addSubview(downloadButton)
        
        addGradients()
        configureConstraints()
    }
    
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else {return}
        heroHeaderImageView.sd_setImage(with: url, completed: nil)
    }
    
    private func configureConstraints(){
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 70),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 110)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -70),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 110)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }


    override func layoutSubviews() {
        heroHeaderImageView.frame = bounds
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
