
//  ApiNetworkManager.swift
//  Ern3st
//
//  Created by Muhammad Ali on 04/11/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
class ApiNetworkManager{
    var delegate: ApiNetworkManagerDelegate?
    
    
    let consumer_secret = "cs_4f4e3d2467bbf809e7f27414e3e2ab0c4a33121a"
    let consumer_key = "ck_8ca6b4ec6932e1b491d6043849d3563385dce297"
    
    let base_url:String = "https://ern3st.plus/wp-json/wc/v3/"
    func fetchCustomers(){
        AF.request(base_url+"customers?consumer_key=\(consumer_key)&consumer_secret=\(consumer_secret)").responseJSON { response in
            // debugPrint("Response from wordpress now: \(response)")
            let datastring = NSString(data: response.data!, encoding: String.Encoding.isoLatin1.rawValue)
            let data = datastring!.data(using: String.Encoding.utf8.rawValue)
            do {
                let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                let jsonArr = object as! NSArray
                print(jsonArr.count)
                
                for dict in jsonArr{
                    let myDict = dict as! NSDictionary
                    
                 
                }
                
                
                
                
                
            } catch let Error as Error {
                print("An error occured \(Error.localizedDescription)")
            }
            
        }
    }

        
        
        
          func fetchUserOrders(orderID: String){
         var products = [Product]()
         var shipmentAddress = ""
         var phone = ""
         var email = ""
         var total:Int = 0
         var totalQuantity:Int = 0
         var user_order: UserOrder!
         print(base_url+"orders?consumer_key=\(consumer_key)&consumer_secret=\(consumer_secret)")
         AF.request(base_url+"orders?consumer_key=\(consumer_key)&consumer_secret=\(consumer_secret)").responseJSON { response in
        
         if response.data != nil{
         let datastring = NSString(data: response.data!, encoding: String.Encoding.isoLatin1.rawValue)
         let data = datastring!.data(using: String.Encoding.utf8.rawValue)
         do {
         let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
         
         
         
         let jsonArr = object as! NSArray
         // print(jsonArr)
         
         
         for dict in jsonArr{
            
         let myDict = dict as! NSDictionary
         let id = String(describing: myDict["id"]!)
             print("order ids fetched \(id)")
         
         if orderID == id{
             print("order dict \(dict)")
             let billingDetails = myDict["billing"] as! NSDictionary
             
            
             
             
             let address1 = String(describing:  billingDetails["address_1"]!)
             let address2 = String(describing:  billingDetails["address_2"]!)
             let country = String(describing:  billingDetails["country"]!)
             shipmentAddress = address1 + " " + address2 + " " + country
             email = String(describing: billingDetails["email"]!)
             self.fetchCustomerWithEmail(email: email)
             phone = String(describing: billingDetails["phone"]!)
            let orderDetails = myDict["line_items"] as! NSArray
         
         for item in orderDetails{
         
         let dict = item  as! NSDictionary
         let id = String(describing:  dict["product_id"]!)
         let productName = String(describing:  dict["name"]!)
         let price = String(describing:  dict["price"]!)
         let quantity = dict["quantity"] as! Int
         let subtotal = String(describing:  dict["total"]!)
         let subtotalInt = Int(subtotal)!
         let img_dict = dict["image"]  as! NSDictionary
         
         let img_src = img_dict["src"] as! String
         
         total += subtotalInt
         totalQuantity += quantity
         
         
         }
             user_order = UserOrder(totalQuantity: totalQuantity, total: total, phone: phone, email: email, shipmentAddress: shipmentAddress)
             print("user order")
             print(user_order.email)
         
         GlobalUserData.userOrder = user_order
         self.delegate?.orderFetched()
         }
             else{
                 self.delegate?.idNotFound()
                 
             }
}
         
} catch let Error as Error {
         print("An error occured \(Error.localizedDescription)")
         }        }
         
         }
         
         }
    func fetchProducts(completion: @escaping () -> Void){
        var products: [Product] = []
        AF.request(base_url+"products?consumer_key=\(consumer_key)&consumer_secret=\(consumer_secret)").responseJSON { response in
            // debugPrint("Response from wordpress now: \(response)")
            let datastring = NSString(data: response.data!, encoding: String.Encoding.isoLatin1.rawValue)
            let data = datastring!.data(using: String.Encoding.utf8.rawValue)
            do {
                let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                let jsonArr = object as! NSArray
                print(jsonArr.count)
                
                for dict in jsonArr{
                    
                    let myDict = dict as! NSDictionary
                    
                    let id = String(describing: myDict["id"]!)
                    let descStr = String(describing: myDict["description"]!)
                   
                    let productDescription = descStr
                    let productName = String(describing:  myDict["name"]!)
                    
                    let productPrice = String(describing:  myDict["price"]!)
                    var productImgUrl = ""
                    var productCategory = ""
                    
                    if let imgArray = myDict["images"] as? [[String:Any]],
                       let imgDict = imgArray.first {
                       
                        productImgUrl = String(describing: imgDict["src"]!)
                           // the value is an optional.
                    }
                    if let categoryArray = myDict["categories"] as? [[String:Any]],
                       let categoryDict = categoryArray.first {
                       
                        productCategory = String(describing: categoryDict["name"]!)
                           // the value is an optional.
                    }
                    
                    
                    
                    
                    let product = Product(productCategory: productCategory, productName: productName, productDescription: productDescription, productImageUrl: productImgUrl, productRegPrice: productPrice, productDiscPrice: productPrice, proudctId: id)
                    products.append(product)
                    
                    
                    
                    
                   
                    
                 
                }
               // NotificationCenter.default.post(name: Notification.Name("DataFetched"), object: nil)
                GlobalUserData.products = products
                DispatchQueue.main.async {
                    completion()
                }
                
                
                
                
                
            } catch let Error as Error {
                print("An error occured in networking\(Error.localizedDescription)")
            }
            
        }
    }
    
    
    
  
    func postOrders(){
        let customValues = ["23", "32", "44"]

        let orderDetails: [String: Any] = [
            "customer_id": 2, // replace with the customer ID
            "line_items": [
                [
                    "product_id": 456, // replace with the product ID
                    "quantity": 1,
                    "meta_data": [
                        [
                            "key": "body measurements",
                            "value": customValues
                        ]
                    ]
                ]
            ]
        ]

        let headers: HTTPHeaders = [
            "Authorization": "Basic \(Data("\(consumer_key):\(consumer_secret)".utf8).base64EncodedString())",
            "Content-Type": "application/json"
        ]

        AF.request("\(base_url)/orders", method: .post, parameters: orderDetails, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let data):
                if let order = data as? [String: Any] {
                    print("New order created: \(order)")
                } else {
                    print("Unexpected response format")
                }
            case .failure(let error):
                print("Error creating order: \(error.localizedDescription)")
            }
        }
    }
  /*  func postUserOrder(){
        let url = "https://ern3st.plus/wp-json/wc/v3/orders"
        let customValues = ["23", "32", "44"]
        let parameters: Parameters = [
            "customer_id": 2,
            "billing": [
                "first_name": "John",
                "last_name": "Doe",
                "address_1": "123 Main St",
                "city": "Anytown",
                "state": "CA",
                "postcode": "12345",
                "country": "US",
                "email": "john.doe@example.com",
                "phone": "555-555-5555"
            ],
            "shipping": [
                "first_name": "Jane",
                "last_name": "Doe",
                "address_1": "456 Elm St",
                "city": "Anytown",
                "state": "CA",
                "postcode": "12345",
                "country": "US"
            ],
            "line_items": [
                [
                    "product_id": 1,
                    "quantity": 2,
                    "meta_data": [
                        [
                            "key": "body measurements",
                            "value": customValues
                        ]
                    ]                ]
            ]
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Basic " + Data("\(consumer_key):\(consumer_secret)".utf8).base64EncodedString(),
            "Content-Type": "application/json"
        ]

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                print("order posted")
                print(response)
            }
        
    }*/
    func fetchCustomerWithEmail(email: String){
        let url = "https://manashops.it/wp-json/wc/v3/customers?customers?email=\(email)"
        let consumerKey = "ck_e5016155e935c33ec5c6e6f76951e92473ab94da"
        let consumerSecret = "cs_75ce5862c4434877f50d18758a48b5419616edba"

        let headers: HTTPHeaders = [
            "Authorization": "Basic " + "\(consumerKey):\(consumerSecret)".data(using: .utf8)!.base64EncodedString()
        ]
        AF.request(url, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                // parse the customer data from the JSON object
                let customerName = json[0]["first_name"].stringValue
                let id = json[0]["id"].stringValue
                print("fetched customer in ernest")
                print(id)
                GlobalUserData.userId = id
               
               // handle the customer data
            case .failure(let error):
                print("error in fetch customer \(error.localizedDescription)")
                // handle the error
            }
        }

    }
    func editOrder(orderId: String){
        let customData = ["key": "value"]

      
        let url = "https://ern3st.plus/wp-json/wc/v3/orders/\(orderId)"

        // Set the headers to include the API authentication and content type
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(Data("\(consumer_key):\(consumer_secret)".utf8).base64EncodedString())",
            "Content-Type": "application/json"
        ]

        // Send the request to add custom data to the order
        AF.request(url, method: .put, parameters: customData, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            // Handle the response
            switch response.result {
            case .success:
                print("Custom data added to order successfully.")
                print(response)
            case .failure(let error):
                print("Error adding custom data to order: \(error)")
            }
        }
    }
   }
    

    

