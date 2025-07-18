import Foundation

protocol URLSessionType {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionType {}

protocol APIClientProtocol {
    func perorrmRequest(with endpoint: RestEndpoint) async throws -> Data
}

struct APIClient: APIClientProtocol {
    private let session: URLSessionType
    private let serverSettings: ServerSettingsType
    private let requestFactory: URLRequestFactoryProtocol.Type

    init(_ session: URLSessionType = URLSession.shared, serverSettings: ServerSettingsType, requestFactory: URLRequestFactoryProtocol.Type = URLRequestFactory.self) {
        self.session = session
        self.serverSettings = serverSettings
        self.requestFactory = requestFactory
    }
    
    func perorrmRequest(with endpoint: any RestEndpoint) async throws -> Data {
        let request = try requestFactory.buildURLRequest(from: endpoint, on: serverSettings.baseUrl)
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        
        switch response.statusCode {
            case 200...399:
                return data
            default:
            throw URLError(.notConnectedToInternet)
        }
    }
}
