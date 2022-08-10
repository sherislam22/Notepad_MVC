//
//  InformationViewController.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 7/8/22.
//

import UIKit

class InformationViewController: UIViewController {
//MARK: ----------------------------------------- Label -------------------------------------------------
    
    
    let komandaRaz: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Команда Разработки"
        return label
    }()
    
    let businessD: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Business deligate"
        return label
    }()
    let bekLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
       // label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.text = "Бекболсун Таалайбеков"
        return label
    }()
    let begLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.text = "Бегайым Акунова"
        return label
    }()
    let nargLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.text = "Наргиза Бейшекенова"
        return label
    }()
    let pamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.text = "Памирбек Алмазбеков"
        return label
    }()
    let sherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.text = "Шерислам Таалантбеков"
        return label
    }()
    let beksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
       // label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.text = "Бексултан Маратов"
        return label
    }()
    let magLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.text = "Магомед Нагоев"
        return label
    }()
    
//MARK: ----------------------------------------- Image -------------------------------------------------
    
    let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pazl-1")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let bekImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bek")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let lineImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "imageLine")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
//MARK: ----------------------------------------- OVERRIDE -------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(komandaRaz)
        view.addSubview(businessD)
        view.addSubview(image)
        view.addSubview(lineImage)
        view.addSubview(bekImage)
        view.addSubview(bekLabel)
        view.addSubview(begLabel)
        view.addSubview(nargLabel)
        view.addSubview(pamLabel)
        view.addSubview(sherLabel)
        view.addSubview(beksLabel)
        view.addSubview(magLabel)
        setapLayout()

//MARK: ----------------------------------------- Constrent -------------------------------------------------
        komandaRaz.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        komandaRaz.topAnchor.constraint(equalTo: view.topAnchor, constant: -40).isActive = true
        
        businessD.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        businessD.topAnchor.constraint(equalTo: view.topAnchor, constant: -10).isActive = true
        
        bekLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        bekLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        
        begLabel.topAnchor.constraint(equalTo: bekLabel.bottomAnchor, constant: 40).isActive = true
        begLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        
        nargLabel.topAnchor.constraint(equalTo: begLabel.bottomAnchor, constant: 40).isActive = true
        nargLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true

        pamLabel.topAnchor.constraint(equalTo: nargLabel.bottomAnchor, constant: 40).isActive = true
        pamLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true

        sherLabel.topAnchor.constraint(equalTo: pamLabel.bottomAnchor, constant: 40).isActive = true
        sherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true

        beksLabel.topAnchor.constraint(equalTo: sherLabel.bottomAnchor, constant: 40).isActive = true
        beksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true

        magLabel.topAnchor.constraint(equalTo: beksLabel.bottomAnchor, constant: 40).isActive = true
        magLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true

    }
   
    private func setapLayout() {
        image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 120).isActive = true
        image.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 95).isActive = true
        image.widthAnchor.constraint(equalToConstant: 300).isActive = true
        image.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        bekImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        bekImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        bekImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        bekImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        lineImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -12).isActive = true
        lineImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        lineImage.widthAnchor.constraint(equalToConstant: 400).isActive = true
        lineImage.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
       
    }
    
}
