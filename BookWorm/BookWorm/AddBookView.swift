//
//  AddBookView.swift
//  BookWorm
//
//  Created by Abhishek Rathore on 13/10/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var genre: String = "Romance"
    @State private var review: String = ""
    @State private var rating: Int = 3
    
    let genres = ["Romance", "Fantasy", "Kids", "Horror", "Mystery", "Poetry", "Thriller"]
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Enter the name of book", text: $title)
                    TextField("Enter the name of author", text: $author)
                    
                    Picker("Select the genre", selection: $genre){
                        ForEach(genres, id: \.self){ genre in
                            Text(genre)
                        }
                    }
                }
                Section("Wirte a review"){
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                Section{
                    Button("Save"){
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
            }.navigationTitle("Add book")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddBookView()
}
