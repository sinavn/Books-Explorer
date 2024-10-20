//
//  HomeViewModel.swift
//  Books Explorer
//
//  Created by Sina Vosough Nia on 7/29/1403 AP.
//

import SwiftUI

class HomeViewModel : ObservableObject {
    @Published var books : [Book]?
    @Published var searchText : String = ""
    @Published var navigationPath = NavigationPath()
    @Published var isLoading : Bool = true
    private let networkService = NetworkService()
    private var initialBooks : [Book]? = []
    
    init() {
        getBookList(with: "harry potter")
    }
    
    func getBookList(with query:String){
        isLoading = true
        Task{
            do{
                let result = try await networkService.getBooks(query: query)
                await MainActor.run {
                    initialBooks = result
                    books = result
                    isLoading = false
                }
            }catch let error{
                print(error)
                await MainActor.run {
                    isLoading = false
                }
            }
        }
    }
    
    func searchContent(){
        isLoading = true
        Task{
            do{
                let result = try await networkService.getBooks(query: searchText)
                await MainActor.run {
                    books = result
                    isLoading = false
                }
            }catch let error{
                print(error)
                await MainActor.run {
                    isLoading = false
                }       
            }
        }
    }
    func resetToInitial(){
        books = initialBooks
    }
    
}
