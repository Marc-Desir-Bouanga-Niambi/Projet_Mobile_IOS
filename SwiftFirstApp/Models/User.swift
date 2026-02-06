import Foundation

public struct User: Identifiable, Codable {
    public let id : UUID
    var name : String
    var email : String
    var password : String
    var favoriteMovieIds : Favorite
}
