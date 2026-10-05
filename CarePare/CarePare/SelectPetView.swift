//
//  SelectPetView.swift
//  MyApp
//
//  Created by Utkarsh Mishra on 28/09/26.
//

import SwiftUI

struct SelectPetView: View {
    @ObservedObject var data: BookingFlowData
    
    let categories: [PetCategory] = [
        PetCategory(
            name: "Dog",
            icon: "dog.fill",
            breeds: [
                "Golden Retriever", "Labrador Retriever", "German Shepherd", "Beagle",
                "French Bulldog", "Pomeranian", "Shih Tzu", "Pug", "Rottweiler",
                "Siberian Husky", "Doberman", "Boxer", "Great Dane", "Cocker Spaniel",
                "Chihuahua", "Border Collie", "Dachshund", "Dalmatian", "Bullmastiff",
                "Tibetan Mastiff", "Indian Pariah / Indie", "Mixed Breed"
            ]
        ),
        PetCategory(
            name: "Cat",
            icon: "cat.fill",
            breeds: [
                "Persian Cat", "Siamese", "Maine Coon", "British Shorthair", "Ragdoll",
                "Bengal", "Sphynx", "Russian Blue", "Scottish Fold", "Abyssinian",
                "Birman", "American Shorthair", "Burmese", "Norwegian Forest Cat",
                "Devon Rex", "Himalayan Cat", "Indian Domestic / Billi", "Mixed Breed"
            ]
        ),
        PetCategory(
            name: "Bird",
            icon: "bird.fill",
            breeds: [
                "Budgerigar (Budgie)", "Cockatiel", "African Grey", "Lovebird (Peach-faced)",
                "Indian Ringneck Parakeet", "Sun Conure", "Green Cheek Conure", "Canary",
                "Zebra Finch", "Gouldian Finch", "Cockatoo (Sulphur-crested)", "Cockatoo (Umbrella)",
                "Blue and Gold Macaw", "Scarlet Macaw", "Amazon Parrot", "Eclectus Parrot",
                "Pionus Parrot", "Quaker Parakeet (Monk)", "Caique", "Senegal Parrot",
                "Meyer's Parrot", "Alexandrine Parakeet", "Plum-headed Parakeet", "Diamond Dove",
                "Society Finch", "Java Sparrow", "Lorikeet", "Rosella", "Bourke's Parakeet", "Other Avian"
            ]
        ),
        PetCategory(
            name: "Rabbit",
            icon: "hare.fill",
            breeds: [
                "Holland Lop", "Netherland Dwarf", "Mini Rex", "Lionhead",
                "Flemish Giant", "French Lop", "English Angora", "Dutch Rabbit",
                "Mini Lop", "Himalayan Rabbit", "Polish Rabbit", "Mixed Breed"
            ]
        )
    ]
    
    @State private var selectedCategory: PetCategory?
    @State private var isShowingBreedPicker = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 4) {
                Text("STEP 2 OF 4").font(.caption).fontWeight(.bold).foregroundColor(.teal)
                Text("Select \(data.petName.isEmpty ? "Pet" : data.petName)'s Category").font(.system(size: 28, weight: .bold))
                Text("Select species to see custom specialist breeds.").font(.subheadline).foregroundColor(.secondary)
            }
            .padding(.top, 4)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(categories) { category in
                    let isSelected = selectedCategory?.name == category.name
                    Button(action: {
                        selectedCategory = category
                        data.petType = category.name
                        data.petBreed = category.breeds.first ?? ""
                    }) {
                        VStack(spacing: 8) {
                            Image(systemName: category.icon).font(.system(size: 32)).foregroundColor(isSelected ? .white : .teal)
                            Text(category.name).font(.headline).foregroundColor(isSelected ? .white : .primary)
                            Text("\(category.breeds.count) Breeds").font(.caption2).foregroundColor(isSelected ? .white.opacity(0.8) : .secondary)
                        }
                        .frame(maxWidth: .infinity).padding(.vertical, 16)
                        .background(isSelected ? Color.teal : Color(.secondarySystemBackground)).cornerRadius(14)
                    }
                }
            }
            
            if let activeCategory = selectedCategory {
                VStack(alignment: .leading, spacing: 6) {
                    Text("\(activeCategory.name) Breed (\(activeCategory.breeds.count) options)").font(.headline).padding(.top, 10)
                    Button(action: { isShowingBreedPicker = true }) {
                        HStack {
                            Image(systemName: "magnifyingglass").foregroundColor(.teal)
                            Text(data.petBreed.isEmpty ? "Tap to choose breed" : data.petBreed).foregroundColor(.primary).fontWeight(.medium)
                            Spacer()
                            Image(systemName: "chevron.right").foregroundColor(.secondary).font(.caption)
                        }
                        .padding().background(Color(.secondarySystemBackground)).cornerRadius(14)
                    }
                }
            }
            
            Spacer()
            
            if selectedCategory != nil {
                NavigationLink(destination: DescribeIssueView(data: data)) {
                    HStack {
                        Text("Next: Symptoms & Behavior")
                        Image(systemName: "arrow.right")
                    }
                    .font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.teal).cornerRadius(14)
                }
            }
        }
        .padding(20)
        .navigationTitle("Pet Breed")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingBreedPicker) {
            if let active = selectedCategory {
                BreedPickerSheet(categoryName: active.name, breeds: active.breeds, selectedBreed: $data.petBreed)
            }
        }
    }
}

struct BreedPickerSheet: View {
    let categoryName: String
    let breeds: [String]
    @Binding var selectedBreed: String
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var filteredBreeds: [String] {
        if searchText.isEmpty { return breeds }
        return breeds.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredBreeds, id: \.self) { breed in
                    Button(action: {
                        selectedBreed = breed
                        dismiss()
                    }) {
                        HStack {
                            Text(breed).foregroundColor(.primary)
                            Spacer()
                            if selectedBreed == breed { Image(systemName: "checkmark").foregroundColor(.teal).fontWeight(.bold) }
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search from \(breeds.count) \(categoryName) breeds...")
            .navigationTitle("\(categoryName) Breeds")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .cancellationAction) { Button("Done") { dismiss() } } }
        }
    }
}
