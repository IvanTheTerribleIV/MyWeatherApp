import Foundation

protocol URLSessionType {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionType {}

protocol APIClientProtocol {
    func perorrmRequest(with endpoint: RestEndpoint) async throws(NetworkError) -> Data
}

struct APIClient: APIClientProtocol {
    enum NetworkError: Error {
        case offline, timeout, cancelled, fatal
    }
    
    private let session: URLSessionType
    private let appSettings: AppSettings
    private let requestFactory: URLRequestFactoryProtocol.Type

    init(_ session: URLSessionType = URLSession.shared,
         appSettings: AppSettings = AppSettings(),
         requestFactory: URLRequestFactoryProtocol.Type = URLRequestFactory.self) {
        self.session = session
        self.serverSettings = serverSettings
        self.requestFactory = requestFactory
    }
    
    func perorrmRequest(with endpoint: any RestEndpoint) async throws(NetworkError) -> Data {
        let baseUrl = appSettings.currentWeatherService.baseUrl
        let request = try requestFactory.buildURLRequest(from: endpoint, on: baseUrl)
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }

        switch response.statusCode {
            case 200...399:
                return data
        case URLError.notConnectedToInternet.rawValue:
            throw NetworkError.offline
        case URLError.timedOut.rawValue:
            throw NetworkError.timeout
        case URLError.cancelled.rawValue:
            throw NetworkError.cancelled
        default:
            throw NetworkError.fatal
        }
    }
}
