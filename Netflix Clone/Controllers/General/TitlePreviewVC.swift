//
//  TitlePreviewVC.swift
//  Netflix Clone
//
//  Created by Haytham on 03/09/2023.
//

import UIKit
import WebKit

class TitlePreviewVC: UIViewController {
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Download", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is an amazing movie for the whole entire family"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Home Alone"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        
        applyConstraints()
    }
    
    func configure(with model: TitlePreviewViewModel){
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    
    private func applyConstraints(){
        let webViewConstraints = [
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 250)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20)
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
        
    }
    
    
}
