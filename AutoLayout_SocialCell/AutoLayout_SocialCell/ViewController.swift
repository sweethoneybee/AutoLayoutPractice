//
//  ViewController.swift
//  AutoLayout_SocialCell
//
//  Created by 정성훈 on 2021/04/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTable()
    
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("NeedsUpdateLayout"), object: nil, queue: nil) {[weak self] (noti) in
            self?.tableView.performBatchUpdates(nil, completion: nil)
        }
    }
    
    private func configureTable() {
        self.tableView.register(SocialTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SocialTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        }
        
//        socialCell.profileImageView.image = UIImage(systemName: "person")
//        socialCell.nameLabel.text = "정성훈"
//        socialCell.uploadTimeLabel.text = "20시 30분"
////        socialCell.bodyTextLabel.text = "짧은 글토막"
//        socialCell.bodyTextLabel.text = """
//            이것은 긴 텍스트를 아무렇게나 적고 있는 건데 어디까지 호루루루루루루루ㅜ루룰
//            적힐지는 모르겠고 아무튼 트위터처럼 적는거고 나도 내가 새벽 한시에 호로로ㅗ겨롣개ㅕㅙ
//            이걸 왜 하고 있는지도 모르겠지만
//            그래도 재밌으니 합니다
//            """
//        socialCell.bodyImageView.image = UIImage(named: "\(indexPath.row % 3)")
//
        
//        cell.feed = Feed.feeds[Int.random(in: 0...9)]
        cell.feed = Feed.feeds[indexPath.row % 10]
        return cell
    }
    
    
}
