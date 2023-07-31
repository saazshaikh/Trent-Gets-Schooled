//
//  ContentView.swift
//  Trent Gets Schooled
//
//  Created by Saaz Shaikh on 15/07/2023.
//

import SwiftUI


struct ContentView: View {
    
    @State var questions = [
        
        Question(setup: "How many mentors are there?", wrongAnswer1: "2", correctAnswer: "3", wrongAnswer2: "4", wrongAnswer3: "5"),
        Question(setup: "Which bionic does adam use the most?", wrongAnswer1: "increased lung capacity", correctAnswer: "super strength", wrongAnswer2: "heat vision", wrongAnswer3: "ice breath"),
        Question(setup: "At what speed does bree run", wrongAnswer1: "the speed of light", correctAnswer: "the speed of sound", wrongAnswer2: "400km/h", wrongAnswer3: "10000km/h"),
        Question(setup: "Which one of these is not a bionic", wrongAnswer1: "adam", correctAnswer: "davenport", wrongAnswer2: "bree", wrongAnswer3: "chase"),
        Question(setup: "who is the richest person in the show", wrongAnswer1: "davenport", correctAnswer: "harrington", wrongAnswer2: "principal perry", wrongAnswer3: "eddie"),
        
    ]// the questions and answers
    
    var goodReview = [
        "NO WAY YOU GOT 5/5",
        "hmmmmmmm, good start, but remember the\n questions get harder, so dont get too full of urself",
        "ig you are not too bad afterall",
        "okay i am impressed",
        "yay, sometimes you shock me!",
        
    ]
    var badReview = [
        "its okay these questions are quite hard",
        "LOOOOL its hard, but it is very likely\n that you are just dumb",
        "skill issue",
        "at this point you know you are clearly the problem",
        "looser 😂🫵🏽🫵🏽",
    ]
    
    @State var wrongAnswers: [Question] = []
    @State var correctAnswers: [Question] = []
    
    
    @State private var showPunchline = false
    @State private var currentQuestionIndex = 0
    @State private var isFeedbackPresented = false
    @State private var displaySheet = false
    @State private var isButtonClicked = true
    @State private var isAnswerCorrect = false
    @State private var numOfCorrectAnswers = 0
    @State private var feedbackSize = 0.1
    @State private var tapOffset = 300.0
    @State private var totalQuestions = 5
    @State private var selectedAnswer: String = ""

    
    func wrongButton(_ color: Color, label: String ) -> some View {
        Button {
            withAnimation {
                showPunchline = true
                isButtonClicked = false
                isAnswerCorrect = false
                wrongAnswers.append(questions[currentQuestionIndex % questions.count])
            }
            currentQuestionIndex += 1
        } label: {
            Text(label)
                .frame(width: 153, height: 200)
                .padding()
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(50)
        }
    }
    func correctButton(_ color: Color, label: String ) -> some View {
        Button {
            numOfCorrectAnswers += 1
            withAnimation {
                showPunchline = true
                isButtonClicked = false
                isAnswerCorrect = true
                correctAnswers.append(questions[currentQuestionIndex % questions.count])
            }
            currentQuestionIndex += 1
        }label: {
            Text(label)
                .frame(width: 153, height: 200)
                .padding()
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(50)
        }
    }

    
    var body: some View {
        ZStack {
            
            
            
            if currentQuestionIndex >= 0 {
                ZStack{
                    VStack{
                        //Question
                        Text (questions [currentQuestionIndex % questions.count].setup)
                            .padding()
                            .offset(y: 250)
                            .bold()
                        
                        var currentQuestion = questions[currentQuestionIndex % questions.count]
                        
                        if isButtonClicked {
                            
                            withAnimation (.interpolatingSpring(stiffness: 100, damping: 7)) {
                                
                                wrongButton(.red, label: questions[currentQuestionIndex % questions.count].wrongAnswer1)
                                 .offset(x: -97, y: 380)
                            }
                        }// red button, wrong
                        if isButtonClicked {
                            withAnimation (.interpolatingSpring(stiffness: 100, damping: 7)) {
                                correctButton(.blue, label: questions[currentQuestionIndex % questions.count].correctAnswer)
                                .offset(x: -97, y: 380)
                            }
                        }// blue button, correct
                        if isButtonClicked {
                            withAnimation (.interpolatingSpring(stiffness: 100, damping: 7)) {
                                wrongButton(.yellow, label: questions [currentQuestionIndex  % questions.count].wrongAnswer2)
                                .offset(x: 97, y: -100)
                            }
                        }// yellow button, wrong
                        if isButtonClicked {
                            withAnimation (.interpolatingSpring(stiffness: 100, damping: 7)) {
                                wrongButton(.green, label: questions [currentQuestionIndex  % questions.count].wrongAnswer3)
                                .offset(x: 97, y: -100)
                            }
                        }// green button, wrong
                        
                    }//all the buttons and their positioning, and the question
                    
                    //questions progrss circle
                    CircularProgressView(process: CGFloat(currentQuestionIndex)/CGFloat(totalQuestions))
                        .frame(width: 150, height: 150)
                        .scaleEffect(0.6)
                        .offset(y: -140)
                    
                }// has the buttons, the question and the progess circle
                
                if isButtonClicked == false {
                    
                    Button {
                        isButtonClicked = true
                        feedbackSize = 0.1
                    } label: {
                        if isAnswerCorrect && currentQuestionIndex != 5 && currentQuestionIndex != 0 {
                            Text(goodReview[currentQuestionIndex % goodReview.count])
                                .frame(width: 500, height: 2000)
                                .background(.green)
                                .foregroundColor(.white)
                                .scaleEffect(feedbackSize)
                                .onAppear {
                                    withAnimation (.interpolatingSpring(stiffness: 100, damping: 7)) {
                                        feedbackSize = 1
                                    }
                                }
                                .cornerRadius(50)
                            
                        } else if currentQuestionIndex != 5 && currentQuestionIndex != 0 {
                            Text(badReview[currentQuestionIndex % badReview.count])
                                .frame(width: 500, height: 2000)
                                .background(.red)
                                .foregroundColor(.white)
                                .scaleEffect(feedbackSize)
                                .onAppear {
                                    withAnimation (.interpolatingSpring(stiffness: 100, damping: 7)) {
                                        feedbackSize = 1
                                    }
                                }
                                .cornerRadius(50)
                        }
                    }
                    
                }
            }
            
            ZStack{
                
                
                if currentQuestionIndex == 5 {
                    
                    Text("You got \(numOfCorrectAnswers)/5!")
                        .frame(width: 500, height: 2000)
                        .background(.purple)
                        .foregroundColor(.white)
                        .scaleEffect(feedbackSize)
                        .shadow(color: .red, radius: 2.0)
                        .onAppear {
                            withAnimation (.interpolatingSpring(stiffness: 100, damping: 7)) {
                                feedbackSize = 1
                            }
                        }// the animation for the feedback
                        .onTapGesture {
                            currentQuestionIndex = 0
                            print(currentQuestionIndex)
                            isButtonClicked = true
                        }// click anywhere to restart
                        .onAppear {
                            withAnimation (.interpolatingSpring(stiffness: 100, damping: 7)) {
                                tapOffset = 0
                            }
                        }
                    
                    Text("Tap **anywhere** to continue")
                        .italic()
                        .offset(y: tapOffset)
                        .offset(y: 375)
                        .foregroundColor(.white)
                    
                    if numOfCorrectAnswers == 5 {
                        Image ("Correct 1")
                            .scaleEffect(0.2)
                            .offset (y: -200)
                        Text ("You're actaully a genius")
                            .offset(y: 50)
                    } else if numOfCorrectAnswers == 4 {
                        Image ("Correct 2")
                            .scaleEffect(0.9)
                            .offset(y: -200)
                        Text ("Pretty good, adam is proud,\n its way better than any of this grades ")
                            .offset(y: 50)
                    } else if numOfCorrectAnswers == 3 {
                        Image ("Wrong 3")
                            .scaleEffect(0.7)
                            .offset(y: -200)
                        Text("You tryna hold back ur tears")
                            .offset(y: 50)
                    } else if numOfCorrectAnswers == 2 {
                        Image ("Wrong 4")
                            .offset(y: -200)
                        Text("How can someone be this dumb fr??!")
                            .offset(y: 50)
                    } else if numOfCorrectAnswers == 1 {
                        Image ("Wrong 5")
                            .offset(y: -200)
                        Text("me after searching for ur correct answers")
                            .offset(y: 50)
                    } else if numOfCorrectAnswers == 0 {
                        Image ("Wrong 1")
                            .scaleEffect(0.3)
                            .offset(y: -200)
                        Text("the chicken will be u if you dont restart\n the quiz and get a better grade")
                            .offset(y: 50)
                    }// images and feedback based on how many answers were correct
                    
                    VStack {
                        ZStack{
                            Rectangle()
                                .cornerRadius(10)
                                .frame (width: 375, height: 240)
                                .offset(y: 217)
                                .foregroundColor(.yellow)
                                .shadow(color: .green, radius: 7)
                            
                            if numOfCorrectAnswers == 0 {
                                Text("no way you got **EVERYTHING** WRONG 😂🫵🏽")
                                    .offset(y: 175)
   
                            }
                            
                            Text("Correct Answers: ")
                                .bold()
                                .offset(x: -97, y: 125)
                                .foregroundColor(.white)
                                
                            
                            Text(correctAnswers.map(\.setup).joined(separator: "\n")) // Convert array to a single String
                                .offset(x: -40, y: 175)
                                .font(.system(size: 12))
                            
                            if numOfCorrectAnswers == 5 {
                                Text("wow this is quite impressive! 💐")
                                    .offset(y: 280)
   
                            }
                            
                            Text("Wrong Answers: ")
                                .bold()
                                .offset(x: -97, y: 225)
                                .foregroundColor(.white)
                            
                            Text(wrongAnswers.map(\.setup).joined(separator: "\n")) // Convert array to a single String
                                .offset(x: -40, y: 280)
                                .font(.system(size: 12))
                            
                        }
                    }
                    
                }
                
                
            }
            
        }
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().preferredColorScheme (.dark)
        
    }
}


