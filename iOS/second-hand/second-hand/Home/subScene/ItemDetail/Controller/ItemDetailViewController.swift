//
//  ItemDetailViewController.swift
//  second-hand
//
//  Created by SONG on 2023/07/09.
//

import UIKit

class ItemDetailViewController: UIViewController {
    private var backButton: UIButton? = nil
    private var menuButton: UIButton? = nil
    private var itemDetailURL: URL? = nil
    private var itemDetailModel = ItemDetailModel()
    private var imageSectionView: ItemDetailImageSectionView!
    
    private lazy var textSectionView = ItemDetailTextSectionView(frame: .zero)
    
    private var sellerInfoView: SellerInfoView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItemDetailModel()
        initializeScene()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bringButtonsToFront()
    }
    
    private func bringButtonsToFront() {
        guard let backButton = self.backButton else {
            return
        }
        
        guard let menuButton = self.menuButton else {
            return
        }
        
        self.view.bringSubviewToFront(backButton)
        self.view.bringSubviewToFront(menuButton)
    }
    
    private func initializeScene() {
        self.view.backgroundColor = .white
        hideNavigationBar()
        generateBackButton()
        generateMenuButton()
        setConstraintsBackButton()
        setConstraintsMenuButton()
        setTextSectionViewConstraints()
    }
    
    func setItemDetailURL(_ url : String) {
        self.itemDetailURL = URL(string: url)
    }
    
    private func setItemDetailImagesURLToView() {
        guard let info = itemDetailModel.info else {
            return
        }
        var imageURLS : [String] = []
        for item in info.images {
            imageURLS.append(item.url)
        }
        imageSectionView = ItemDetailImageSectionView(images: imageURLS)
    }
    
    private func setItemDetailModel() {
        guard let url = self.itemDetailURL else {
            return
        }
        
        NetworkManager.sendGET(decodeType: ItemDetailInfoSuccess.self, what: nil, fromURL: url) { (result: Result<[ItemDetailInfoSuccess], Error>) in
            switch result {
            case .success(let data) :
                guard let detailInfo = data.last else {
                    return
                }
                self.itemDetailModel.updateData(from: detailInfo.data)
                self.setImageSection()
                
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    // MARK: BUTTONS
    
    private func generateBackButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonTouched), for: .touchUpInside)
        self.backButton = button
    }
    
    private func generateMenuButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action:#selector(menuButtonTouched), for: .touchUpInside)
        self.menuButton = button
        
    }
    
    private func setConstraintsBackButton() {
        guard let backButton = self.backButton else {
            return
        }
        
        self.view.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
    }
    
    private func setConstraintsMenuButton() {
        guard let menubutton = self.menuButton else {
            return
        }
        
        self.view.addSubview(menubutton)
        
        menubutton.translatesAutoresizingMaskIntoConstraints = false
        
        menubutton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        menubutton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
    }
    
    private func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc private func backButtonTouched() {
        navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc private func menuButtonTouched() {
        
    }
    
    // MARK: IMAGE SECTION
    
    private func setImageSection() {
        setItemDetailImagesURLToView()
        setConstraintsImageSection()
    }
    
    private func setConstraintsImageSection() {
        self.view.addSubview(imageSectionView)
        
        imageSectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                imageSectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
                imageSectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                imageSectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5),
                imageSectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ]
        )
    }
    
    //MARK: TEXT SECTION
    private func setTextSectionView() {
        
        setTextSectionViewConstraints()
    }
    
    private func setTextSectionViewConstraints() {
        
        self.view.addSubview(textSectionView)
        
        textSectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                textSectionView.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 5.0),
                textSectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -40),
                textSectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                textSectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ]
        )
    }
    
    

}
