//
//  BookDetailView.swift
//  Books Explorer
//
//  Created by Sina Vosough Nia on 7/29/1403 AP.
//



import SwiftUI

struct BookDetailView: View {
    let book: Book
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                bookCover
                bookInfo
                description
                additionalInfo
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

extension BookDetailView {
    var bookCover : some View {
        VStack(){
            if let url = book.volumeInfo.imageLinks?.thumbnail {
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200 )
                        .cornerRadius(12)
                        .shadow(radius: 10)
                        .background(.ultraThinMaterial)
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: 200)
                }
            }else{
                Color.gray
                    .frame(width: 200, height: 240)
                    .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    var bookInfo : some View {
        VStack(alignment: .leading, spacing: 16){
            Text(book.volumeInfo.title ?? "Unknown")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            
            if let subtitle = book.volumeInfo.subtitle {
                Text(subtitle)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            if let authors = book.volumeInfo.authors, !authors.isEmpty {
                Text("By: \(authors.joined(separator: ", "))")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            if let publisher = book.volumeInfo.publisher, let publishedDate = book.volumeInfo.publishedDate {
                Text("Published by \(publisher) in \(publishedDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
    var description : some View {
        VStack(alignment: .leading, spacing: 16){
            if let description = book.volumeInfo.description {
                Text("Description")
                    .font(.headline)
                    .padding(.top)
                
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom)
            }
            
        }
    }
    var additionalInfo : some View {
        VStack(alignment: .leading, spacing: 8) {
            if let pageCount = book.volumeInfo.pageCount {
                Text("Page Count: \(pageCount)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let categories = book.volumeInfo.categories {
                Text("Categories: \(categories.joined(separator: ", "))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let averageRating = book.volumeInfo.averageRating {
                Text("Average Rating: \(String(format: "%.1f", averageRating))/5")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let ratingsCount = book.volumeInfo.ratingsCount {
                Text("Ratings: \(ratingsCount)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.top)

    }
}
