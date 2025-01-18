//
// Copyright © 2024 M-Lab Group Entrepreneurchat, University of Hamburg, Transferagentur. All rights reserved.
//

import Data
import Styleguide
import SwiftUI

/// The app's central screen, displaying the startup journey.
struct Journey: View {
  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack {
        LinearGradient(
          colors: [Color(.background3), Color(.background4)],
          startPoint: .top,
          endPoint: .bottom
        )
        .frame(maxWidth: .infinity, minHeight: 500)
        .overlay(alignment: .bottom) {
          Rocket(isUnlocked: modules.allSatisfy(\.isCompleted))
            .padding()
            .padding(.bottom, -100)
        }
        .zIndex(2)

        Path(modules: Array(modules))
          .zIndex(1)
      }
      .background(
        LinearGradient(
          colors: [Color(.background2), Color(.background1)],
          startPoint: .top,
          endPoint: .bottom
        )
      )
    }
    .defaultScrollAnchor(.bottom)
    .background(
      VStack {
        Color(.background3)
        Color(.background1)
      }
      .ignoresSafeArea()
    )
    .overlay {
      Stats.Overview(complete: modules.filter(\.isCompleted).count, total: modules.count)
    }
  }

  @FetchRequest(entity: Module.entity(), sortDescriptors: []) private var modules: FetchedResults<Module>
}

#Preview {
  Journey()
}
