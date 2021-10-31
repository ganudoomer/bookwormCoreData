//
//  ContentView.swift
//  bookwormCore
//
//  Created by Sree on 31/10/21.
//

import SwiftUI
import CoreData


// Moving backing to the previous screen

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    @State private var showingAddScreen = false
    
    
    var body: some View {
        NavigationView {
            List{
                ForEach(books,id: \.self){ book in
                    NavigationLink(destination:BookView(book: book) ){
                        EmojiRatingView(rating: book.ratings)
                        VStack(alignment: .leading){
                            Text(book.title ?? "Unknown").font(.headline)
                            Text(book.author ?? "Unkown author").foregroundColor(.secondary)
                        }
                    }
                    
                }.onDelete(perform: { indexSet in
                    deleteBook(at: indexSet)
                })
                
            }.navigationBarTitle("Bookworm").navigationBarItems(leading: EditButton(),trailing: Button(action: {
                self.showingAddScreen.toggle()
            }, label: {
                Image(systemName: "plus")
            })).sheet(isPresented: $showingAddScreen, content: {
                AddBookView().environment(\.managedObjectContext, self.moc)
            })
        }
    }
    func deleteBook(at offsets: IndexSet) {
        for offset in offsets {
            let book  = books[offset]
            moc.delete(book )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
