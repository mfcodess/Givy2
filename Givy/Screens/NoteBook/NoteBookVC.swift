//
//  NoteBookVC.swift
//  Givy
//
//  Created by Max on 21.08.2024.
//

import UIKit

class NoteBookVC: UIViewController {
    
    private lazy var labelInfo = makeLabelInfo()
    private lazy var labelNotification = makeLabel()
    
    private lazy var labelDate = makeLabelDate()
    
    private lazy var imageLamy = makeLogoLamy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(labelInfo)
        makeLabelInfoConstrains()
        
        view.addSubview(labelNotification)
        makeLabelConstrains()
        
        view.addSubview(labelDate)
        makeLabelDateConstrains()
        
        view.addSubview(imageLamy)
        makeLogoLamyConstrains()
    }
    
    private func makeLabelDate() -> UILabel {
        let label = UILabel()
        //label.text = getCurrentDate()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }
    
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter.string(from: Date())
    }
}

private extension NoteBookVC {
    func makeLabelInfo() -> UILabel {
        let labelInfo = UILabel()
        labelInfo.text = "Thank you for your purchase :)"
        labelInfo.textColor = .black
        labelInfo.font = UIFont.boldSystemFont(ofSize: 25)
        labelInfo.textAlignment = .center
        labelInfo.numberOfLines = 0
        
        return labelInfo
    }
    
    func makeLabel() -> UILabel {
        let labelInfo = UILabel()
        labelInfo.numberOfLines = 0
        labelInfo.textAlignment = .center
        labelInfo.text = """
                         Invoice sent to the post office,
                         wait for the message.
                         
                         Date of purchase: \(getCurrentDate()).
                         """
        labelInfo.textColor = .gray
        labelInfo.font = UIFont.boldSystemFont(ofSize: 17)
        
        return labelInfo
    }
    
    func makeLogoLamy() -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(named: "Logo2")
        
        return image
    }
    
    func makeLabelInfoConstrains() {
        labelInfo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelInfo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            labelInfo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            labelInfo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
        ])
    }
    
    func makeLabelConstrains() {
        labelNotification.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelNotification.topAnchor.constraint(equalTo: labelInfo.bottomAnchor, constant: 20),
            labelNotification.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            labelNotification.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
        ])
    }
    
    func makeLabelDateConstrains() {
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelDate.topAnchor.constraint(equalTo: labelNotification.bottomAnchor, constant: 20),
            labelDate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            labelDate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
    }
    
    func makeLogoLamyConstrains() {
        imageLamy.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageLamy.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            imageLamy.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -120),
            imageLamy.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 120),
            
            imageLamy.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
}



