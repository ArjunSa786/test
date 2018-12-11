//
//  ViewController.swift
//  SearchLang
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UpdateInfoDelegate {
   
    
  
    
    // Member variables
    @IBOutlet weak var m_searchTableView: UITableView!
    
    @IBOutlet weak var m_searchBar: UISearchBar!
    
    private var searchString:String!
    
    private let cellID = "LanguageCellIdentifier"
    
    var selectedIndexRow:Int!
    
    
    private var articleArray = [SearchResult]()
    {
        didSet {
            self.m_searchTableView.reloadData()
        }
    }
    
    
    let service = ArticleService()
    var updatedelegate:UpdateInfoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        m_searchBar.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    private func getSearchResult<S: GetArticle>(fromService service: S) where S.T == Array<SearchResult?> {
        service.getArticlesList(str: searchString, completion: { [weak self] (result) in
            switch result {
            case .Success(let articles):
                var tempArticle = [SearchResult]()
                for article in articles {
                    if let article = article {
                        tempArticle.append(article)
                    }
                }
                self?.articleArray = tempArticle
               case .Error(let error):
                print(error)
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! LanguageCell

        cell.selectionStyle = .none
        if articleArray[indexPath.row].isUpdate == true
        {
            //Random Color
//            cell.contentView.backgroundColor = .random()
            // color
            cell.contentView.backgroundColor = #colorLiteral(red: 0.7536347331, green: 0.7572595969, blue: 1, alpha: 1)
        }
        else
        {
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        cell.configureCell(result: articleArray[indexPath.row])

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndexRow = indexPath.row
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        newViewController.delegate = self
        newViewController.selectedInfo = articleArray[indexPath.row]
        self.present(newViewController, animated: true, completion: nil)
        
    }
      // MARK: - Search Bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchString = searchBar.text
        self.m_searchBar.endEditing(true)
        // Call Service class using Generic Function
        getSearchResult(fromService: service)
    }
    
    func didUpdateInfo(updatedResult:SearchResult) {
        self.articleArray[selectedIndexRow] = updatedResult
    }
   
    
}
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

