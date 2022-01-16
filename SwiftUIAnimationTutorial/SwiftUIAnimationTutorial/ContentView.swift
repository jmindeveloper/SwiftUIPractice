//
//  ContentView.swift
//  SwiftUIAnimationTutorial
//
//  Created by J_Min on 2022/01/16.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var blur: Bool = false
    @State private var reduction: Bool = false
    
    var body: some View {
        example08
    }
    
    var example01: some View {
        Image("DSC_2468")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .blur(radius: blur ? 5 : 0)
            .scaleEffect(reduction ? 0.7 : 1)
            .animation(.default)    // 이전 수식어에만 반영
            .onTapGesture {
                self.blur.toggle()
                self.reduction.toggle()
            }
    }
    
    var example02: some View {
        Image("DSC_2468")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .blur(radius: blur ? 5 : 0)
            .scaleEffect(reduction ? 0.7 : 1)
            .animation(.default, value: blur)    // blur값 변경시에만 에니메이션 적용
            .onTapGesture {
//                self.blur.toggle()
                self.reduction.toggle()
            }
    }
    
    var example03: some View {
        Image("DSC_2468")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleEffect(reduction ? 0.7 : 1)
            .animation(nil)         // 이 위부턴 적용안함
            .blur(radius: blur ? 5 : 0)
            .animation(.default)    // 위로 에니메이션 적용
            .onTapGesture {
                self.blur.toggle()
                self.reduction.toggle()
            }
    }
    
    var example04: some View {
        Image("DSC_2468")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleEffect(reduction ? 0.7 : 1)
            .blur(radius: blur ? 5 : 0)
            .onTapGesture {
                withAnimation { // 이 안에 있는 수식어만 에니메이션 적용
                    self.reduction.toggle()
                }
                self.blur.toggle()
            }
    }
    
    var example05: some View {
        Image("DSC_2468")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleEffect(reduction ? 0.7 : 1)
            .blur(radius: blur ? 5 : 0)
            .onTapGesture {
                withAnimation(.timingCurve(1, 0, 1, 0.13)) {
                    /*
                     .linear == 처음부터 끝까지 일정한 속도
                     .easeIn == 점점 빠르게
                     .easeOut == 점점 느리게
                     .easeInOut == 시작, 끝 느리게 중간에선 빠르게 ( 가장 많이 사용 )
                     .timingCurve == 속도 타이밍 직접 조정
                     */
                    self.reduction.toggle()
                    self.blur.toggle()
                }
            }
    }
    
    var example06: some View {
        Image("DSC_2468")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleEffect(reduction ? 0.7 : 1)
            .blur(radius: blur ? 5 : 0)
            .onTapGesture {
                withAnimation(.spring(response: 0.55, dampingFraction: 0.4, blendDuration: 0)) {
                    /*
                     response: 애니메이션 지속 시간에 대한 근사치
                     dampingFraction: 1보다 작을시 진동
                                      1보다 크면 도착시간 길어지고 진동 안생김
                                      1이면 진동 최단시간내 도착, 진동 안생김
                                      0이면 계속 진동
                                      -이면 진동 점점 커짐
                     */
                    self.reduction.toggle()
                    self.blur.toggle()
                }
            }
    }
    
    var example07: some View {
        Image("DSC_2468")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleEffect(reduction ? 0.7 : 1)
            .blur(radius: blur ? 5 : 0)
            .onTapGesture {
                withAnimation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 10, initialVelocity: 0)) {
                    /*
                     mass: 질량, 작을수록 빠르고 힘의 크기나 반동이 약하다
                                클수록 느리고 큰 힘이 가해지며 반동이 크다
                     stiffness: 스프링의 강성, 작으면 탄성이 부족하고 늘어짐
                                            크면 탄성이 크고 빠르게 요동침
                     damping: 마찰력, 작을수록 진동이 커지고 클수록 약해짐
                     initialVelocity: 애니메이션 시작시 초기에 가해지는 속도
                     */
                    self.reduction.toggle()
                    self.blur.toggle()
                }
            }
    }
    
    var example08: some View {
        /*
         애니메이션 제어
         delay: 애니메이션 지연시킨후 수행
         speed: 애니메이션을 지정한 배율만큼 곱한 속도로 수행
         repeatCount: 일정횟수 반복
         repeatForever: 무한정 실행
         autoreverses = true: 애니메이션 수행되기 전과 후의 모습을 오감
         */
        
        
        Image("DSC_2468")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .blur(radius: blur ? 5 : 0)
            .animation(Animation.default.speed(2).repeatCount(5, autoreverses: true))
            .scaleEffect(reduction ? 0.7 : 1)
            .animation(.default.delay(1))
            .animation(.default)    // 이전 수식어에만 반영
            .onTapGesture {
                self.blur.toggle()
                self.reduction.toggle()
            }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
