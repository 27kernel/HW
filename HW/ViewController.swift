//
//  ViewController.swift
//  HW
//
//  Created by Ruslan Baigeldiyev on 18.02.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let topBar = UIView()
    let searchField = UITextField()
    let searchButton = UIButton()
    let addButton = UIButton()
    let postsTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // Add the top navigation bar
        topBar.backgroundColor = .white
        view.addSubview(topBar)

        topBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }

        // Add the search field and button
        searchField.placeholder = "Search"
        searchField.borderStyle = .roundedRect
        topBar.addSubview(searchField)

        searchButton.setImage(UIImage(named: "search_icon"), for: .normal)
        topBar.addSubview(searchButton)

        searchField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(searchButton.snp.left).offset(-10)
        }

        searchButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(30)
        }

        // Add the add button
        addButton.setImage(UIImage(named: "add_icon"), for: .normal)
        topBar.addSubview(addButton)

        addButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.right.equalTo(searchButton.snp.left).offset(-10)
            make.width.height.equalTo(30)
        }

        // Add the posts table view
        view.addSubview(postsTableView)

        postsTableView.snp.makeConstraints { make in
            make.top.equalTo(topBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }

        // Configure the posts table view
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // Replace with your own data source
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        cell.titleLabel.text = "Channel_name" // Replace with your own data source
        cell.descriptionLabel.text = "Description" // Replace with your own data source

        // Add the icons stack view
        let iconsStackView = UIStackView()
        iconsStackView.axis = .horizontal
        iconsStackView.alignment = .leading
        iconsStackView.spacing = 10

        let likeIcon = UIImageView(image: UIImage(named: "like_icon"))
        iconsStackView.addArrangedSubview(likeIcon)

        let commentsIcon = UIImageView(image: UIImage(named: "comments_icon"))
        iconsStackView.addArrangedSubview(commentsIcon)

        let shareIcon = UIImageView(image: UIImage(named: "share_icon"))
        iconsStackView.addArrangedSubview(shareIcon)

        cell.contentView.addSubview(iconsStackView)

        iconsStackView.snp.makeConstraints { make in
            make.top.equalTo(cell.descriptionLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }

        return cell
    }
}

class PostTableViewCell: UITableViewCell {

    let thumbnailImageView = UIImageView()
    let postImageView = UIImageView(image: UIImage(named: "post_pic"))
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    
    let likeIconImageView = UIImageView(image: UIImage(named: "like_icon"))
    let commentIconImageView = UIImageView(image: UIImage(named: "comment_icon"))
    let shareIconImageView = UIImageView(image: UIImage(named: "share_icon"))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Add the thumbnail image view
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        contentView.addSubview(thumbnailImageView)

        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(50)
        }

        // Add the post image view
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        contentView.addSubview(postImageView)

        postImageView.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(200)
        }

        // Add the like icon
        contentView.addSubview(likeIconImageView)

        likeIconImageView.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(20)
        }

        // Add the comment icon
        contentView.addSubview(commentIconImageView)

        commentIconImageView.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(10)
            make.left.equalTo(likeIconImageView.snp.right).offset(10)
            make.width.height.equalTo(20)
        }

        // Add the share icon
        contentView.addSubview(shareIconImageView)

        shareIconImageView.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(10)
            make.left.equalTo(commentIconImageView.snp.right).offset(10)
            make.width.height.equalTo(20)
        }

        // Add the title label
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        contentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.top)
            make.left.equalTo(thumbnailImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }

        // Add the description label
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(likeIconImageView.snp.bottom).offset(10)
            make.left.equalTo(thumbnailImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create view controllers for each tab
        let mainViewController = UIViewController()
        let searchViewController = UIViewController()
        let addPostViewController = UIViewController()
        let reelsViewController = UIViewController()
        let myProfileViewController = UIViewController()

        // Set the title and image for each tab item
        mainViewController.tabBarItem = UITabBarItem(title: "Main", image: UIImage(named: "main_icon"), tag: 0)
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search_icon"), tag: 1)
        addPostViewController.tabBarItem = UITabBarItem(title: "Add Post", image: UIImage(named: "addpost_icon"), tag: 2)
        reelsViewController.tabBarItem = UITabBarItem(title: "Reels", image: UIImage(named: "reels_icon"), tag: 3)
        myProfileViewController.tabBarItem = UITabBarItem(title: "My Profile", image: UIImage(named: "myprofile_icon"), tag: 4)

        // Set the view controllers for the tab bar controller
        self.viewControllers = [
            mainViewController,
            searchViewController,
            addPostViewController,
            reelsViewController,
            myProfileViewController
        ]

        // Customize the appearance of the tab bar
        self.tabBar.tintColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.isTranslucent = false
    }

}


