//
//  Helper.swift
//  Travel
//
//  Created by Takashi Taguchi on 2021/05/21.
//

import Foundation

//クラスや構造体の中でないのでプロジェクトのどこからでも使える関数
func delay(durationInSeconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + durationInSeconds, execute: completion)
}
