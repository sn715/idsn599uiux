import SwiftUI
import PhotosUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            WelcomeView()
        }
    }
}

// MARK: - Retro Theme Colors
extension Color {
    static let retroPink = Color(red: 1.0, green: 0.41, blue: 0.71)
    static let retroBlue = Color(red: 0.0, green: 0.81, blue: 1.0)
    static let retroPurple = Color(red: 0.58, green: 0.0, blue: 1.0)
    static let retroYellow = Color(red: 1.0, green: 0.84, blue: 0.0)
    static let retroOrange = Color(red: 1.0, green: 0.45, blue: 0.0)
    static let retroMint = Color(red: 0.0, green: 1.0, blue: 0.63)
    static let darkRetro = Color(red: 0.1, green: 0.1, blue: 0.2)
    static let lightRetro = Color(red: 0.95, green: 0.95, blue: 1.0)
}

// MARK: - Custom Retro Button Style
struct RetroButtonStyle: ButtonStyle {
    let colors: [Color]
    let textColor: Color
    
    init(colors: [Color] = [.retroPink, .retroBlue], textColor: Color = .white) {
        self.colors = colors
        self.textColor = textColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .foregroundColor(textColor)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white.opacity(0.3), lineWidth: 2)
                    )
            )
            .cornerRadius(15)
            .shadow(color: colors.first?.opacity(0.5) ?? .clear, radius: 10, x: 0, y: 5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3), value: configuration.isPressed)
    }
}

// MARK: - Retro Text Field Style
struct RetroTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.system(size: 16, weight: .medium, design: .rounded))
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.9))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(LinearGradient(colors: [.retroPink, .retroBlue], startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                    )
            )
            .shadow(color: .retroPink.opacity(0.2), radius: 5, x: 0, y: 3)
    }
}

// MARK: - Welcome Screen
struct WelcomeView: View {
    @State private var animateTitle = false
    @State private var animateButtons = false
    
    var body: some View {
        ZStack {
            // Animated gradient background
            AnimatedGradientBackground()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Title with retro styling
                VStack(spacing: 10) {
                    Text("🎶")
                        .font(.system(size: 80))
                        .scaleEffect(animateTitle ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animateTitle)
                    
                    Text("MoodMusic")
                        .font(.system(size: 48, weight: .black, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(colors: [.white, .retroYellow], startPoint: .top, endPoint: .bottom)
                        )
                        .shadow(color: .retroPink.opacity(0.8), radius: 0, x: 4, y: 4)
                        .shadow(color: .retroBlue.opacity(0.6), radius: 0, x: -4, y: -4)
                    
                    Text("Feel the Beat of Tomorrow")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
                .offset(y: animateTitle ? -10 : 10)
                .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: animateTitle)
                
                Spacer()
                
                // Buttons with animations
                VStack(spacing: 20) {
                    NavigationLink(destination: LoginView()) {
                        Text("Log In")
                    }
                    .buttonStyle(RetroButtonStyle(colors: [.retroPink, .retroPurple]))
                    .opacity(animateButtons ? 1 : 0)
                    .offset(x: animateButtons ? 0 : -100)
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                    }
                    .buttonStyle(RetroButtonStyle(colors: [.retroBlue, .retroMint]))
                    .opacity(animateButtons ? 1 : 0)
                    .offset(x: animateButtons ? 0 : 100)
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.2)) {
                animateTitle = true
            }
            withAnimation(.easeOut(duration: 1.5).delay(0.5)) {
                animateButtons = true
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Animated Gradient Background
struct AnimatedGradientBackground: View {
    @State private var animateGradient = false
    
    var body: some View {
        LinearGradient(
            colors: [
                .retroPurple,
                .retroPink,
                .retroBlue,
                .retroPurple
            ],
            startPoint: animateGradient ? .topLeading : .bottomLeading,
            endPoint: animateGradient ? .bottomTrailing : .topTrailing
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}

// MARK: - Login View
struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    VStack(spacing: 15) {
                        Text("Welcome Back!")
                            .font(.system(size: 32, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: .retroPink, radius: 2, x: 2, y: 2)
                        
                        Text("Let's get groovy 🕺")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(.top, 50)
                    
                    // Form
                    VStack(spacing: 20) {
                        VStack(spacing: 15) {
                            TextField("Username", text: $username)
                                .textFieldStyle(RetroTextFieldStyle())
                            
                            HStack {
                                if showPassword {
                                    TextField("Password", text: $password)
                                        .textFieldStyle(RetroTextFieldStyle())
                                } else {
                                    SecureField("Password", text: $password)
                                        .textFieldStyle(RetroTextFieldStyle())
                                }
                                
                                Button(action: { showPassword.toggle() }) {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.retroPink)
                                        .font(.title3)
                                }
                                .padding(.trailing, 20)
                            }
                        }
                        
                        // Login Button
                        Button(action: { loginUser() }) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(0.8)
                                } else {
                                    Text("Continue")
                                }
                            }
                        }
                        .buttonStyle(RetroButtonStyle(colors: [.retroOrange, .retroYellow]))
                        .disabled(username.isEmpty || password.isEmpty || isLoading)
                        .opacity(username.isEmpty || password.isEmpty ? 0.6 : 1.0)
                    }
                    .padding(.horizontal, 30)
                    
                    // Forgot Password
                    Button(action: {}) {
                        Text("Forgot Password?")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .underline()
                    }
                    
                    Spacer(minLength: 50)
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func loginUser() {
        isLoading = true
        // Simulate login delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
        }
    }
}

// MARK: - Sign Up Flow
struct SignUpView: View {
    @State private var name = ""
    @State private var birthday = Date()
    @State private var phone = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 10) {
                        Text("Join the Vibe!")
                            .font(.system(size: 32, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: .retroBlue, radius: 2, x: 2, y: 2)
                        
                        Text("Let's create your musical journey ✨")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 30)
                    
                    // Personal Info Section
                    VStack(spacing: 20) {
                        SectionHeader(title: "Personal Info", icon: "person.fill")
                        
                        VStack(spacing: 15) {
                            TextField("Full Name", text: $name)
                                .textFieldStyle(RetroTextFieldStyle())
                            
                            // Custom Date Picker
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.retroPink)
                                    Text("Birthday")
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                                        .foregroundColor(.white)
                                }
                                
                                DatePicker("", selection: $birthday, displayedComponents: .date)
                                    .datePickerStyle(CompactDatePickerStyle())
                                    .accentColor(.retroPink)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 15)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white.opacity(0.9))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(LinearGradient(colors: [.retroPink, .retroBlue], startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                                            )
                                    )
                            }
                            
                            TextField("Phone Number", text: $phone)
                                .keyboardType(.phonePad)
                                .textFieldStyle(RetroTextFieldStyle())
                        }
                    }
                    
                    // Account Section
                    VStack(spacing: 20) {
                        SectionHeader(title: "Account Setup", icon: "key.fill")
                        
                        VStack(spacing: 15) {
                            TextField("Username", text: $username)
                                .textFieldStyle(RetroTextFieldStyle())
                            
                            SecureField("Password", text: $password)
                                .textFieldStyle(RetroTextFieldStyle())
                            
                            SecureField("Confirm Password", text: $confirmPassword)
                                .textFieldStyle(RetroTextFieldStyle())
                        }
                    }
                    
                    // Next Button
                    NavigationLink(destination: TermsView()) {
                        Text("Next Step")
                    }
                    .buttonStyle(RetroButtonStyle(colors: [.retroMint, .retroBlue]))
                    .disabled(!isFormValid)
                    .opacity(isFormValid ? 1.0 : 0.6)
                    
                    Spacer(minLength: 50)
                }
                .padding(.horizontal, 30)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var isFormValid: Bool {
        !name.isEmpty && !phone.isEmpty && !username.isEmpty &&
        !password.isEmpty && password == confirmPassword && password.count >= 6
    }
}

// MARK: - Section Header Component
struct SectionHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.retroYellow)
                .font(.title2)
            
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(.horizontal, 5)
    }
}

// MARK: - Terms & Conditions
struct TermsView: View {
    @State private var accepted = false
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack(spacing: 25) {
                // Header
                Text("Terms & Conditions")
                    .font(.system(size: 28, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .retroPurple, radius: 2, x: 2, y: 2)
                    .padding(.top, 20)
                
                // Terms Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        TermsSection(
                            title: "🎵 Music Experience",
                            content: "MoodMusic provides personalized music recommendations based on your preferences and listening habits. We use advanced algorithms to curate the perfect playlist for your mood."
                        )
                        
                        TermsSection(
                            title: "🔒 Privacy & Data",
                            content: "Your data is encrypted and secure. We never share your personal information with third parties without your consent. Your music taste is your business!"
                        )
                        
                        TermsSection(
                            title: "💫 User Conduct",
                            content: "Please use MoodMusic responsibly. Respect other users and artists. Keep the vibe positive and groovy!"
                        )
                        
                        TermsSection(
                            title: "🎼 Content Rights",
                            content: "All music content is licensed through our partners. Respect copyright and support your favorite artists."
                        )
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 20)
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                )
                .frame(height: 300)
                
                // Acceptance Toggle
                Button(action: { accepted.toggle() }) {
                    HStack(spacing: 15) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(accepted ? LinearGradient(colors: [.retroMint, .retroBlue], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [.gray.opacity(0.3)], startPoint: .leading, endPoint: .trailing))
                                .frame(width: 24, height: 24)
                            
                            if accepted {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .bold))
                            }
                        }
                        
                        Text("I accept the Terms & Conditions")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 25)
                
                // Next Button
                NavigationLink(destination: ProfilePhotoView()) {
                    Text("Continue")
                }
                .buttonStyle(RetroButtonStyle(colors: [.retroYellow, .retroOrange]))
                .disabled(!accepted)
                .opacity(accepted ? 1.0 : 0.6)
                .padding(.horizontal, 30)
                
                Spacer()
            }
            .padding(.bottom, 30)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Terms Section Component
struct TermsSection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.retroYellow)
            
            Text(content)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.9))
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.bottom, 10)
    }
}

// MARK: - Profile Photo Upload
struct ProfilePhotoView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var showingCamera = false
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack(spacing: 30) {
                // Header
                Text("Show Your Style!")
                    .font(.system(size: 28, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .retroMint, radius: 2, x: 2, y: 2)
                
                Text("Add a profile photo to personalize your account ✨")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                // Profile Image Section
                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(colors: [.retroPink.opacity(0.3), .retroBlue.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .frame(width: 180, height: 180)
                            .overlay(
                                Circle()
                                    .stroke(LinearGradient(colors: [.retroPink, .retroBlue, .retroMint], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 4)
                            )
                        
                        if let selectedImageData,
                           let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 160, height: 160)
                                .clipShape(Circle())
                        } else {
                            VStack(spacing: 10) {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white.opacity(0.7))
                                
                                Text("Add Photo")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                    }
                    .shadow(color: .retroPink.opacity(0.3), radius: 15, x: 0, y: 10)
                    
                    // Photo Selection Buttons
                    HStack(spacing: 20) {
                        PhotosPickerButton(selectedItem: $selectedItem)
                        CameraButton(showingCamera: $showingCamera)
                    }
                }
                
                Spacer()
                
                // Navigation Buttons
                VStack(spacing: 15) {
                    NavigationLink(destination: GenreSelectionView()) {
                        Text("Continue")
                    }
                    .buttonStyle(RetroButtonStyle(colors: [.retroPurple, .retroPink]))
                    
                    NavigationLink(destination: GenreSelectionView()) {
                        Text("Skip for Now")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                .padding(.horizontal, 40)
            }
            .padding(.vertical, 30)
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    selectedImageData = data
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Photo Selection Components
struct PhotosPickerButton: View {
    @Binding var selectedItem: PhotosPickerItem?
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
            HStack {
                Image(systemName: "photo.fill")
                    .font(.title3)
                Text("Gallery")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                LinearGradient(colors: [.retroBlue, .retroMint], startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(25)
            .shadow(color: .retroBlue.opacity(0.4), radius: 8, x: 0, y: 4)
        }
    }
}

struct CameraButton: View {
    @Binding var showingCamera: Bool
    
    var body: some View {
        Button(action: { showingCamera = true }) {
            HStack {
                Image(systemName: "camera.fill")
                    .font(.title3)
                Text("Camera")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                LinearGradient(colors: [.retroOrange, .retroYellow], startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(25)
            .shadow(color: .retroOrange.opacity(0.4), radius: 8, x: 0, y: 4)
        }
    }
}

// MARK: - Genre Selection
struct GenreSelectionView: View {
    @State private var selectedGenres: Set<String> = []
    @State private var animateGenres = false
    
    let genres = [
        ("🎵", "Pop", Color.retroPink),
        ("🎤", "Hip-Hop", Color.retroPurple),
        ("🎸", "Rock", Color.retroOrange),
        ("🎺", "Jazz", Color.retroBlue),
        ("🎼", "Classical", Color.retroMint),
        ("💫", "EDM", Color.retroYellow),
        ("🤠", "Country", Color.brown),
        ("🌊", "Lo-Fi", Color.indigo),
        ("🔥", "R&B", Color.red)
    ]
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack(spacing: 25) {
                // Header
                VStack(spacing: 15) {
                    Text("Your Musical DNA")
                        .font(.system(size: 28, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .retroYellow, radius: 2, x: 2, y: 2)
                    
                    Text("Pick 3-5 genres that make your soul dance 💃")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                
                // Genre Grid
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 15) {
                        ForEach(Array(genres.enumerated()), id: \.offset) { index, genre in
                            GenreCard(
                                emoji: genre.0,
                                name: genre.1,
                                color: genre.2,
                                isSelected: selectedGenres.contains(genre.1)
                            ) {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                    if selectedGenres.contains(genre.1) {
                                        selectedGenres.remove(genre.1)
                                    } else {
                                        selectedGenres.insert(genre.1)
                                    }
                                }
                            }
                            .opacity(animateGenres ? 1 : 0)
                            .offset(y: animateGenres ? 0 : 50)
                            .animation(.easeOut(duration: 0.6).delay(Double(index) * 0.1), value: animateGenres)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                // Selection Counter
                Text("\(selectedGenres.count) genres selected")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.2))
                    )
                
                // Next Button
                NavigationLink(destination: TopArtistsView()) {
                    Text("Next Step")
                }
                .buttonStyle(RetroButtonStyle(colors: [.retroMint, .retroBlue]))
                .disabled(selectedGenres.count < 3)
                .opacity(selectedGenres.count >= 3 ? 1.0 : 0.6)
                .padding(.horizontal, 40)
                
                Spacer()
            }
        }
        .onAppear {
            animateGenres = true
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Genre Card Component
struct GenreCard: View {
    let emoji: String
    let name: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Text(emoji)
                    .font(.system(size: 40))
                
                Text(name)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(isSelected ? .white : color)
            }
            .frame(height: 120)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? LinearGradient(colors: [color, color.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [Color.white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(isSelected ? Color.white : color.opacity(0.5), lineWidth: isSelected ? 3 : 2)
                    )
            )
            .shadow(color: isSelected ? color.opacity(0.5) : .clear, radius: 10, x: 0, y: 5)
            .scaleEffect(isSelected ? 1.05 : 1.0)
        }
    }
}

// MARK: - Top Artists Input
struct TopArtistsView: View {
    @State private var artists: [String] = Array(repeating: "", count: 5)
    @State private var selectedRecommended: Set<String> = []
    @State private var animateArtists = false
    
    let recommendedArtists = [
        ("🎤", "Taylor Swift", Color.retroPink),
        ("👑", "Kendrick Lamar", Color.retroPurple),
        ("💫", "Beyoncé", Color.retroYellow),
        ("🎸", "The Beatles", Color.retroBlue),
        ("🔥", "Drake", Color.retroOrange),
        ("✨", "Billie Eilish", Color.retroMint),
        ("🎵", "Ed Sheeran", Color.brown),
        ("🌟", "Ariana Grande", Color.pink)
    ]
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 15) {
                        Text("Your Music Heroes")
                            .font(.system(size: 28, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: .retroOrange, radius: 2, x: 2, y: 2)
                        
                        Text("Tell us about the artists that inspire you 🎨")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    // Manual Input Section
                    VStack(spacing: 20) {
                        SectionHeader(title: "Your Top 5 Artists", icon: "star.fill")
                        
                        VStack(spacing: 15) {
                            ForEach(0..<5, id: \.self) { index in
                                HStack {
                                    Text("\(index + 1)")
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                        .foregroundColor(.retroYellow)
                                        .frame(width: 30)
                                    
                                    TextField("Artist Name", text: $artists[index])
                                        .textFieldStyle(RetroTextFieldStyle())
                                }
                                .opacity(animateArtists ? 1 : 0)
                                .offset(x: animateArtists ? 0 : -100)
                                .animation(.easeOut(duration: 0.6).delay(Double(index) * 0.1), value: animateArtists)
                            }
                        }
                    }
                    
                    // Recommended Artists Section
                    VStack(spacing: 20) {
                        SectionHeader(title: "Quick Picks", icon: "hand.point.up.fill")
                        
                        Text("Tap to add to your list")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.7))
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 12) {
                            ForEach(Array(recommendedArtists.enumerated()), id: \.offset) { index, artist in
                                RecommendedArtistCard(
                                    emoji: artist.0,
                                    name: artist.1,
                                    color: artist.2,
                                    isSelected: selectedRecommended.contains(artist.1)
                                ) {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                        toggleRecommendedArtist(artist.1)
                                    }
                                }
                                .opacity(animateArtists ? 1 : 0)
                                .offset(y: animateArtists ? 0 : 50)
                                .animation(.easeOut(duration: 0.6).delay(0.5 + Double(index) * 0.08), value: animateArtists)
                            }
                        }
                    }
                    
                    // Finish Button
                    NavigationLink(destination: HomeView()) {
                        HStack {
                            Text("Complete Setup")
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title3)
                        }
                    }
                    .buttonStyle(RetroButtonStyle(colors: [.retroMint, .retroBlue]))
                    .disabled(!hasValidArtists)
                    .opacity(hasValidArtists ? 1.0 : 0.6)
                    .padding(.horizontal, 40)
                    
                    Spacer(minLength: 30)
                }
                .padding(.horizontal, 30)
            }
        }
        .onAppear {
            animateArtists = true
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var hasValidArtists: Bool {
        let manualArtists = artists.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        return manualArtists.count + selectedRecommended.count >= 3
    }
    
    private func toggleRecommendedArtist(_ artist: String) {
        if selectedRecommended.contains(artist) {
            selectedRecommended.remove(artist)
        } else {
            // Add to recommended and also add to the first available slot in manual input
            selectedRecommended.insert(artist)
            if let emptyIndex = artists.firstIndex(where: { $0.trimmingCharacters(in: .whitespaces).isEmpty }) {
                artists[emptyIndex] = artist
            }
        }
    }
}

// MARK: - Recommended Artist Card
struct RecommendedArtistCard: View {
    let emoji: String
    let name: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Text(emoji)
                    .font(.system(size: 24))
                
                Text(name)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(isSelected ? .white : color)
                    .lineLimit(1)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(isSelected ? LinearGradient(colors: [color, color.opacity(0.8)], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color.white.opacity(0.1)], startPoint: .leading, endPoint: .trailing))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(isSelected ? Color.white : color.opacity(0.6), lineWidth: isSelected ? 2 : 1)
                    )
            )
            .shadow(color: isSelected ? color.opacity(0.4) : .clear, radius: 5, x: 0, y: 3)
            .scaleEffect(isSelected ? 1.02 : 1.0)
        }
    }
}

// MARK: - Home Screen
struct HomeView: View {
    @State private var animateElements = false
    @State private var showConfetti = false
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            // Confetti Effect
            if showConfetti {
                ConfettiView()
            }
            
            VStack(spacing: 30) {
                Spacer()
                
                // Welcome Message
                VStack(spacing: 20) {
                    Text("🎉")
                        .font(.system(size: 80))
                        .scaleEffect(animateElements ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: animateElements)
                    
                    Text("Welcome to")
                        .font(.system(size: 24, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                        .opacity(animateElements ? 1 : 0)
                    
                    Text("MoodMusic!")
                        .font(.system(size: 42, weight: .black, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(colors: [.white, .retroYellow], startPoint: .top, endPoint: .bottom)
                        )
                        .shadow(color: .retroPink.opacity(0.8), radius: 0, x: 4, y: 4)
                        .shadow(color: .retroBlue.opacity(0.6), radius: 0, x: -4, y: -4)
                        .scaleEffect(animateElements ? 1.05 : 1.0)
                    
                    Text("Your personalized music journey starts now! ✨\nGet ready to discover new vibes and rediscover old favorites.")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .opacity(animateElements ? 1 : 0)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
                
                // Action Buttons
                VStack(spacing: 15) {
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "play.circle.fill")
                                .font(.title2)
                            Text("Start Listening")
                        }
                    }
                    .buttonStyle(RetroButtonStyle(colors: [.retroPink, .retroPurple]))
                    .opacity(animateElements ? 1 : 0)
                    .offset(y: animateElements ? 0 : 50)
                    
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "person.circle")
                                .font(.title2)
                            Text("Customize Profile")
                        }
                    }
                    .buttonStyle(RetroButtonStyle(colors: [.retroBlue, .retroMint]))
                    .opacity(animateElements ? 1 : 0)
                    .offset(y: animateElements ? 0 : 50)
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation(.easeOut(duration: 1.5)) {
                animateElements = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showConfetti = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                showConfetti = false
            }
        }
    }
}

// MARK: - Confetti Effect
struct ConfettiView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            ForEach(0..<50, id: \.self) { index in
                ConfettiPiece()
                    .offset(
                        x: animate ? CGFloat.random(in: -200...200) : CGFloat.random(in: -50...50),
                        y: animate ? CGFloat.random(in: 300...800) : CGFloat.random(in: -100...0)
                    )
                    .rotationEffect(.degrees(animate ? Double.random(in: 0...360) : 0))
                    .animation(.easeOut(duration: Double.random(in: 2...4)).delay(Double.random(in: 0...1)), value: animate)
            }
        }
        .onAppear {
            animate = true
        }
    }
}

struct ConfettiPiece: View {
    let colors: [Color] = [.retroPink, .retroBlue, .retroYellow, .retroMint, .retroOrange, .retroPurple]
    
    var body: some View {
        Rectangle()
            .fill(colors.randomElement() ?? .retroPink)
            .frame(width: 8, height: 8)
            .cornerRadius(2)
    }
}

#Preview {
    ContentView()
}
