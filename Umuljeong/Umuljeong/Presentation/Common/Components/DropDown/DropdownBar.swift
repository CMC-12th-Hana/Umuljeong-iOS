//
//  DropdownRow.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/17.
//

import SwiftUI

struct DropdownOption: Hashable {
    let key: String
    let value: String

    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }
}


struct DropdownRow: View {
    var option: DropdownOption
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?

    var body: some View {
        Button(action: {
            if let onOptionSelected = self.onOptionSelected {
                onOptionSelected(self.option)
            }
        }) {
            HStack{
                Text(self.option.value)
                    .font(.body2)
                    .padding(.horizontal, 25)
                Spacer()
            }
            .frame(height: 40)
            .cornerRadius(4)
        }
        .buttonStyle(ChangeButtonBackgroundColor())
    }
}

struct Dropdown: View {
    var options: [DropdownOption]
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                    .frame(height: 15)
                ForEach(self.options, id: \.self) { option in
                    DropdownRow(option: option, onOptionSelected: self.onOptionSelected)
                        .padding(.horizontal, 4)
                }
                Spacer()
                    .frame(height: 15)
            }
        }
        .frame(minHeight: options.count < 6 ? CGFloat(options.count) * 40 + 30 : 220)
        .cornerRadius(5)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color("line2"), lineWidth: 1)
        )
    }
}

struct DropdownBar: View {
    @State private var shouldShowDropdown = false
    @State private var selectedOption: DropdownOption? = nil
    var placeholder: String
    var options: [DropdownOption]
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    private let buttonHeight: CGFloat = 46

    var body: some View {
            Button(action: {
                self.shouldShowDropdown.toggle()
            }) {
                HStack {
                    Text(selectedOption == nil ? placeholder : selectedOption!.value)
                        .font(.body2)
                        .foregroundColor(Color("font1"))
                    
                    Spacer()
                    
                    ImageBox(rectangleSize: 24, image: Image(self.shouldShowDropdown ? "upArrow" : "downArrow"))
                }
            }
            .padding(.horizontal, 15)
            .cornerRadius(6)
            .frame(height: self.buttonHeight)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("line2"), lineWidth: 1)
            )
            .overlay(
                VStack {
                    if self.shouldShowDropdown {
                        Spacer(minLength: buttonHeight + 6)
                        Dropdown(options: self.options, onOptionSelected: { option in
                            shouldShowDropdown = false
                            selectedOption = option
                            self.onOptionSelected?(option)
                        })
                    }
                }, alignment: .topLeading
            )
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
            )
    }
}

struct DropdownBar_Previews: PreviewProvider {
    static var uniqueKey: String {
        UUID().uuidString
    }

    static let options: [DropdownOption] = [
        DropdownOption(key: UUID().uuidString, value: "단순문의"),
        DropdownOption(key: UUID().uuidString, value: "고객민원"),
        DropdownOption(key: UUID().uuidString, value: "A/S"),
        DropdownOption(key: UUID().uuidString, value: "기술컨설팅"),
        DropdownOption(key: UUID().uuidString, value: "사전점검"),
        DropdownOption(key: UUID().uuidString, value: "사전점검"),
        DropdownOption(key: UUID().uuidString, value: "사전점검"),
        DropdownOption(key: UUID().uuidString, value: "사전점검")
    ]


    static var previews: some View {
        Group {
            DropdownBar(
                placeholder: "업무분류",
                options: options,
                onOptionSelected: { option in
                    print(option)
                })
            .padding(.horizontal)
        }
    }
}


