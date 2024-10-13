//
//  ContentView.swift
//  WordScramble
//
//  Created by Abhishek Rathore on 08/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var rootWord: String = ""
    @State var word: String = ""
    @State var words: [String] = []
    
    func insertWord(){
        let trimmedWord = word.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedWord.isEmpty else { return }
        withAnimation {
            words.insert(word, at: 0)
        }
    }
    
    func startGame (){
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                print("Root word: \(rootWord)")
                return
            }
        }
        fatalError("Could not load start words")
    }
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("Enter the word", text: $word)
                        .textInputAutocapitalization(.never)
                }
                Section{
                    ForEach(words, id: \.self){ word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .onAppear(perform: startGame)
            .navigationTitle(rootWord)
            .onSubmit(insertWord)
        }
    }
}

#Preview {
    ContentView()
}
