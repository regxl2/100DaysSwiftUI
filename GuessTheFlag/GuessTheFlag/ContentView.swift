//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Abhishek Rathore on 03/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State var title = ""
    @State var showTitle = false
    @State var score = 0
    @State var totalQuestionRemaining = 8
    
    func flagTapped(number: Int){
        if(correctAnswer == number){
            title = "Correct"
            score+=1
        }
        else{
            title = "Wrong"
        }
        totalQuestionRemaining-=1
        showTitle = true
    }
    
    func askQuestion(){
        if(totalQuestionRemaining>0){
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    var body: some View {
        ZStack{
            RadialGradient(
                stops:[
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.46), location: 0.3),
                    .init(color: Color(red: 0.7, green: 0.2, blue: 0.36), location: 0.3)
                ],
                center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
            VStack(spacing: 15){
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 30){
                    VStack{
                        Text("Tap the flag of").foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).foregroundStyle(.black)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number: number)
                        }
                        label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding()
                Text("Your Score is \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
                Spacer()
            }.alert(title, isPresented: $showTitle){
                if(totalQuestionRemaining==0){
                    Button("Restart"){
                        totalQuestionRemaining = 8
                        score = 0
                        countries.shuffle()
                        correctAnswer = Int.random(in: 0...2)
                    }
                }
                else{
                    Button("Continue", action: askQuestion)
                }
            } message: {
                Text("That's the flag of \(countries[correctAnswer]). \(totalQuestionRemaining == 0 ? "You got \(score) out of 8 questions correct. Keep going!" : "")")
            }
        }
    }
}

#Preview {
    ContentView()
}
