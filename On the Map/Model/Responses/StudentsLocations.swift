import Foundation

struct StudentsLocations: Codable{
    let results: [StudentData]
}

struct StudentData: Codable{
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
}
