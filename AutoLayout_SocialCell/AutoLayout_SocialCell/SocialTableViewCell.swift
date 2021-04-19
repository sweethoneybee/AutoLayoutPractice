//
//  SocialTableViewCell.swift
//  AutoLayout_SocialCell
//
//  Created by 정성훈 on 2021/04/18.
//

import UIKit

class SocialTableViewCell: UITableViewCell {
    
    var feed: Feed! {
        didSet {
            profileImageView?.image = feed.author.profileImage
            nameLabel?.text = feed.author.name
            uploadTimeLabel?.text = feed.time
            bodyTextLabel?.text = feed.contents.text
            bodyImageView?.image = feed.contents.image
            likeCountLabel?.text = "\(feed.likes)"
            
            bodyTextLabel?.isHidden = bodyTextLabel?.text?.isEmpty == true
            bodyImageView?.isHidden = bodyImageView?.image == nil
            
        }
    }
    
    private var profileImageView: UIImageView!
    private var nameLabel: UILabel!
    private var uploadTimeLabel: UILabel!
    private var bodyTextLabel: UILabel!
    private var bodyImageView: UIImageView!
    private var likeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setUI()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
 
    private func setUI() {
        selectionStyle = .none
        
        // profile line
        profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFit
         
        nameLabel = UILabel()
        nameLabel.font = .preferredFont(forTextStyle: .caption1)
        nameLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(.required, for: .vertical) // 중요한 내용이니 보존하는 역할로
        
        uploadTimeLabel = UILabel()
        uploadTimeLabel.font = .preferredFont(forTextStyle: .caption2)
        uploadTimeLabel.setContentHuggingPriority(.init(1), for: .horizontal)
        uploadTimeLabel.textAlignment = .left
        
        let profileStack = UIStackView(arrangedSubviews: [profileImageView, nameLabel, uploadTimeLabel])
        profileStack.axis = .horizontal
        profileStack.alignment = .center
        profileStack.spacing = 5
        
        // body
        bodyTextLabel = UILabel()
        bodyTextLabel.font = .preferredFont(forTextStyle: .body)
        bodyTextLabel.numberOfLines = 0
        bodyTextLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        bodyImageView = UIImageView()
        bodyImageView.clipsToBounds = true
        bodyImageView.contentMode = .scaleAspectFill
        bodyImageView.isUserInteractionEnabled = true
        
        // footer
        let thumbsUpImageView: UIImageView = { imageView in
            imageView.image = UIImage(systemName: "hand.thumbsup.fill")
            
            return imageView
        } (UIImageView())
        
        likeCountLabel = { label in
            label.font = .preferredFont(forTextStyle: .callout)
            label.setContentHuggingPriority(.defaultLow, for: .horizontal)
            label.text = "0개"
            
            return label
        } (UILabel())
        
        let likeStackView: UIStackView = { stack in
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.alignment = .center
            stack.spacing = UIStackView.spacingUseSystem
            
            return stack
        } (UIStackView(arrangedSubviews: [thumbsUpImageView, likeCountLabel]))
        
        let buttonStackView: UIStackView = { stack in
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.alignment = .fill
            
            let buttonTitles = ["좋아요", "댓글 달기", "공유하기"]
            buttonTitles.forEach { title in
                let button = UIButton(type: .system)
                button.setTitle(title, for: .normal)
                button.setTitleColor(.darkGray, for: .normal)
                button.layer.borderColor = UIColor.darkGray.cgColor
                button.layer.borderWidth = 1
                
                stack.addArrangedSubview(button)
            }
            
            return stack
        } (UIStackView())
        
        // Whole Stack View
        let stackView = UIStackView(arrangedSubviews: [profileStack, bodyTextLabel, bodyImageView, likeStackView, buttonStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            profileImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1),
            bodyImageView.widthAnchor.constraint(equalTo: bodyImageView.heightAnchor),
        ])
        
        thumbsUpImageView.widthAnchor.constraint(equalTo: thumbsUpImageView.heightAnchor).isActive = true
        thumbsUpImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        let thumbsUpHeight = thumbsUpImageView.heightAnchor.constraint(lessThanOrEqualTo: likeCountLabel.heightAnchor)
        thumbsUpHeight.priority = .defaultHigh
        thumbsUpHeight.isActive = true
    }
}
