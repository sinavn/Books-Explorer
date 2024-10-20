//
//  ContentView.swift
//  Books Explorer
//
//  Created by Sina Vosough Nia on 7/29/1403 AP.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    var body: some View {
        NavigationStack(path:$viewModel.navigationPath,root:{
            if viewModel.isLoading{
                ProgressView()
            }else{
                if let books = viewModel.books{
                    List {
                        ForEach(books) { book in
                            BookRowView(book: book)
                                .onTapGesture {
                                    viewModel.navigationPath.append(book)
                                }
                        }
                    }
                    .navigationDestination(for: Book.self, destination: { book in
                        BookDetailView(book: book)
                    })
                    .listStyle(.plain)
                    .navigationTitle("Books")
                }else{
                    Text("No books found ")
                }
            }
        })
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "search for book...")

        .onSubmit(of: .search) {
            viewModel.searchContent()
        }
        .onChange(of: viewModel.searchText) { _, newValue in
            if newValue.isEmpty{
                viewModel.resetToInitial()
            }
        }
    }
}

#Preview {
    HomeView()
}
