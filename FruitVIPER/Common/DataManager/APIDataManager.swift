//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class APIDataManager: APIDataManagerInputProtocol
{
    var testURL: URL = URL(string: "http://www.martinogg.com/test/fruit.json")!
    
    private func timeNow() -> Int {
        return Int(Date.init().timeIntervalSince1970 * 1000)
    }
    
    func getOnlineData(onSuccess: @escaping (([Fruit]) -> ()), onFail: @escaping ((Error) -> ())) {
        
        let startTimeStamp = timeNow()
        
        Alamofire
            .request(testURL, method: .get)
            .validate()
            .responseObject { [unowned self] (response: DataResponse<FruitAPIResponse>) in
                let fruitAPIResponse = response.result.value
                if let fruit = fruitAPIResponse?.fruit {
                    onSuccess(fruit)
                    
                    self.sendEventLoad(time: self.timeNow() - startTimeStamp)
                } else {
                    let error = response.error ?? NSError(domain:"JSON to array Error", code:0, userInfo:nil)
                    onFail(error)
                    self.sendEventError(errorText: error.localizedDescription)
                }
            }
    }
    
    init() {}
    
    let feedbackURL = "www.awebsite.com/feedback?"
    
    func sendEventLoad(time: Int) {
        let _ = makeAlamofireRequest(url: URL(string: "\(feedbackURL)event=load&data=\(time)")!, method: .get)
    }
    
    func sendEventDisplay(time: Int) {
        let _ = makeAlamofireRequest(url: URL(string: "\(feedbackURL)event=display&data=\(time)")!, method: .get)
    }
    
    func sendEventError(errorText: String) {
        let escapedString: String = errorText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "Error in Escaping Error String"
        let _ = makeAlamofireRequest(url: URL(string: "\(feedbackURL)event=error&data=\(escapedString)")!, method: .get)
    }
    
    open func makeAlamofireRequest(url: URL, method: HTTPMethod) -> DataRequest {
        // todo test
        return Alamofire.request(url, method: method)
    }
    
}
