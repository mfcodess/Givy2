//
//  CollectionViews.swift
//  Givy
//
//  Created by Max on 18.07.2024.
//


import UIKit
import FirebaseAuth

protocol RegistrationView: AnyObject {
    func clearTextFields()
}

class RegistrationViewController: UIViewController {
    
    ///Logo Givy
    private lazy var imageGivy = createImageGivy()
    
    ///StackViewLogoAndTitle
    private lazy var stackViewLogo = createStackViewLogoAndTitle()
    
    ///Title Email
    private lazy var titleEmail = createTitleEmail()
    
    ///TextField Email
    private lazy var textFieldEmail = createTextFieldEmail()
    
    ///Title Password
    private lazy var titlePassword = createTitlePassword()
    
    ///TextField Password
    private lazy var textFieldPassword = createTextFieldPassword()
    
    ///Continue Button
    private lazy var continueButton = createContinueButton()
    
    ///StackView Email TextField and Password TextField
    private lazy var stackViewEmailTextFieldAndPasswordTextField = createStackViewEmailTextFieldAndPasswordTextField()
    
    ///StackView Email TextField and Password TextField Button
    private lazy var stackViewEmailTextFieldAndPasswordTextFieldAndButton = createStackViewEmailTextFieldAndPasswordTextFieldAndButton()
    
    ///UIView Or -
    private lazy var viewOrOne = createOneView()
    
    ///Title Or
    private lazy var titleOr = createTitleOr()
    
    ///UIView Or -
    private lazy var viewOrTwo = createTwoView()
    
    ///StackView ViewOne, TitleOr, ViewTwo
    private lazy var stackViewViewOneTitleOrViewTwo = createStackViewViewOneTitleOrViewTwo()
    
    ///Google Button
    private lazy var googleButton = createGoogleButton()
    
    ///Apple Button
    private lazy var appleButton = createAppleButton()
    
    ///StackView ViewOne, TitleOr, ViewTwo, ButtonApple, Button Google
    private lazy var stackViewViewOneAndTitleOrAndViewTwoAndAppleButtonAndGoogleButton = createStackViewViewOneAndTitleOrAndViewTwoAndAppleButtonAndGoogleButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(stackViewLogo)
        createStackViewLogoConstrains()
        
        view.addSubview(stackViewEmailTextFieldAndPasswordTextFieldAndButton)
        createStackViewEmailTextFieldAndPasswordTextFieldAndButtonConstrains()
        
        view.addSubview(stackViewViewOneAndTitleOrAndViewTwoAndAppleButtonAndGoogleButton)
        createStackViewViewOneAndTitleOrAndViewTwoAndAppleButtonAndGoogleButtonConstrains()
        
        continueButton.addTarget(self, action: #selector(tapContinueButton), for: .touchUpInside)
        
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        
        textFieldPassword.addTarget(self, action: #selector(tapContinueButtonDidChangeSelected), for: .editingChanged)
    }
    
    @objc func tapContinueButton() {
        
        let user = textFieldEmail.text
        UserDefaults.standard.set(user, forKey: "user")
        
        if let user = textFieldEmail.text {
            UserDefaultsManager.shared.saveEmail(user)
        }
        
        guard let email = textFieldEmail.text, !email.isEmpty,
              let password = textFieldPassword.text, !password.isEmpty else {
            let alert = UIAlertController(title: "Create Account❌", message: "Email and password cannot be empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                let alert = UIAlertController(title: "Login Failed", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                strongSelf.present(alert, animated: true)
                return
            }
            
            result?.user.sendEmailVerification()
            print("Ты создал Юзера и он сохранил на Firebase")
            
            // let model = LoginModel(email: email, password: password)
            
            let alert = UIAlertController(title: "Registration successful!", message: "Welcome: \(email)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                let aboutVC = AboutViewController()
                aboutVC.modalPresentationStyle = .fullScreen
                
                // Проверяем, существует ли navigationController и используем его
                if let navigationController = strongSelf.navigationController {
                    navigationController.pushViewController(aboutVC, animated: true)
                } else {
                    let navigationController = UINavigationController(rootViewController: aboutVC)
                    navigationController.modalPresentationStyle = .fullScreen
                    strongSelf.present(navigationController, animated: true)
                }
            }))
            strongSelf.present(alert, animated: true)
        }
    }
    
    @objc func tapContinueButtonDidChangeSelected() {
        textFieldDidChangeSelection()
    }
}

private extension RegistrationViewController  {
    
    ///Create Image Givy
    func createImageGivy() -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(named: "GroupLogoRegistration")
        image.contentMode = .scaleAspectFit
        
        return image
    }
    
    ///Create StackView Logo And Title
    func createStackViewLogoAndTitle() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        
        stackView.addArrangedSubview(imageGivy)
        
        return stackView
    }
    
    ///Create StackView Logo And Title Constrains
    func createStackViewLogoConstrains() {
        stackViewLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackViewLogo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackViewLogo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            imageGivy.widthAnchor.constraint(equalToConstant: 90),
            imageGivy.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    
    ///Create Title Email
    func createTitleEmail() -> UILabel {
        let title = UILabel()
        title.text = "Email"
        title.textColor = .black
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 16)
        
        return title
    }
    
    ///Create TextField Email
    func createTextFieldEmail() -> UITextField {
        let attributedText = NSMutableAttributedString(string: "Please enter your email")
        attributedText.setTextColor(color: .gray, toSubstring: "Please enter your email")
        
        let textField = UITextField()
        textField.attributedPlaceholder = attributedText
        textField.borderStyle = .none
        textField.textColor = .black
        textField.backgroundColor = .colorTextField
        textField.font = .systemFont(ofSize: 13)
        textField.layer.cornerRadius = 15
        
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = padding
        textField.leftViewMode = .always
        
        return textField
    }
    
    ///Create Title Password
    func createTitlePassword() -> UILabel {
        let title = UILabel()
        title.text = "Password"
        title.textColor = .black
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 16)
        
        return title
    }
    
    ///Create TextField Password
    func createTextFieldPassword() -> UITextField {
        let attributedText = NSMutableAttributedString(string: "Please enter your password")
        attributedText.setTextColor(color: .gray, toSubstring: "Please enter your password")
        
        let textField = UITextField()
        textField.attributedPlaceholder = attributedText
        textField.borderStyle = .none
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 13)
        textField.backgroundColor = .colorTextField
        textField.layer.cornerRadius = 15
        textField.isSecureTextEntry = true
        
        
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = padding
        textField.leftViewMode = .always
        
        ///Create Button Toggle
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        //Create View Right
        let rightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        rightViewContainer.addSubview(button)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        textField.rightView = rightViewContainer
        textField.rightViewMode = .always
        
        return textField
    }
    @objc func buttonAction(sender: UIButton) {
        textFieldPassword.isSecureTextEntry.toggle()
        
        let imageName = textFieldPassword.isSecureTextEntry ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    ///Create StackView Email TextField And Password TextField
    func createStackViewEmailTextFieldAndPasswordTextField() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        
        stackView.addArrangedSubview(titleEmail)
        stackView.addArrangedSubview(textFieldEmail)
        
        stackView.addArrangedSubview(titlePassword)
        stackView.addArrangedSubview(textFieldPassword)
        
        return stackView
    }
    
    ///Create Continue Button
    func createContinueButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .colorButtonIsNotActive
        button.layer.cornerRadius = 15
        
        return button
    }
    
    ///Create StackView Email TextField And Password TextField And Button
    func createStackViewEmailTextFieldAndPasswordTextFieldAndButton() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 35
        
        stackView.addArrangedSubview(stackViewEmailTextFieldAndPasswordTextField)
        stackView.addArrangedSubview(continueButton)
        
        return stackView
    }
    
    ///Create StackView Email TextField And Password TextField And Button Constrains
    func createStackViewEmailTextFieldAndPasswordTextFieldAndButtonConstrains() {
        stackViewEmailTextFieldAndPasswordTextFieldAndButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewEmailTextFieldAndPasswordTextFieldAndButton.topAnchor.constraint(equalTo: imageGivy.bottomAnchor, constant: 60),
            stackViewEmailTextFieldAndPasswordTextFieldAndButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackViewEmailTextFieldAndPasswordTextFieldAndButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            textFieldEmail.heightAnchor.constraint(equalToConstant: 50),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 50),
            continueButton.heightAnchor.constraint(equalToConstant: 53)
        ])
    }
    
    ///Create OneView
    func createOneView() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 1),
            view.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        return view
    }
    
    ///Create TwoView
    func createTwoView() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 1),
            view.widthAnchor.constraint(equalToConstant: 150),
        ])
        
        return view
    }
    
    ///Create Title Or
    func createTitleOr() -> UILabel {
        let title = UILabel()
        title.text = "Or"
        title.font = UIFont.systemFont(ofSize: 13)
        title.textColor = .gray
        title.textAlignment = .center
        
        return title
    }
    
    ///Create StackView ViewOne TitleOr ViewTwo
    func createStackViewViewOneTitleOrViewTwo() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        //stackView.backgroundColor = .blue
        
        stackView.addArrangedSubview(viewOrOne)
        stackView.addArrangedSubview(titleOr)
        stackView.addArrangedSubview(viewOrTwo)
        
        return stackView
    }
    
    ///Create Google Button
    func createGoogleButton() -> UIButton {
        let button = UIButton()
        
        let attachmentImageGoogle = NSTextAttachment()
        attachmentImageGoogle.image = UIImage(named: "GoogleLogo")
        
        let imageSize = CGSize(width: 20, height: 20)
        attachmentImageGoogle.bounds = CGRect(origin: CGPoint(x: 0, y: -5), size: imageSize)
        
        let attachmentString = NSAttributedString(attachment: attachmentImageGoogle)
        let text = NSMutableAttributedString(attributedString: attachmentString)
        text.append(NSAttributedString(string: " Sign Up With Google"))
        
        button.setAttributedTitle(text, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 15
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        return button
    }
    
    ///Create Apple Button
    func createAppleButton() -> UIButton {
        let button = UIButton()
        
        let attachmentImageApple = NSTextAttachment()
        attachmentImageApple.image = UIImage(named: "AppleLogo")
        
        let imageSize = CGSize(width: 20, height: 20)
        attachmentImageApple.bounds = CGRect(origin: CGPoint(x: 0, y: -5), size: imageSize) // Выравнивание иконки
        let attachmentString = NSAttributedString(attachment: attachmentImageApple)
        let text = NSMutableAttributedString(attributedString: attachmentString)
        text.append(NSAttributedString(string: " Sign Up With Apple"))
        
        button.setAttributedTitle(text, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        return button
    }
    
    ///Create StackView ViewOne And TitleOr And ViewTwo And AppleButton And GoogleButton
    func createStackViewViewOneAndTitleOrAndViewTwoAndAppleButtonAndGoogleButton() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        //stackView.backgroundColor = .yellow
        stackView.spacing = 20
        
        stackView.addArrangedSubview(stackViewViewOneTitleOrViewTwo)
        stackView.addArrangedSubview(createGoogleButton())
        stackView.addArrangedSubview(createAppleButton())
        
        return stackView
    }
    
    ///Create StackView ViewOne And TitleOr And ViewTwo And AppleButton And GoogleButton Constrains
    func createStackViewViewOneAndTitleOrAndViewTwoAndAppleButtonAndGoogleButtonConstrains() {
        stackViewViewOneAndTitleOrAndViewTwoAndAppleButtonAndGoogleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewViewOneAndTitleOrAndViewTwoAndAppleButtonAndGoogleButton.topAnchor.constraint(equalTo: stackViewEmailTextFieldAndPasswordTextFieldAndButton.bottomAnchor, constant: 10),
            stackViewViewOneAndTitleOrAndViewTwoAndAppleButtonAndGoogleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackViewViewOneAndTitleOrAndViewTwoAndAppleButtonAndGoogleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewViewOneAndTitleOrAndViewTwoAndAppleButtonAndGoogleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130),
            
            stackViewViewOneTitleOrViewTwo.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}

//MARK: RegistrationViewController
extension RegistrationViewController: RegistrationView {
    func clearTextFields() {
        textFieldEmail.text = nil
        textFieldPassword.text = nil
        continueButton.backgroundColor = .colorButtonIsNotActive
    }
}

//MARK:  TextFieldEmail ChangeColor
extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection() {
        if let email = textFieldEmail.text, !email.isEmpty,
           let password = textFieldPassword.text, !password.isEmpty {
            continueButton.backgroundColor = .colorButtonIsActive
        } else {
            continueButton.backgroundColor = .colorButtonIsNotActive
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

#Preview {
    RegistrationViewController ()
}

