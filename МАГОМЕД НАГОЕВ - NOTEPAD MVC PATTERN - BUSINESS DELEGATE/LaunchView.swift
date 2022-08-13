//
//  LaunchView.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 13/8/22.
//

import UIKit

class LaunchView: UIView {
    
    private let foldersView: UIImageView
    private let logoView: UIImageView
    private let pointsView: UIImageView
    private let stackView: UIStackView
    
    private let logoName: UILabel

    override init(frame: CGRect) {
        foldersView = UIImageView()
        foldersView.alpha = 0

        logoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        pointsView = UIImageView()
        stackView = UIStackView()
        
        logoName = UILabel()

        super.init(frame: frame)
        backgroundColor = .red
        uiConfig()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func uiConfig(){
        backgroundColor = #colorLiteral(red: 0.1176470444, green: 0.1176470444, blue: 0.1176470444, alpha: 1)
        
        logoName.text = "NOTEPAD"
        logoName.textColor = .white
        logoName.textAlignment = .center
        logoName.font = .systemFont(ofSize: 18, weight: .medium)

        addSubview(foldersView)
        addSubview(logoView)
        addSubview(logoName)
        addSubview(pointsView)
        addSubview(stackView)
        

        foldersView.image = UIImage(named: "folders")
        logoView.image = UIImage(named: "logo")
        logoView.clipsToBounds = true
        pointsView.image = UIImage(named: "points")

        setupConstraints()
        appearAnimation()
    }
    
    private func resizeImageView() {
        if let widthLogo = logoView.image?.size.width,
           let heightLogo = logoView.image?.size.height,
           let widthPoints = pointsView.image?.size.width,
           let heightPoints = pointsView.image?.size.height {

            logoView.heightAnchor.constraint(equalToConstant: heightLogo * 0.6).isActive = true
            logoView.widthAnchor.constraint(equalToConstant: widthLogo * 0.6).isActive = true
            
            pointsView.heightAnchor.constraint(equalToConstant: heightPoints * 0.1).isActive = true
            pointsView.widthAnchor.constraint(equalToConstant: widthPoints * 0.1).isActive = true
        }
    }
    
    private func setupConstraints() {
        resizeImageView()
        
        foldersView.translatesAutoresizingMaskIntoConstraints = false
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoName.translatesAutoresizingMaskIntoConstraints = false
        pointsView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        

        stackView.addArrangedSubview(logoView)
        stackView.addArrangedSubview(logoName)
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fill
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),

            logoName.centerYAnchor.constraint(equalTo: logoView.centerYAnchor),
            logoName.leftAnchor.constraint(equalTo: logoView.rightAnchor, constant: 5),

            
            foldersView.centerYAnchor.constraint(equalTo: centerYAnchor),
            foldersView.centerXAnchor.constraint(equalTo: centerXAnchor),
            foldersView.heightAnchor.constraint(equalToConstant: 234),
            foldersView.widthAnchor.constraint(equalToConstant: 128.7),
            
            pointsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            pointsView.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
    
    private func appearAnimation() {
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.foldersView.alpha = 1
        } completion: { [weak self] _ in
            self?.disappearLaunchView()
        }
    }

    private func disappearLaunchView() {
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.foldersView.alpha = 0
            self?.logoName.alpha = 0
            self?.logoView.alpha = 0
            self?.pointsView.alpha = 0
        } completion: { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
}
