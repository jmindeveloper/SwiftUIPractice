//
//  ContentView.swift
//  SwiftUITransitionTutorial
//
//  Created by J_Min on 2022/01/16.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    /*
     트랜지션은 뷰 계층 구조에 새로운 뷰가 추가되거나 기존에 있던것이 제거될때
     적용되는 애니메이션의 한 종류
     */
    
    @State private var showText = false
    
    var body: some View {
        example05
    }
    
    // 기본
    var example01: some View {
        VStack {
            if showText {
                Text("Transition")
                    .font(.largeTitle).bold()
                    .padding()
            }
            
            Button {
                withAnimation(.default.speed(0.5)) {
                    self.showText.toggle()
                }
            } label: {
                Text("Display Text On/Off")
            }
            .font(.title)

        }
        // 트랜지션의 기본 효과는 페이드인/아웃
    }
    
    // 트랜지션
    var example02: some View {
        VStack {
            if showText {
                Text("Transition")
                    .font(.largeTitle).bold()
                    .padding()
                    .transition(.move(edge: .top))
                    /*
                     트랜지션 유형
                     opacity: fade in/out, default
                     scale: 뷰의 배율 조절
                     slide: 삽입시 좌측, 제거시 우측으로
                     move: 상하좌우중 한 방향 지정, 그 방향으로 나타나거나 사라짐
                     offset: x, y 좌표 혹은 CGSize 전달하여 그 위치로 움직임
                     */
                
            }
            
            Button {
                withAnimation(.default.speed(0.5)) {
                    self.showText.toggle()
                }
            } label: {
                Text("Display Text On/Off")
            }
            .font(.title)

        }
    }
    
    // 트랜지션 합성
    // combined: 서로 다른 전환 효과들을 하나의 효과로 합성
    var example03: some View {
        VStack {
            if showText {
                Text("Transition")
                    .font(.largeTitle).bold()
                    .padding()
                    .transition(.scale.combined(with: .slide))
            }
            
            Button {
                withAnimation(.default.speed(0.5)) {
                    self.showText.toggle()
                }
            } label: {
                Text("Display Text On/Off")
            }
            .font(.title)

        }
    }

    // asymmetric
    var myTransition: AnyTransition {
        let insertion = AnyTransition.offset(x: 300, y: -300).combined(with: .scale)
        let removal = AnyTransition.move(edge: .leading)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    var example04: some View {
        
        VStack {
            if showText {
                Text("Transition")
                    .font(.largeTitle).bold()
                    .padding()
                    .transition(myTransition)
            }
            
            Button {
                withAnimation(.default.speed(0.5)) {
                    self.showText.toggle()
                }
            } label: {
                Text("Display Text On/Off")
            }
            .font(.title)
        }
    }
    
    // modifier
    struct CustomScaleModifier: ViewModifier {
        let scale: CGFloat
        func body(content: Content) -> some View {
            content
                .scaleEffect(scale)
        }
    } // 모디파이어 만들고 active 및 identity에 값 지정
    
    var example05: some View {
        VStack {
            if showText {
                Text("Transition")
                    .font(.largeTitle).bold()
                    .padding()
                    .transition(.modifier(active: CustomScaleModifier(scale: 0), identity: CustomScaleModifier(scale: 1)))
            }
            
            Button {
                withAnimation(.default.speed(0.5)) {
                    self.showText.toggle()
                }
            } label: {
                Text("Display Text On/Off")
            }
            .font(.title)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
