//
//  AuthService.swift
//  ChatDuo
//
//  Created by Amay's Mac on 27/10/25.
//

import Foundation

struct AuthResponse: Codable{
    let id: Int?
    let token: String
}

struct UserCredentials: Codable{
    let email: String
    let password: String
}

class AuthService{
    static let shared = AuthService()       //static here means this property belongs to class itself, so                                   we can always call AuthService.shared without ever calling                                          AuthService manually.
    private init() {}
    
    func register(email: String, password: String) async throws -> AuthResponse{
        guard let url = URL(string: "https://reqres.in/api/register") else{
            print("Invalid URL")
            throw URLError(.badURL)
        }
        return try await sendRequest(to: url, email: email, password: password)
    }
    func login(email: String, password: String) async throws -> AuthResponse {
        let url = URL(string: "https://reqres.in/api/login")!
        return try await sendRequest(to: url, email: email, password: password)
    }
    
    func sendRequest(to url: URL, email: String, password: String) async throws -> AuthResponse{
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("reqres-free-v1", forHTTPHeaderField: "x-api-key")
        
        let Credentials = UserCredentials(email: email, password: password)
        let jsonData = try JSONEncoder().encode(Credentials)
        
        let (data, response) = try await URLSession.shared.upload(for: request, from: jsonData)
        
//        if let httpResponse = response as? HTTPURLResponse {
//            print("STATUS:", httpResponse.statusCode)
//            print("BODY:", String(data: data, encoding: .utf8) ?? "No body")
//        }
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
            throw URLError(.badServerResponse)
        }
        
        let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
        UserDefaults.standard.set(authResponse.token, forKey: "authToken")
        
        return authResponse
    }
}
