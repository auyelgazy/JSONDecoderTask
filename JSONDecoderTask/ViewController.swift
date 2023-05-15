//
//  ViewController.swift
//  JSONDecoderTask
//
//  Created by Kuanysh al-Khattab Auyelgazy on 15.05.2023.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = createUrl(with: "Black Lotus")
        getData(url: url)
    }

    private func createUrl(with cardName: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.magicthegathering.io"
        components.path = "/v1/cards"
        components.queryItems = [URLQueryItem(name: "name", value: cardName)]
        return components.url
    }

    private func getData(url: URL?) {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                print(error)
            }

            guard let response = response as? HTTPURLResponse else {
                print("No response")
                return
            }

            guard let data = data else {
                print("No data")
                return
            }

            print("[responseStatusCode] = \(String(describing: response.statusCode))\n")

            do {
                let jsonData = try JSONDecoder().decode(Cards.self, from: data)
                guard let card = jsonData.cards.first else { return }
                self.printCardInfo(card: card)
            } catch {
                print(error)
            }
        }.resume()
    }

    private func printCardInfo(card: Card) {
        print("""
              [data] = Card: \(card.name)
              Manacost: \(card.manaCost ?? "No manacost")
              CMC: \(card.cmc)
              Type: \(card.type)
              Rarity: \(card.rarity)
              Printings: \(card.printings)
              Original Text: \(card.originalText ?? "This card has no original text.")
              """)
    }
}
