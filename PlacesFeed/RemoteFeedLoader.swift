//
//  RemoteFeedLoader.swift
//  PlacesFeed
//
//  Created by Andrei on 17/10/2023.
//

import Foundation

public class RemoteFeedLoader: FeedLoader {
    public typealias Result = Swift.Result<[Location], Swift.Error>
    
    private let client: HTTPClient
    
    private static let feedRequestPath = "abnamrocoesd/assignment-ios/main/locations.json"
    
    public enum Error: Swift.Error {
        case invalidData
        case connectivity
    }
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        let requestUrl = API.baseUrl.appending(path: RemoteFeedLoader.feedRequestPath)
        client.get(from: requestUrl) { result in
            switch result {
            case let .success((remoteData, response)):
                completion(RemoteFeedLoader.map(remoteData, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let items = try RemoteFeedItemsMapper.map(data, from: response)
            return .success(items.toModels())
        } catch {
            return .failure(error)
        }
    }
}

final class RemoteFeedItemsMapper {
    private static var OK_200: Int { return 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteLocation] {
        guard response.statusCode == OK_200,
            let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw RemoteFeedLoader.Error.invalidData
        }

        return root.locations
    }
}

struct Root: Decodable {
    let locations: [RemoteLocation]
}

struct RemoteLocation: Decodable {
    let name: String
    let lat, long: Double
}

extension Array where Element == RemoteLocation {
    func toModels() -> [Location] {
        map { Location(name: $0.name, latitude: $0.lat, longitude: $0.long) }
    }
}
