//
//  ToDoTableViewCell.swift
//  ToDo
//
//  Created by Vinitha Rao A on 17/03/22.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "\(ToDoTableViewCell.self)"
    
    var buttonTappedClosure: (() -> Void) = { }
    
    private lazy var colorLabel: UILabel = {
        let circleLabel = UILabel()
        circleLabel.backgroundColor = .systemPurple
        circleLabel.translatesAutoresizingMaskIntoConstraints = false
        return circleLabel
    }()
    
    private lazy var markAsCompletedButton: UIButton = {
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
        
    }()
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelWithText: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.addArrangedSubview(labelWithText)
        stackView.addArrangedSubview(markAsCompletedButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var holderView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(horizontalStackView)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.black.cgColor
        let viewDict: [String : Any] = ["cardView": horizontalStackView]
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[cardView]-10-|", options: [], metrics: nil, views: viewDict))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[cardView]-10-|", options: [], metrics: nil, views: viewDict))
        NSLayoutConstraint.activate(constraints)
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        markAsCompletedButton.layer.cornerRadius = markAsCompletedButton.frame.width/2
        markAsCompletedButton.layer.masksToBounds = true
        markAsCompletedButton.layer.borderColor = UIColor.black.cgColor
        markAsCompletedButton.layer.borderWidth = 0.5
        markAsCompletedButton.clipsToBounds = true
        
        self.contentView.layoutIfNeeded()
    }
        
    func setDataInCellContent(data: ToDoModel) {
        
        self.labelWithText.text = data.title
        if data.isCompleted {
            self.markAsCompletedButton.backgroundColor = .purple
        }
        self.addViewsToCell()
    }
    
    func addViewsToCell() {
        
        self.contentView.addSubview(holderView)

        let viewDict: [String : Any] = ["cardView": holderView]
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[cardView]-10-|", options: [], metrics: nil, views: viewDict))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[cardView]-10-|", options: [], metrics: nil, views: viewDict))
        NSLayoutConstraint.activate(constraints)

    }
    
    //MARK: Button Target
    @objc func buttonTapped() {
        
        buttonTappedClosure()
        
    }
}
