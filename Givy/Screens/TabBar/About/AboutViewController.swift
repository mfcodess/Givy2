//
//  AboutViewController.swift
//  Givy
//
//  Created by Max on 27.07.2024.
//

import UIKit

class AboutViewController: UIViewController {
    
    private lazy var viewUser: UIView = {
        let view = UIView()
        view.backgroundColor = .colorButtonIsActive
        view.layer.cornerRadius = 30
        
        view.addSubview(viewUserImage)
        view.addSubview(labelNameUser)
        
        return view
    }()
    
    private lazy var viewUserImage: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 70
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 6
        
        view.addSubview(imageUser)
        
        return view
    }()
    
    private lazy var imageUser: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "Avatar2")
        image.layer.cornerRadius = 70
        
        return image
    }()
    
    private lazy var labelNameUser: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    private lazy var buttonUIImagePickerController: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "Edit"), for: .normal)
        button.addTarget(self, action: #selector(tapButtonUIImagePickerController), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func tapButtonUIImagePickerController() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.addSubview(viewUser)
        createConstrainsViewUser()
        
        createConstrainsViewUserImage()
        createConstrainsUserImage()
        createConstrainsLabelNameUser()
        
        view.addSubview(buttonUIImagePickerController)
        createConstrainsButtonUIImagePickerController()
        
        if let saveData = UserDefaults.standard.string(forKey: "user") {
            labelNameUser.text = "\(saveData)"
        } else {
            labelNameUser.text = "Error"
        }
        
        if let savedImage = UserDefaultsManager.shared.getImage() {
            imageUser.image = savedImage
        }
    }
}

private extension AboutViewController {
    
    func createConstrainsViewUser() {
        viewUser.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewUser.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewUser.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewUser.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            viewUser.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    func createConstrainsViewUserImage() {
        viewUserImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewUserImage.topAnchor.constraint(equalTo: viewUser.topAnchor, constant: 35),
            viewUserImage.trailingAnchor.constraint(equalTo: viewUser.trailingAnchor, constant: -95),
            viewUserImage.leadingAnchor.constraint(equalTo: viewUser.leadingAnchor, constant: 95),
            
            viewUserImage.heightAnchor.constraint(equalToConstant: 143)
        ])
    }
    
    func createConstrainsUserImage() {
        imageUser.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageUser.topAnchor.constraint(equalTo: viewUserImage.topAnchor),
            imageUser.trailingAnchor.constraint(equalTo: viewUserImage.trailingAnchor),
            imageUser.leadingAnchor.constraint(equalTo: viewUserImage.leadingAnchor),
            imageUser.bottomAnchor.constraint(equalTo: viewUserImage.bottomAnchor)
            
            //imageUser.heightAnchor.constraint(equalToConstant: 50),
            //imageUser.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func createConstrainsLabelNameUser() {
        labelNameUser.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelNameUser.topAnchor.constraint(equalTo: viewUserImage.bottomAnchor, constant: 10),
            labelNameUser.trailingAnchor.constraint(equalTo: viewUser.trailingAnchor, constant: -10),
            labelNameUser.bottomAnchor.constraint(equalTo: viewUser.bottomAnchor, constant: -10),
            labelNameUser.leadingAnchor.constraint(equalTo: viewUser.leadingAnchor, constant: 10),
        ])
    }
    
    func createConstrainsButtonUIImagePickerController() {
        buttonUIImagePickerController.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonUIImagePickerController.topAnchor.constraint(equalTo: viewUser.topAnchor, constant: 30),
            buttonUIImagePickerController.trailingAnchor.constraint(equalTo: viewUser.trailingAnchor, constant: -100),
            
            buttonUIImagePickerController.heightAnchor.constraint(equalToConstant: 30),
            buttonUIImagePickerController.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
}

extension AboutViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            imageUser.image = editedImage
            UserDefaultsManager.shared.saveImage(editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            imageUser.image = originalImage
            UserDefaultsManager.shared.saveImage(originalImage)
        }
        picker.dismiss(animated: true)
    }
}

#Preview {
    AboutViewController()
}
