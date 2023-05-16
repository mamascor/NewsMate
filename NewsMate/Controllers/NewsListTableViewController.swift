//
//  NewsListTableViewController.swift
//  NewsMate
//
//  Created by Marco Mascorro on 5/16/23.
//

import UIKit


class NewsListTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    private var articleListVM: ArticleListViewModel!
    
    
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        navigationController?.navigationBar.prefersLargeTitles = true
        
        guard let url = URL(string: news_url) else { return }
        
        WebService().getArticles(url: url) { news in
            guard let news = news else { return }
            
            self.articleListVM = ArticleListViewModel(articles: news)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
}


extension NewsListTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newscell", for: indexPath) as! ArticleTableViewCell
        let articlevm = self.articleListVM.articleAtIndex(indexPath.row)
        if let url = articlevm.imageurl {
            WebService().downloadImage(from: url) { image in
                DispatchQueue.main.async {
                    cell.newsImageView.image = image
                }
            }
        }
        
       
        cell.titleLabel.text = articlevm.title
        cell.descriptionLabel.text = articlevm.description
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articlevm = self.articleListVM.articleAtIndex(indexPath.row)
        UIApplication.shared.open(articlevm.url)
    }
    
}
