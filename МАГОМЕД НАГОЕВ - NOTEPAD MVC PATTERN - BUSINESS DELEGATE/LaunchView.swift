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


    override init(frame: CGRect) {
        foldersView = UIImageView()
        foldersView.alpha = 0

        logoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        pointsView = UIImageView()
        
        super.init(frame: frame)
        backgroundColor = .red
        uiConfig()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func uiConfig(){
        backgroundColor = #colorLiteral(red: 0.1176470444, green: 0.1176470444, blue: 0.1176470444, alpha: 1)

        addSubview(foldersView)
        addSubview(logoView)
        addSubview(pointsView)

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

            logoView.heightAnchor.constraint(equalToConstant: heightLogo * 0.11).isActive = true
            logoView.widthAnchor.constraint(equalToConstant: widthLogo * 0.11).isActive = true
            
            pointsView.heightAnchor.constraint(equalToConstant: heightPoints * 0.06).isActive = true
            pointsView.widthAnchor.constraint(equalToConstant: widthPoints * 0.06).isActive = true
        }
    }
    
    private func setupConstraints() {
        resizeImageView()
        
        foldersView.translatesAutoresizingMaskIntoConstraints = false
        logoView.translatesAutoresizingMaskIntoConstraints = false
        pointsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            logoView.centerXAnchor.constraint(equalTo: centerXAnchor),

            foldersView.centerYAnchor.constraint(equalTo: centerYAnchor),
            foldersView.centerXAnchor.constraint(equalTo: centerXAnchor),
            foldersView.heightAnchor.constraint(equalToConstant: 234),
            foldersView.widthAnchor.constraint(equalToConstant: 128.7),
            
            pointsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -35),
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
            self?.logoView.alpha = 0
            self?.pointsView.alpha = 0
        } completion: { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
}
