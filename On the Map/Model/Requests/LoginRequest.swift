
import Foundation

struct Student: Codable{
    let username: String
    let password: String
}

struct LoginRequest: Codable{
    let user: Student
    enum CodingKeys: String, CodingKey{
        case user = "udacity"
    }
}

