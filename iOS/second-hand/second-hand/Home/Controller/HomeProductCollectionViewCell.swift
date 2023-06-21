//
//  HomeProducCollectionViewCell.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/20.
//

import UIKit

class HomeProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "productCell"
    let imageView = UIImageView()
    var title = UILabel()
    let location = UILabel()
    let dot = UILabel()
    let registerTime = UILabel()
    let statusLabel = UILabel()
    let price = UILabel()
    let chat = UILabel()
    let wish = UILabel()
    let line = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setImageView()
        setTitle()
        setLocation()
        setDot()
        setRegisterTime()
        setStatusLabel()
        setPrice()
    }
    
    private func setImageView() {
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = .init(red: 179/255, green: 179/255, blue: 179/255, alpha: 0.39)
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
    }
    
    private func setTitle() {
        title.font = .subHead
        title.textColor = .neutralText
    }
    
    private func setLocation() {
        location.font = .footNote
        location.textColor = .neutralTextWeak
    }
    
    private func setDot() {
        dot.text = " ・ "
        dot.font = .footNote
        dot.textColor = .neutralTextWeak
    }
    
    private func setRegisterTime() {
        registerTime.font = .footNote
        registerTime.textColor = .neutralTextWeak
    }
    
    private func setStatusLabel() {
        statusLabel.text = "예약중"
        statusLabel.textAlignment = .center
        statusLabel.font = .caption1
        statusLabel.textColor = .accentText
        statusLabel.backgroundColor = .accentBackgroundSecondary
        statusLabel.layer.masksToBounds = true
        statusLabel.layer.cornerRadius = 8
    }
    
    private func setPrice() {
            price.text = "24,000원"
            price.font = .headLine
            price.textColor = .neutralTextStrong
        }
    
    func layout() {
        [imageView, title, location, dot, registerTime, statusLabel, price, chat, wish, line].forEach{
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let height: CGFloat = self.frame.height
        let width: CGFloat = self.frame.width
        let figmaHeight: CGFloat = 152
        let figmaWidth: CGFloat = 393
        let heightRatio: CGFloat = height/figmaHeight
        let widthRatio: CGFloat = width/figmaWidth
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            imageView.widthAnchor.constraint(equalToConstant: height-32),
            
            title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15*widthRatio),
            title.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 4*heightRatio),
            
            location.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            location.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4*heightRatio),
            
            dot.leadingAnchor.constraint(equalTo: location.trailingAnchor),
            dot.topAnchor.constraint(equalTo: location.topAnchor),
            
            registerTime.leadingAnchor.constraint(equalTo: dot.trailingAnchor),
            registerTime.topAnchor.constraint(equalTo: dot.topAnchor),
            
            statusLabel.leadingAnchor.constraint(equalTo: location.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 4*heightRatio),
            //TODO: 여기 22를 해야지 프라이스랑 높이가 같음...
            statusLabel.heightAnchor.constraint(equalToConstant: 22),
            statusLabel.widthAnchor.constraint(equalToConstant: 50*widthRatio),
            
            price.topAnchor.constraint(equalTo: statusLabel.topAnchor),
                       price.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: 4*widthRatio),

        ])
    }
}

