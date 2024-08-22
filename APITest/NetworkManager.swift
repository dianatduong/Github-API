//
//  NetworkManager.swift
//  APITest
//
//  Created by Diana Duong on 8/11/24.
//

import SwiftUI

struct GitHubUser: Codable{
    let name: String
    let bio: String
    let avatarUrl:String
    let publicRepos: Int
}

@Observable
class NetworkManager{
    var user: GitHubUser?
    //making api request with URL
    func fetchUser() async throws {
        //unwrapping url to get the url
        guard let url = URL(string: "https://api.github.com/users/sallen0400") else {
            print("url didn't exist")
            return
        }
        do{
            let urlSession = try await URLSession.shared.data(from: url)
            let decoder:JSONDecoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            //getting response out of urlSession and casting it to HTTPURLResponse
            //checking if repspons is 200
            if let response = urlSession.1 as? HTTPURLResponse {
                if response.statusCode == 200 {
                    //serializing data( taking JSON data and converting it to our GitHubUser)
                    user = try decoder.decode(GitHubUser.self, from: urlSession.0)
                }
            }
        }catch {
            //Catching errors and throwing them
            throw error
        }
    }
}

#Preview {
    ContentView(nm: NetworkManager())
}
