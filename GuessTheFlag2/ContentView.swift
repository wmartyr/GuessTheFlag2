//
//  ContentView.swift
//  GuessTheFlag2
//
//  Created by Woodrow Martyr on 2/11/2024.
//

import SwiftUI
 
struct FlagImage: View {
    var countryName: String
    
    var body: some View {
        Image(countryName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var alertMessage = ""
    @State private var showingFinalResult = false
    @State private var finalResultTitle = ""
    @State private var gamesPlayed = 0
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) {number in
                        Button{
                            flagTapped(number)
                        } label: {
//                            Image(countries[number])
                            FlagImage(countryName: countries[number])
                        }
//                        .clipShape(.capsule)
//                        .shadow(radius: 5)
                    }
                }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: gameCheck)
        }message: {
            Text(alertMessage)
        }
        .alert("Final Result", isPresented: $showingFinalResult) {
            Button("Restart", action: resetGame)
        }message: {
            Text("Your final score is \(userScore) out of 8.")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            alertMessage  = "Your score is \(userScore)"
        } else {
            scoreTitle = "Wrong"
            alertMessage = "That's the flag of \(countries[number])."
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func gameCheck() {
        gamesPlayed += 1
        if gamesPlayed == 8 {
            showingFinalResult = true
        } else {
            askQuestion()
        }
    }
    
    func resetGame() {
        userScore = 0
        gamesPlayed = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
