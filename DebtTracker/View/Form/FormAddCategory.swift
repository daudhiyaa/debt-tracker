//
//  FormAddCategoryActivityView.swift
//  DebtTracker
//
//  Created by Daud on 03/05/24.
//

import SwiftUI
import SwiftData

struct FormAddCategory: View {
    @Environment(\.modelContext) private var context
    @Query private var categories: [CategoryActivity]
    
    @State private var viewModel = AddCategoryViewModel()
    
    @Binding var isSheetAddCategoryActivityPresented: Bool
    
    @State private var categoryName: String = ""
    @State private var categoryIcon: String = "beach.umbrella"
    
    let categoriesIcon: [String] = [
        "beach.umbrella", "fork.knife.circle",
        "macbook.and.iphone", "movieclapper", "photo.on.rectangle",
        "house", "car", "star", "bell", "envelope",
        "person", "moon", "sun.max", "cloud", "leaf",
        "heart", "book", "paperplane", "pencil", "scissors",
        "globe", "hourglass", "camera", "bicycle", "music.note"
    ]
    
    var body: some View {
        Form {
            TextField("Category Name", text: $categoryName).font(.body)
            Picker("Choose Icon", selection: $categoryIcon) {
                ForEach(categoriesIcon, id: \.self) { tag in
                    Image(systemName: tag).tag(tag)
                }
            }.pickerStyle(.menu)
            Button (action: {
                if(categoryName != "") {
                    viewModel.addCategory(title: categoryName, icon: categoryIcon)
                }
                isSheetAddCategoryActivityPresented = false
            }, label: {
                Text("Save").font(.headline)
            })
            
            Section {
                ForEach(categories) { category in
                    HStack {
                        Text(category.title)
                        Image(systemName: category.icon)
                    }
                }
                .onDelete{ indexSet in
                    for index in indexSet {
                        context.delete(categories[index])
                    }
                }
            }
        }
        .navigationBarTitle("New Category", displayMode: .inline)
        .navigationBarItems(
            trailing:Button("Cancel"){
                isSheetAddCategoryActivityPresented = false
            }.foregroundColor(.red)
        ).textCase(.none)
    }
}
