import Foundation

// One row of the "profiles" table in Supabase.
// The CodingKeys map Swift's camelCase names to the database's snake_case column names.
struct Profile: Codable, Identifiable, Hashable {
    let id: UUID
    var username: String
    var displayName: String?
    var bio: String?
    var avatarUrl: String?

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case bio
        case displayName = "display_name"
        case avatarUrl = "avatar_url"
    }

    // What to show as the main name: the display name if there is one, else the username.
    var title: String {
        if let name = displayName, !name.isEmpty {
            return name
        }
        return username
    }
}
