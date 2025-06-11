//
//  View_All_Account.swift
//  neatoo
//
//  Created by song on 2025/6/11.
//

import SwiftUI
import SwiftData

struct AllAccountView: View {
    @Query private var accounts: [Account]
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var editMode: EditMode = .inactive
    
    private func deleteAccount(at offsets: IndexSet) {
        for index in offsets {
            let account = accounts[index]
            context.delete(account)
        }
        try? context.save()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    ForEach(accounts) { account in
                        NavigationLink {
                            AccountDetailInfo(account: account)
                        } label: {
                            Text("\(account.name)")
                        }
                    }
                    .onDelete(perform: deleteAccount)
                }
                Section {
                    NavigationLink {
                        AddNewAccount()
                    } label: {
                        Text("添加新账户")
                    }
                }
            }
            .environment(\.editMode, $editMode)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.easeInOut) {
                            editMode = editMode == .active ? .inactive : .active
                        }
                    } label: {
                        Image(systemName: editMode == .active ? "checkmark" : "pencil")
                    }
                }
            }
            .navigationTitle("账户管理")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AllAccountView()
        .modelContainer(for: [Account.self])
}
