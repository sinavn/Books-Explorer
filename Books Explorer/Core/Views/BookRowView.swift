//
//  BookRowView.swift
//  Books Explorer
//
//  Created by Sina Vosough Nia on 7/29/1403 AP.
//

import SwiftUI

struct BookRowView: View {
    let book : Book
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Book Thumbnail Image
            if let url = book.volumeInfo.imageLinks?.thumbnail {
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 180)
                        .background(.ultraThickMaterial)
                } placeholder: {
                    ProgressView()
                        .frame(width: 120, height: 180)
                }
            }else{
                Color.gray
                    .frame(width: 120, height: 180)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(book.volumeInfo.title ?? "UNknown")
                    .font(.headline)
                    .lineLimit(2)
               
                if let authors = book.volumeInfo.authors, !authors.isEmpty {
                    HStack(alignment:.top) {
                        Text("by:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        VStack(alignment:.leading){
                            Text(authors.prefix(2).joined(separator: ", "))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                    }
                    
                    
                }
                Spacer()
                BookCardTextView(title: "Categories: ", textBody: book.volumeInfo.categories?.prefix(3).joined(separator: ", ") ?? "n/a" , font: .caption)
                BookCardTextView(title: "Publisher: ", textBody: book.volumeInfo.publisher ?? "n/a", font: .caption)
                BookCardTextView(title: "Publish date: ", textBody: book.volumeInfo.publishedDate ?? "n/a", font: .caption)
            }
        }
        .background(.background.opacity(0.01))
        .padding(.vertical, 8)
        .frame(height: 200)
    }
}

//#Preview {
//    BookRowView()
//}

struct BookCardTextView : View {
    let title : String
    let textBody : String?
    let font : Font
    var body: some View {
        HStack{
            Text(title)
                .foregroundStyle(.gray)
            if let textBody = textBody{
                Text(textBody)
            }
        }
        .font(font)

    }
}
