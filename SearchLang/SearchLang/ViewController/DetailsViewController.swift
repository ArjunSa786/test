//
//  DetailsViewController.swift
//  SearchLang
//

import UIKit
protocol UpdateInfoDelegate {
    func didUpdateInfo(updatedResult:SearchResult)
}

class DetailsViewController: UIViewController {

    @IBOutlet weak var m_nameLbl: UITextField!
    @IBOutlet weak var m_loginLbl: UITextField!
    var delegate : UpdateInfoDelegate?
    var selectedInfo:SearchResult!
    
    @IBOutlet weak var m_descriptionTxtView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        m_loginLbl.text = selectedInfo.owner.login
        m_nameLbl.text = selectedInfo.name
        m_descriptionTxtView.text = selectedInfo.descriptionField
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func act_saveInfo(_ sender: Any) {
        
      selectedInfo.owner.login =  m_loginLbl.text
      selectedInfo.name =  m_nameLbl.text
      selectedInfo.descriptionField = m_descriptionTxtView.text
      selectedInfo.isUpdate = true
        if delegate != nil {
            self.delegate?.didUpdateInfo(updatedResult:selectedInfo)
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
