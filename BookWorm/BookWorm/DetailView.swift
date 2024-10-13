//
//  DetailView.swift
//  BookWorm
//
//  Created by Abhishek Rathore on 13/10/24.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var showingAlert = false
    
    let book : Book
    var body: some View {
        ScrollView{
            ZStack(alignment:.bottomTrailing){
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                Text(book.genre.uppercased())
                    .font(.title)
                    .padding(8)
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            Text(book.review)
                .padding()
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            Button("Delete Book", systemImage: "trash"){
                showingAlert = true
            }
        }
        .alert("Delete book", isPresented: $showingAlert){
            Button("cencel", role: .cancel){}
            Button("delete", role: .destructive){
                modelContext.delete(book)
                dismiss()
            }
        }
        message:{
            Text("Are you sure?")
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    do{
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: configuration)
        let book = Book(title: "SwiftUI", author: "Abhishek Rathore", genre: "Fantasy", review: "A book about SwiftUI", rating: 4)
        return DetailView(book: book).modelContainer(container)
    }
    catch{
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
