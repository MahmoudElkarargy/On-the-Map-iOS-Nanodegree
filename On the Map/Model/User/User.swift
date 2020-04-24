
import Foundation
import UIKit

class User{
    
    enum Endpoints{
        case session
        case signUP
        var StringValue: String{
            switch self {
            case .session:
                return "https://onthemap-api.udacity.com/v1/session"
            case .signUP:
                return "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated"
            }
        }
        
        var url: URL{
            return URL(string: StringValue)!
        }
    }
    
    class func login(username: String, password: String, completionHandler: @escaping (Bool, Error?)->Void){
        let body = LoginRequest(user: Student(username: username, password: password))
        taskPOSTRequest(url: Endpoints.session.url, responseType: LoginResponse.self, body: body, completionHandler: { (response, error) in
            if response != nil{
                //safely unwrapped response so login successfull
                completionHandler(true, nil)
            }else{
                //unable to login throw error
                completionHandler(false, error)
            }
        })
    }
    
    class func taskPOSTRequest <RequestType: Encodable, ResponseType: Decodable> (url: URL, responseType: ResponseType.Type, body: RequestType, completionHandler: @escaping (ResponseType?,Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        do{
            request.httpBody = try encoder.encode(body)
        }catch{
            //cannot convert to http body, throw error
            DispatchQueue.main.async {
                completionHandler(nil, error)
            }
        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data,response,error) in
            guard let data = data else{
                //cannot fetch response, throw error
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            let range = 5..<data.count
            let newData = data.subdata(in: range) //subset response data!
            do{
                //try fetching response
                let response = try JSONDecoder().decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completionHandler(response, nil)
                }
            }catch{
                //unable to parse response, throw error
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            }
        })
        task.resume()
    }
    
    class func logout(completionHandler: @escaping (Bool, Error?)->Void){
        var request = URLRequest(url: Endpoints.session.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            guard let data = data else{
                //cannot delete session
                DispatchQueue.main.async {
                    completionHandler(false, error)
                }
                return
            }
            do{
                let range = 5..<data.count
                let newData = data.subdata(in: range) /* subset response data! */
                //fetched response successfuly
                _ = try JSONDecoder().decode(LogoutResponse.self, from: newData)
                DispatchQueue.main.async {
                    completionHandler(true, nil)
                }
            }catch{
                //couldn't fetch response, throw error
                DispatchQueue.main.async {
                    completionHandler(false, error)
                }
            }
        })
        task.resume()
    }
    
}
