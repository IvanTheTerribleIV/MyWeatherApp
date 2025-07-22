import Foundation

protocol APIClientProtocol {
    func perorrmRequest(with endpoint: RestEndpoint) async throws(APIClient.NetworkError) -> Data
    func data(_ url: URL) async throws -> Data
}

struct APIClient: APIClientProtocol {
    enum NetworkError: Error {
        case offline, timeout, cancelled, fatal
    }
    
    private let session: URLSessionType
    private let requestFactory: URLRequestFactoryProtocol.Type

    init(_ session: URLSessionType = URLSession.shared,
         requestFactory: URLRequestFactoryProtocol.Type = URLRequestFactory.self) {
        self.session = session
        self.requestFactory = requestFactory
    }
    
    func perorrmRequest(with endpoint: any RestEndpoint) async throws(APIClient.NetworkError) -> Data {
        let baseUrl = AppSettings.shared.currentWeatherService.baseUrl
       
        do {
            let request = try requestFactory.buildURLRequest(from: endpoint, on: baseUrl)
            
            let (data, response) = try await session.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.fatal
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
        } catch {
            throw NetworkError.fatal
        }
    }
    
    func data(_ url: URL) async throws -> Data {
        try await session.data(from: url).0
    }
}
