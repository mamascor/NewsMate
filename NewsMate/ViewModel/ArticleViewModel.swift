//
//  ArticleViewModel.swift
//  NewsMate
//
//  Created by Marco Mascorro on 5/16/23.
//

import UIKit

struct ArticleListViewModel {
    
    let articles: [Article]
    
}

extension ArticleListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int)-> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int)-> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
}

struct ArticleViewModel {
    private let article: Article
    
    
}

extension ArticleViewModel{
    init(_ article: Article){
        self.article = article
    }
}

extension ArticleViewModel {
    var title: String {
        return self.article.title
    }
    
    var description: String {
        self.article.description ?? ""
    }
    
    var url: URL {
        guard let url = URL(string: article.url) else { fatalError("No Url")}
        return url
    }
    
    var imageurl: URL? {
        guard let urlstring = article.urlToImage else { return nil }
        guard let url = URL(string: urlstring) else { return nil }
        
        return url
    }
    
    
   
    
}
