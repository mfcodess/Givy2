//
//  CustomStepper.swift
//  Givy
//
//  Created by Max on 03.08.2024.
//

import UIKit

protocol CustomButtonDelegate: AnyObject {
    func tap(value: Int)
}

class CustomStepper: UIControl {
    
    weak var delegate: CustomButtonDelegate?
    
    var currentValue = 1 {
        didSet {
            delegate?.tap(value: currentValue)
            currentValue = currentValue >= 1 ? currentValue : 0
            currentStepValueLabel.text = "\(currentValue)"
        }
    }

    private lazy var decrementButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var currentStepValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "\(currentValue)"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackViewStepper: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 15
        stackView.backgroundColor = .colorGray
        
        stackView.addArrangedSubview(decrementButton)
        stackView.addArrangedSubview(currentStepValueLabel)
        stackView.addArrangedSubview(incrementButton)
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stackViewStepperConstrains()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("Error")
    }
    
    private func stackViewStepperConstrains() {
        addSubview(stackViewStepper)
        stackViewStepper.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackViewStepper.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewStepper.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackViewStepper.topAnchor.constraint(equalTo: topAnchor),
            stackViewStepper.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc func tapButton(sender: UIButton) {
        switch sender {
        case decrementButton:
            if currentValue == 0 {
                print("Stop")
                return 
            }
            currentValue -= 1
        case incrementButton:
            currentValue += 1
        default:
            break
        }
    }
}

#Preview {
    CustomStepper()
}

