//
//  BaseNetwork.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/27/25.
//

import Foundation
import OSLog

internal class BaseNetwork {
  private static let logger = Logger.category(.network)

  enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case badServerResponse(statusCode: Int)
    case decodingError(Error)
  }

  func request<T: Decodable>(from url: URL) async throws -> T {
    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse else {
      Self.logger.error("Invalid response from server for type \(T.self)")
      throw NetworkError.invalidResponse
    }

    guard (200...299).contains(httpResponse.statusCode) else {
      Self.logger.error("Bad server response for type \(T.self): \(httpResponse.statusCode)")
      throw NetworkError.badServerResponse(statusCode: httpResponse.statusCode)
    }

    do {
      let decodedData = try JSONDecoder().decode(T.self, from: data)
      Self.logger.info("Successfully decoded response for type \(T.self)")
      return decodedData
    } catch {
      Self.logger.error("Error decoding response for type \(T.self): \(error.localizedDescription)")
      throw NetworkError.decodingError(error)
    }
  }
}

