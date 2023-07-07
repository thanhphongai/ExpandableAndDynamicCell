//
//  DetailCell.swift
//  CustomCellExpandTbv
//
//  Created by macbookpro on 06/07/2023.
//

import UIKit

class DetailCell: UITableViewCell {
    
    let image: UIImageView = {
        let imv = UIImageView()
        return imv
    }()
    
    let lbName: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 20, weight: .regular)
        return lb
    }()
    
    let lbDetail: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 16, weight: .regular)
        lb.numberOfLines = 0
        return lb
    }()
    
    var model: Model? = nil {
        didSet{
            image.image = model?.image
            lbName.text = model?.name
            lbDetail.text = model?.details
        }
    }
    
    var expanded = false {
        didSet {
            if (expanded) {
                NSLayoutConstraint.deactivate(constraintsForCollap)
                NSLayoutConstraint.activate(constraintsForExpanded)
            } else {
                NSLayoutConstraint.deactivate(constraintsForExpanded)
                NSLayoutConstraint.activate(constraintsForCollap)
            }
            
            lbDetail.alpha = expanded ? 1 : 0
            contentView.layoutIfNeeded()
        }
    }
    
    private var constraintsForCollap : [NSLayoutConstraint] = []
    private var constraintsForExpanded : [NSLayoutConstraint] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        placeContent(in: contentView)
        configureContent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func constraintsForCollapsedContent(in view: UIView) -> [NSLayoutConstraint] {
        let profileImageBottomConstraint = image.bottomAnchor.constraint(
            equalTo: view.bottomAnchor, constant: -8
        )
        profileImageBottomConstraint.priority = .defaultHigh

        return [
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            profileImageBottomConstraint,
            image.widthAnchor.constraint(equalTo: image.heightAnchor),
            image.heightAnchor.constraint(equalToConstant: 40),

            lbName.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            lbName.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            lbName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            lbName.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            lbName.centerYAnchor.constraint(equalTo: image.centerYAnchor),

            lbDetail.topAnchor.constraint(equalTo: lbName.bottomAnchor, constant: 32),
            lbDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100 + 2 * 8),
            lbDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ]
    }
    
    private func constraintsForExpandedContent(in view: UIView) -> [NSLayoutConstraint] {
        let profileImageBottomConstraint = image.bottomAnchor.constraint(
            lessThanOrEqualTo: contentView.bottomAnchor, constant: -8
        )
        profileImageBottomConstraint.priority = .defaultHigh

        let detailsBottomConstraint = lbName.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor, constant: -8
        )
        detailsBottomConstraint.priority = .defaultHigh

        return [
            lbName.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            lbName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            lbName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),

            image.topAnchor.constraint(equalTo: lbName.bottomAnchor, constant: 8),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            profileImageBottomConstraint,
            image.widthAnchor.constraint(equalTo: image.heightAnchor),
            image.heightAnchor.constraint(equalToConstant: 50),

            lbDetail.topAnchor.constraint(equalTo: lbName.bottomAnchor, constant: 8),
            lbDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100 + 2 * 8),
            lbDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            detailsBottomConstraint
        ]
    }
    
    private func placeContent(in view: UIView) {
        view.addSubview(image)
        view.addSubview(lbName)
        view.addSubview(lbDetail)

        image.translatesAutoresizingMaskIntoConstraints = false
        lbName.translatesAutoresizingMaskIntoConstraints = false
        lbDetail.translatesAutoresizingMaskIntoConstraints = false

        lbName.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

        constraintsForCollap = constraintsForCollapsedContent(in: view)
        constraintsForExpanded = constraintsForExpandedContent(in: view)

        NSLayoutConstraint.activate(constraintsForCollap)

        lbDetail.alpha = 0
    }
    
    private func configureContent() {
        selectionStyle = .none
        contentView.clipsToBounds = true
    }
}
