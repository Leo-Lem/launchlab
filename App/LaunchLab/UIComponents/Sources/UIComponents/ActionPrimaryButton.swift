//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import SwiftUI

public struct ActionPrimaryButton: View {
  @Environment(\.colorScheme) var colorScheme

  @State private var isLoading = false
  private let isClickable: Bool
  private let title: String
  private let action: () async -> Void

  public init(isClickable: Bool, title: String, action: @escaping () async -> Void) {
    self.isClickable = isClickable
    self.title = title
    self.action = action
  }

  public var body: some View {
    GeometryReader { geometry in
      Button {
        Task {
          isLoading = true
          await action()
          isLoading = false
        }
      } label: {
        Group {
          if isLoading {
            ProgressView()
          } else {
            Text(title)
              .foregroundStyle(.white)
          }
        }
        .padding(.vertical)
        .frame(width: max(geometry.size.width - 40, 200))
        .background(
          RoundedRectangle(cornerRadius: 40)
            .fill(
              isClickable ? Color(uiColor: colorScheme == .dark ? .secondarySystemGroupedBackground : .blue)
                : .gray
            )
        )
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
      .disabled(!isClickable)
    }
  }
}
