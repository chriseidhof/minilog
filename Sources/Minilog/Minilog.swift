import Foundation

public struct Post: Hashable, Codable, Identifiable {
    public init(deleted: Bool = false, id: UUID = UUID(), createdAt: Date = Date(), updatedAt: Date = Date(), contents: [Piece] = [
        .init(contents: .markdown(""))
    ]) {
        self.deleted = deleted
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.contents = contents
    }

    public var deleted = false
    public var id = UUID()
    public var createdAt = Date()
    public var updatedAt = Date()
    public var contents: [Piece] = [
        .init(contents: .markdown(""))
    ]
}

public struct Piece: Hashable, Codable, Identifiable {
    public init(id: UUID = UUID(), contents: Block) {
        self.id = id
        self.contents = contents
    }

    public var id = UUID()
    public var contents: Block
}

public struct ImageReference: Hashable, Codable, Identifiable {
    public init(id: UUID = UUID(), displayName: String, size: Size) {
        self.id = id
        self.displayName = displayName
        self.size = size
    }

    public var id = UUID()
    public var displayName: String
    public var size: Size
}

public struct Size: Hashable, Codable {
    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }

    public var width, height: Int
}

public enum Block: Hashable, Codable {
    case markdown(String)
    case image(ImageReference)
}


public struct Model: Codable, Hashable {
    public init(posts: [Post] = [], imageReference: [ImageReference] = []) {
        self.posts = posts
        self.imageReference = imageReference
    }

    public var posts: [Post] = []
    public var imageReference: [ImageReference] = []


    /// All non-deleted posts in reverse order (newest first)
    public var publicPosts: [Post] {
        posts.filter { !$0.deleted }.sorted(by: { $0.createdAt > $1.createdAt })
    }
}
