//
//  AsyncImage.swift
//  InterfazP
//
//  Created by Alejandro Lizarraga on 11/06/23.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private let url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    func load() {
        guard let url = url else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: () -> Placeholder
    
    init(url: URL?, @ViewBuilder placeholder: @escaping () -> Placeholder) {
        self.placeholder = placeholder
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholder() // Use placeholder closure without arguments
            }
        }
    }
}
