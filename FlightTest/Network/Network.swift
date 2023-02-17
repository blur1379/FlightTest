//
//  Network.swift
//  FlightTest
//
//  Created by Mohammad Blur on 2/17/23.
//

import Foundation
import SwiftUI

class Network {
    //TODO: Function for calling url
    func callURL<T: Codable>(urlStr: String) async -> Result<T, Error> {
        do {
            let url = URL(string: urlStr)!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: data)
            return .success(model)
        } catch {
            return .failure(error)
        }
    }
    //TODO: function for image url
    @ViewBuilder
    func downloadImage(urlStr: String) -> some View{
         AsyncImage(url: URL(string: urlStr)!) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if phase.error != nil {
                Text("😓")
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
                
            }
        }
    }
    
}
