//
//  EditProfileInfoViewController.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 09.11.2024.
//

import UIKit
import Kingfisher
import ProgressHUD

final class EditProfileInfoViewController: UIViewController, EditProfileViewProtocol {
    // MARK: - Private Properties
    private var presenter: EditProfilePresenter?
    
    private lazy var closeEditVCButton: UIButton = {
        let button = UIButton(type: .system)
        let closeIcon = UIImage(named: "close")
        button.setImage(closeIcon, for: .normal)
        button.tintColor = UIColor(resource: .nftBlack)
        button.addTarget(self, action: #selector(closeEditVCButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var editIconButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "mockPhotoIcon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = true
        button.layer.cornerRadius = 35
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editIconButtonTapped), for: .touchUpInside)
        
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        overlayView.isUserInteractionEnabled = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(overlayView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Сменить \nфото"
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textColor = UIColor(resource: .nftWhiteUni)
        titleLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: button.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
        ])
        return button
    }()
    
    private lazy var nameTitle: UILabel = {
        var nameTitle = UILabel()
        nameTitle.text = NSLocalizedString("editNameTitle", comment: "")
        nameTitle.font = .headline3
        nameTitle.textColor = UIColor(resource: .nftBlack)
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
        return nameTitle
    }()
    
    private lazy var textFieldForName: UITextField = {
        var textField = UITextField()
        textField.text = "User Name"
        textField.font = .bodyRegular
        textField.textColor = UIColor(resource: .nftBlack)
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(resource: .nftLightGrey)
        textField.layer.cornerRadius = 12
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 343).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTitle, textFieldForName])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var bioTitle: UILabel = {
        var bioTitle = UILabel()
        bioTitle.text = NSLocalizedString("editBioTitle", comment: "")
        bioTitle.font = .headline3
        bioTitle.textColor = UIColor(resource: .nftBlack)
        bioTitle.translatesAutoresizingMaskIntoConstraints = false
        return bioTitle
    }()
    
    private lazy var textViewForBio: UITextView = {
        let textView = UITextView()
        textView.text = "Big text in future,"
        textView.font = .systemFont(ofSize: 17)
        textView.textColor = UIColor(resource: .nftBlack)
        textView.backgroundColor = UIColor(resource: .nftLightGrey)
        textView.layer.cornerRadius = 12
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.widthAnchor.constraint(equalToConstant: 343).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 132).isActive = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        textView.isScrollEnabled = false
        return textView
    }()
    
    private lazy var bioStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bioTitle, textViewForBio])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var siteTitle: UILabel = {
        var siteTitle = UILabel()
        siteTitle.text = NSLocalizedString("editSiteTitle", comment: "")
        siteTitle.font = .headline3
        siteTitle.textColor = UIColor(resource: .nftBlack)
        siteTitle.translatesAutoresizingMaskIntoConstraints = false
        return siteTitle
    }()
    
    private lazy var textFieldForSite: UITextField = {
        var textField = UITextField()
        textField.text = "UserName.com"
        textField.font = .bodyRegular
        textField.textColor = UIColor(resource: .nftBlack)
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(resource: .nftLightGrey)
        textField.layer.cornerRadius = 12
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 343).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var siteStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [siteTitle, textFieldForSite])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var textFieldForAvatar: UITextField = {
        var textField = UITextField()
        textField.isHidden = true
        textField.placeholder = "Загрузить изображение"
        textField.font = .bodyRegular
        textField.textColor = UIColor(resource: .nftBlack)
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(resource: .nftLightGrey)
        textField.layer.cornerRadius = 12
        textField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    // MARK: - Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        presenter = EditProfilePresenter(view: self)
        presenter?.loadProfileData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Setup Methods
    private func setupVC(){
        view.backgroundColor = UIColor(resource: .nftWhite)
        addSubviews()
        addConstraints()
        addDoneButtonOnKeyboard()
    }
    
    private func addSubviews(){
        [closeEditVCButton, editIconButton, nameStackView, bioStackView, siteStackView, textFieldForAvatar].forEach { view.addSubview($0) }
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            closeEditVCButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            closeEditVCButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            editIconButton.widthAnchor.constraint(equalToConstant: 70),
            editIconButton.heightAnchor.constraint(equalToConstant: 70),
            editIconButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            editIconButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 174),
            nameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            bioStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 24),
            bioStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bioStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            siteStackView.topAnchor.constraint(equalTo: bioStackView.bottomAnchor, constant: 24),
            siteStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            siteStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textFieldForAvatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldForAvatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            textFieldForAvatar.heightAnchor.constraint(equalToConstant: 44),
            textFieldForAvatar.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func loadProfileData(profile: Profile) {
        self.textFieldForName.text = profile.name
        self.textViewForBio.text = profile.description
        self.textFieldForSite.text = profile.website
        if let avatarUrlString = profile.avatar, let url = URL(string: avatarUrlString) {
            self.editIconButton.kf.setImage(with: url, for: .normal)
        }
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // MARK: - Private methods
    private func addDoneButtonOnKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonTapped))
        doneButton.tintColor = UIColor(resource: .nftBlue)
        
        toolbar.items = [flexSpace, doneButton]
        
        textFieldForName.inputAccessoryView = toolbar
        textViewForBio.inputAccessoryView = toolbar
        textFieldForSite.inputAccessoryView = toolbar
    }
    
    @objc
    private func doneButtonTapped() {
        view.endEditing(true)
    }
    
    @objc
    private func closeEditVCButtonTapped() {
        ProgressHUD.show("Сохранение...")
        presenter?.updateProfileData(
            name: textFieldForName.text ?? "",
            description: textViewForBio.text,
            website: textFieldForSite.text ?? "",
            completion: { [weak self] success in
                DispatchQueue.main.async {
                    ProgressHUD.dismiss()
                    if success {
                        self?.dismiss(animated: true)
                    } else {
                        ProgressHUD.showError("Ошибка обновления профиля")
                    }
                }
            }
        )
    }
    
    @objc
    private func editIconButtonTapped(){
        textFieldForAvatar.isHidden = false
    }
    
    @objc
    private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height
        let bottomOfTextField = siteStackView.frame.origin.y + siteStackView.frame.height
        let screenHeight = view.frame.height
        let overlap = bottomOfTextField - (screenHeight - keyboardHeight)
        
        if overlap > 0 {
            self.view.frame.origin.y = -overlap - 16
        }
    }
    
    @objc
    private func keyboardWillHide(notification: Notification) {
        self.view.frame.origin.y = 0
    }
}
