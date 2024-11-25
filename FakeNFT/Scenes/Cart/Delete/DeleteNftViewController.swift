//
//  DeleteNftViewController.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 17.11.2024.
//

import UIKit

protocol DeleteNftViewProtocol: AnyObject {
    var presenter: DeleteNftPresenterProtocol { get set }
    func dismissView()
}

final class DeleteNftViewController: UIViewController, DeleteNftViewProtocol {
    
    // MARK: - Properties
    
    var presenter: DeleteNftPresenterProtocol
    
    // MARK: - View
    
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let confirmationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.text = NSLocalizedString("Cart.deleteNftConfirmation", comment: "")
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Cart.delete", comment: ""), for: .normal)
        button.setTitleColor(.nftRedUni, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.backgroundColor = .nftBlack
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()
    
    private let returnButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Cart.return", comment: ""), for: .normal)
        button.setTitleColor(.nftWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.backgroundColor = .nftBlack
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()
    
    // MARK: - Init
    
    init(presenter: DeleteNftPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfe-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Public Methods
    
    func dismissView() {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        blurEffectView.frame = view.bounds
        
        [blurEffectView, imageView, confirmationLabel, buttonsStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [deleteButton, returnButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            buttonsStack.addArrangedSubview($0)
        }
        
        let imageUrl = presenter.getImage()
        imageView.kf.setImage(with: imageUrl)
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        returnButton.addTarget(self, action: #selector(returnButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: confirmationLabel.topAnchor, constant: -12),
            imageView.heightAnchor.constraint(equalToConstant: 108),
            imageView.widthAnchor.constraint(equalToConstant: 108),
            
            confirmationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            buttonsStack.topAnchor.constraint(equalTo: confirmationLabel.bottomAnchor, constant: 20),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 56),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -56),
            
            deleteButton.heightAnchor.constraint(equalToConstant: 44),
            returnButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    @objc private func deleteButtonTapped() {
        presenter.deleteNft()
    }
    
    @objc private func returnButtonTapped() {
        dismissView()
    }
}
