//
//  NPNGTableViewController.swift
//  NPNGWishList
//
//  Created by 민웅킴 on 5/3/24.
//

import UIKit
import CoreData

class NPNGTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var wishList: [Product] = [] {
        //속성 감지자 디드셋
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private var container: NSPersistentContainer {
        CoreSingleManager.shared.persistentContainer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        //CRUD 중 READ
        self.fetchWishList()
    }
    
    func fetchWishList() {
        //        NSFetchRequest(entityName: <#T##String#>)
        let request = Product.fetchRequest()
        
        do {
            let wishlist = try container.viewContext.fetch(request)
            self.wishList = wishlist
            
        } catch {
            //MARK: 에러 처리 - 정책에 따라..
        }
    }
    private func formatPrice(_ price: Int) -> String {
        let formmater = NumberFormatter()
        formmater.numberStyle = .decimal
        return "$ " + (formmater.string(from: price as NSNumber) ?? "")
        //        return "$ " + (formmater.string(from: 1000000 as NSNumber) ?? "")
    }
}

extension NPNGTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NPNGWishTableViewCell", for: indexPath) as? NPNGWishTableViewCell
        
        let product = wishList[indexPath.row]
        
        cell?.idLabel.text = "\(product.id)"
        cell?.titleLabel.text = product.title
//        cell?.priceLabel.text = self.formatPrice(Int(product.price))
        if let price = product.price as? Int {
            cell?.priceLabel.text = self.formatPrice(price)
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let product = self.wishList[indexPath.row]
            
            container.viewContext.delete(product)
            
            do {
                try container.viewContext.save()
                
                //1번 방법 : 저장소에서 다시 wishList를 불러와서 self.wishList에 넣어준다.
                // self.fetchWishList()
                
                //2번 방법 : self.wishList.remove
                //삭제하는동안 didSet을 쓰니까 새롭게 전체를 다시 다 그려버려서 하나만 삭제되도록 생각해보기
                self.wishList.remove(at: indexPath.row)
//                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
            } catch {
                //
            }
        }
    }
    
    
}
