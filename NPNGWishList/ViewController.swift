//
//  ViewController.swift
//  NPNGWishList
//
//  Created by 민웅킴 on 4/30/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var wishImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var randomNumber: Int? {
        (1...10).randomElement()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // if let 처리된 id와 url
        if let id = randomNumber,
           // URL = 실패할때 옵셔널을 반환하는 타입. init?(string: String)
           let url = URL(string: "https://dummyjson.com/products/\(id)") {
            
            // 중에 url은 <요청>으로 받는다
            let request = URLRequest(url: url)
            
            
            //지금은 GET 정도의 작업만 필요하니까, 캐시 관련이나 부가적인 작업필요없는 기본적 형식
            //  class var shared: URLSession { get }
            //shared 속성을 이용하면 만들어진 URLSession을 이용할 수 있다.
            
            // URLSession.shared.dataTask(with: <#T##URLRequest#>,
            //                                  요청을 하고
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                // JSONDecoder는 클래스니까 ()해주고 . 접근
                
                if let error = error {
                    
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode)
                else {
                    return
                }
                
                if let data = data,                        //data를 RemoteProduct.self의 타입으로 디코드 하겠다. .self는 메타타입 .Type임
                                //decode는 ... ) throws -> T where T : Decodable형태 throws가 있으면 do - try로 처리,
                    let product = try? JSONDecoder().decode(RemoteProduct.self, from: data) {
                    
                    DispatchQueue.main.async {
                        self?.titleLabel.text = product.title
                    }
                    
                    print(product.title)
                    print(product.description)
                    print(product.price)
                    print(product.thumbnail)
                }
            }
            //                                              데이터, 응답, 에러를 넘길거다.
            // completionHandler: <#T##(Data?, URLResponse?, (any Error)?) -> Void#>)
            //                  // 요청에 대한 응답의 처리를 핸들러에서 처리 하겠다.
            
            
            task.resume()
            
            /*
             // .ephemeral : 캐시나 쿠키를 남기지 않는 설정
             var config = URLSessionConfiguration.ephemeral
             
             config.httpAdditionalHeaders = []
             
             let session = URLSession(configuration: config)
             
             //캐시(저장된 데이터)로 사용할 정책 설정
             URLSession(configuration: config)
             */
        }
    }
}

