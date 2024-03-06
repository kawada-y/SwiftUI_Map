//
//  ContentView.swift
//  MyMap
//
//  Created by 河田佳之 on 2024/03/05.
//

import SwiftUI

struct ContentView: View {
    // 入力中の文字列を保持する状態変数
    @State var inputText: String = ""
    // 検索キーワードを保持する状態変数
    @State var dispSearchKey: String = ""
    
    var body: some View {
        VStack {
            TextField("キーワード",
                      text: $inputText,
                      prompt: Text("キーワードを入力してください"))
                // 入力された時
                .onSubmit {
                    // 入力が完了したので検索キーワードに設定する
                    dispSearchKey = inputText
                }
                // 余白を追加
                .padding()
            // マップを表示
            MapView(searchKey: dispSearchKey)
        }
    }
}

#Preview {
    ContentView()
}
