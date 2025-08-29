//
//  LandingPageView.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-07-25.
//
import SwiftUI
import RiveRuntime
struct LandingPageView: View {
    @State private var animate = false
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                AnimationView()
            VStack(spacing: 20) {
                //Title
                Text("calendrier")
                    .font(.DMSansS(45))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.darkGrayBackground)
                    .padding(.vertical, 80)
                    .padding(.horizontal, 50)
                    .frame(maxWidth: .infinity, alignment: .leading)
                RockingImage()
                Spacer()
                
                AnimatedTextView(animate: $animate)
                
                Spacer()

                Button("Get Started") {
                   navigateToHome = true
                }
                .font(.DMSans(.title3))
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.offWhite)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.darkGrayBackground, lineWidth: 1)
                        )
                )
                .foregroundColor(.darkGrayBackground)
                .padding(.horizontal, 50)
                .padding(.vertical, 20)
                
            }
        
        }
        .navigationDestination(isPresented: $navigateToHome) {
           HomePageView()
                .navigationBarBackButtonHidden(true)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.softCream
                .ignoresSafeArea()
        )
        .navigationBarHidden(true)
        }
    }
}


private struct AnimatedTextView: View {
    @Binding var animate: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("your creative")
                .font(.DMSans(.title))
                .foregroundColor(Color.deepBlueAccent)
                .padding(4)
                .background(
                    Color.brightYellow
                        .mask(
                            Rectangle()
                                .scaleEffect(x: animate ? 1 : 0, y: 1, anchor: .leading)
                        )
                )
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5)) { animate.toggle() }
                }
            
            Text("notebook")
                .font(.DMSans(.title))
                .foregroundColor(Color.darkGrayBackground)
        }
        .padding(.horizontal, 50)
        .frame(maxWidth: .infinity, alignment: .leading)
        .fontWeight(.semibold)
    }
}

private struct RockingImage: View {
    @State private var angle: Double = -10

    var body: some View {
        Image(.calendrierMainIcon)
            .resizable()
            .frame(width: 250, height: 250)
            .rotationEffect(.degrees(angle))
            .onAppear {
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                    angle = 10
                }
            }
    }
}

private struct AnimationView: View {
    var body: some View {
        RiveViewModel(fileName: "bkgnd").view()
    }
}

#Preview {
    LandingPageView()
        .modelContainer(for: [NoteModel.self], inMemory: true)
}

