//
//  ContentView.swift
//  BookWorm
//
//  Created by Abhishek Rathore on 12/10/24.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Book.rating), SortDescriptor(\Book.author)]) var books: [Book]
    @State var showSheet = false
    
    func deleteBooks(at offsets: IndexSet){
        for offset in offsets{
            modelContext.delete(books[offset])
        }
    }
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(books){ book in
                    NavigationLink(value: book){
                        HStack{
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack{
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Books")
            .navigationDestination(for: Book.self){
                selection in
                DetailView(book: selection)
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button("add book", systemImage: "plus"){
                        showSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: $showSheet){
                AddBookView()
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    ContentView()
}
