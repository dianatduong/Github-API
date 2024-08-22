//
//  ContentView.swift
//  APITest
//
//  Created by Diana Duong on 8/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @Bindable var nm: NetworkManager
    @State var didGoToNextScreen = false
    
    var body: some View {
        
        ZStack {
            RadialGradient(colors: [.gray, .green],
                           center: .top, startRadius: 0, endRadius: 2000).ignoresSafeArea()
            
            VStack {
                AsyncImage(url: URL(string: nm.user?.avatarUrl ?? "")) { image in
                    image.resizable()
                        .frame(width: 200, height: 200)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .shadow(radius: 30)
                    
                } placeholder: {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                
                VStack {
                    Text(nm.user?.name ?? "")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    
                    Text(nm.user?.bio ?? "")
                        .font(.caption2)
                        .foregroundColor(.white)
                    
                    Text("Public Repos: \(nm.user?.publicRepos ?? 0)")                        .font(.caption2)
                        .foregroundColor(.white)
                }
                    
                Text("Hello, welcome to SwiftUI")
                    .shadow(radius: 30)
                    .padding()
                    
                    Button {
                        didGoToNextScreen.toggle()
                        
                    } label: {
                        Text("Welcome")
                            .frame(width: 300,height:30)
                            .background(.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    
                    //or sheet
                    .fullScreenCover(isPresented:
                                        $didGoToNextScreen, content: {
                        Text("welcome")
                            .bold()
                        
                    })
                    
                }
                .task{
                    do {
                        try await nm.fetchUser()
                    }catch {
                        print("error occured")
                    }
                }
            }
        
    }
}

#Preview {
    ContentView(nm: NetworkManager())
}
