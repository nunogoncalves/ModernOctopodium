//
//  GithubLoadingView.swift
//  ModernOctopodium
//
//  Created by Nuno Gonçalves on 31/08/2019.
//  Copyright © 2019 numicago. All rights reserved.
//

import SwiftUI
import Combine

class LoadingTimer {

    let publisher = Timer.publish(every: 0.1, on: .main, in: .default)
    private var timerCancellable: Cancellable?

    func start() {
        self.timerCancellable = publisher.connect()
    }

    func cancel() {
        self.timerCancellable?.cancel()
    }
}

struct GithubLoadingView: View {

    @State private var index = 0

    private let images = (0...7).map { UIImage(named: "GithubLoading-\($0).gif")! }
    private var timer = LoadingTimer()

    var body: some View {
        return Image(uiImage: images[index])
            .resizable()
            .frame(width: 30, height: 30, alignment: .center)
            .onReceive(
                timer.publisher,
                perform: { _ in
                    self.index = self.index + 1
                    if self.index >= 7 { self.index = 0 }
                }
            )
            .onAppear { self.timer.start() }
            .onDisappear { self.timer.cancel() }
    }
}

struct GithubLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        GithubLoadingView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
