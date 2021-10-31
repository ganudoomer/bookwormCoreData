//
//  BookView.swift
//  bookwormCore
//
//  Created by Sree on 31/10/21.
//
import CoreData
import SwiftUI

struct BookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    let book: Book
    var body: some View {
        GeometryReader { geometry in
        VStack{
            ZStack(alignment: .bottomTrailing){
                Image(self.book.genre ?? "Fantasy").frame(maxWidth: geometry.size.width)
                
                
                Text(self.book.genre?.uppercased() ?? "Fantasy").font(.caption).fontWeight(.black).padding(8).foregroundColor(.white).background(Color.black.opacity(0.75))
                    .clipShape(Capsule()).offset(x: -5, y: -5)
                
                
                
                
                }
            Text(self.book.author ?? "Unkown author")
                .font(.title).foregroundColor(.secondary)
            
            Text(self.book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(self.book.ratings)))
                .font(.largeTitle )
            
            Spacer()
            
        }.alert(isPresented: $showingDeleteAlert, content: {
            Alert(title: Text("Delete book"),message: Text("Are you sure ?"),primaryButton: .destructive(Text("Delete")){
                self.deleteBook()
            },secondaryButton: .cancel())
        })
        }.navigationBarTitle( Text(book.title ?? " Unkown Book"),displayMode: .inline).navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert.toggle()
        }, label: {
            Image(systemName: "trash")
        }))
    }
    func deleteBook()  {
        moc.delete(book)
        // Dismiss the view from like we do with sheets
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct BookView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Hello "
        book.author = "Test"
        book.ratings = 4
        book.genre = "Fantasy"
        book.review = "The main book"
        return NavigationView{
            BookView(book: book)
        }
        
    }
}
