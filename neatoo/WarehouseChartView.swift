//
//  WarehouseChartView.swift
//  neatoo
//
//  Created by song on 2025/6/4.
//

import SwiftUI
import SwiftData
import Charts

struct WareCategory: Identifiable {
    var category: String
    var color: String
    var number: Int
    var id = UUID()
}

struct WarehouseChartView: View {
    @Query private var wares: [Ware]
    
    private var wareData: [WareCategory] {
        var categories: [String: Int] = [
            "电器": 0, "家具": 0, "厨具": 0, "化妆品": 0,
            "运动器材": 0, "清洁用品": 0, "实用工具/材料": 0, "其他": 0
        ]
        
        for ware in wares {
            categories[ware.category, default: 0] += ware.number
        }
        
        return categories.map { WareCategory(category: $0.key, color: "", number: $0.value) }
    }
    
    var body: some View {
        Chart {
            ForEach(wareData) { data in
                    BarMark(
                        x: .value("类别", data.category),
                        y: .value("数量", data.number)
                    )
                    .foregroundStyle(by: .value("类别", data.category)) // 不同颜色
                }
        }
        .chartXAxis(.hidden) // 隐藏 x 轴标签
        .chartLegend(position: .bottom) // 使用图例列表
        .frame(height: 300)
        .padding()
    }
}

#Preview {
    WarehouseChartView()
        .modelContainer(for: [Ware.self])
}
