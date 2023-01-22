//
//  SummonerView.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 22/01/2023.
//

import SwiftUI

struct SummonerView: View {
    var summoner: Summoner?

    var body: some View {
        VStack {
            Text("ID: \(summoner?.id ?? "Not Found")")
            Text("Account ID: \(summoner?.accountId ?? "Not Found")")
            Text("PUUID: \(summoner?.puuid ?? "Not Found")")
            Text("Name: \(summoner?.name ?? "Not Found")")
        }
    }
}

struct SummonerView_Previews: PreviewProvider {
    static var previews: some View {
        SummonerView(summoner: Summoner(id: "afeoaebfoba", puuid: "fnoeafbpabefpze", accountId: "fnapenfgpafpe", name: "McBallz"))
    }
}


//struct SummonerRow: View {
//    var rowPrefix: String
//    var data: String?
//
//    var body: some View {
//        HStack{
//            Text("\(rowPrefix): \(data ?? "Not Found")")
//        }
//    }
//}
