import SwiftUI
import PhotosUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            WelcomeView()
        }
    }
}

// MARK: - Pastel Theme Colors
extension Color {
    static let pastelPink = Color(red: 0.95, green: 0.8, blue: 0.85)
    static let pastelBlue = Color(red: 0.8, green: 0.9, blue: 0.95)
    static let pastelPurple = Color(red: 0.85, green: 0.8, blue: 0.9)
    static let pastelYellow = Color(red: 0.95, green: 0.9, blue: 0.8)
    static let pastelOrange = Color(red: 0.95, green: 0.85, blue: 0.8)
    static let pastelMint = Color(red: 0.8, green: 0.95, blue: 0.9)
    static let pastelLavender = Color(red: 0.9, green: 0.85, blue: 0.95)
    static let pastelPeach = Color(red: 0.95, green: 0.85, blue: 0.8)
}

// MARK: - Pastel Button Style
struct PastelButtonStyle: ButtonStyle {
    let colors: [Color]
    let textColor: Color
    
    init(colors: [Color] = [.pastelPink, .pastelBlue], textColor: Color = .primary) {
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
                            .stroke(Color.white.opacity(0.8), lineWidth: 1)
                    )
            )
            .cornerRadius(15)
            .shadow(color: colors.first?.opacity(0.2) ?? .clear, radius: 5, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3), value: configuration.isPressed)
    }
}

// MARK: - Pastel Text Field Style
struct PastelTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.system(size: 16, weight: .medium, design: .rounded))
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(LinearGradient(colors: [.pastelPink, .pastelBlue], startPoint: .leading, endPoint: .trailing), lineWidth: 1)
                    )
            )
            .shadow(color: .pastelPink.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}

// MARK: - Welcome Screen
struct WelcomeView: View {
    @State private var animateTitle = false
    @State private var animateButtons = false
    
    var body: some View {
        ZStack {
            // Pastel gradient background
            PastelGradientBackground()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Title with pastel styling
                VStack(spacing: 10) {
                    Text("")
                        .font(.system(size: 80))
                        .scaleEffect(animateTitle ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animateTitle)
                    
                    Text("ditto!")
                        .font(.system(size: 48, weight: .black, design: .serif))
                        //.foregroundStyle(
                            //  LinearGradient(colors: [.primary, .pastelPurple], startPoint: .top, endPoint: .bottom)
                        //)
                        .shadow(color: .pastelPink.opacity(0.3), radius: 2, x: 2, y: 2)
                    
                    Text("a song for a song")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
               // .offset(y: animateTitle ? -10 : 10)
                .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: animateTitle)
                
                Spacer()
                
                // Buttons with animations
                VStack(spacing: 20) {
                    NavigationLink(destination: LoginView()) {
                        Text("Log In")
                    }
                    .buttonStyle(PastelButtonStyle(colors: [.pastelPink, .pastelPurple]))
                    .opacity(animateButtons ? 1 : 0)
                    .offset(x: animateButtons ? 0 : -100)
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                    }
                    .buttonStyle(PastelButtonStyle(colors: [.pastelBlue, .pastelMint]))
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

// MARK: - Pastel Gradient Background
struct PastelGradientBackground: View {
    @State private var animateGradient = false
    
    var body: some View {
        LinearGradient(
            colors: [
                Color.white,
                .pastelLavender.opacity(0.3),
                .pastelMint.opacity(0.2),
                Color.white
            ],
            startPoint: animateGradient ? .topLeading : .bottomLeading,
            endPoint: animateGradient ? .bottomTrailing : .topTrailing
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
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
    @State private var navigateToHome = false
    
    var body: some View {
        ZStack {
            PastelGradientBackground()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    VStack(spacing: 15) {
                        Text("Welcome Back!")
                            .font(.system(size: 32, weight: .black, design: .serif))
                            .foregroundColor(.primary)
                            .shadow(color: .pastelPink.opacity(0.3), radius: 2, x: 2, y: 2)
                        
                        
                    }
                    .padding(.top, 50)
                    
                    // Form
                    VStack(spacing: 20) {
                        VStack(spacing: 15) {
                            TextField("Username", text: $username)
                                .textFieldStyle(PastelTextFieldStyle())
                            
                            HStack {
                                if showPassword {
                                    TextField("Password", text: $password)
                                        .textFieldStyle(PastelTextFieldStyle())
                                } else {
                                    SecureField("Password", text: $password)
                                        .textFieldStyle(PastelTextFieldStyle())
                                }
                                
                                Button(action: { showPassword.toggle() }) {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.pastelPink)
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
                                        .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                                        .scaleEffect(0.8)
                                } else {
                                    Text("Continue")
                                }
                            }
                        }
                        .buttonStyle(PastelButtonStyle(colors: [.pastelOrange, .pastelYellow]))
                        .disabled(username.isEmpty || password.isEmpty || isLoading)
                        .opacity(username.isEmpty || password.isEmpty ? 0.6 : 1.0)
                    }
                    .padding(.horizontal, 30)
                    
                    // Forgot Password
                    Button(action: {}) {
                        Text("Forgot Password?")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.primary)
                            .underline()
                    }
                    
                    Spacer(minLength: 50)
                }
            }
        }
        .background(
            NavigationLink(destination: AboutView(), isActive: $navigateToHome) { EmptyView() }
                .hidden()
        )
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func loginUser() {
        isLoading = true
        // Simulate login delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            navigateToHome = true
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
            PastelGradientBackground()
            
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 10) {
                        Text("join our family!")
                            .font(.system(size: 32, weight: .black, design: .serif))
                            .foregroundColor(.primary)
                            .shadow(color: .pastelBlue.opacity(0.3), radius: 2, x: 2, y: 2)
                        
                        Text("help us get to know you")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 30)
                    
                    // Personal Info Section
                    VStack(spacing: 20) {
                        SectionHeader(title: "Personal Info", icon: "person.fill")
                        
                        VStack(spacing: 15) {
                            TextField("Full Name", text: $name)
                                .textFieldStyle(PastelTextFieldStyle())
                            
                            // Custom Date Picker
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.pastelPink)
                                    Text("Birthday")
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                                        .foregroundColor(.primary)
                                }
                                
                                DatePicker("", selection: $birthday, displayedComponents: .date)
                                    .datePickerStyle(CompactDatePickerStyle())
                                    .accentColor(.pastelPink)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 15)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(LinearGradient(colors: [.pastelPink, .pastelBlue], startPoint: .leading, endPoint: .trailing), lineWidth: 1)
                                            )
                                    )
                            }
                            
                            TextField("Phone Number", text: $phone)
                                .keyboardType(.phonePad)
                                .textFieldStyle(PastelTextFieldStyle())
                        }
                    }
                    
                    // Account Section
                    VStack(spacing: 20) {
                        SectionHeader(title: "Account Setup", icon: "key.fill")
                        
                        VStack(spacing: 15) {
                            TextField("Username", text: $username)
                                .textFieldStyle(PastelTextFieldStyle())
                            
                            SecureField("Password", text: $password)
                                .textFieldStyle(PastelTextFieldStyle())
                            
                            SecureField("Confirm Password", text: $confirmPassword)
                                .textFieldStyle(PastelTextFieldStyle())
                        }
                    }
                    
                    // Next Button
                    NavigationLink(destination: ProfilePhotoView()) {
                        Text("Next Step")
                    }
                    .buttonStyle(PastelButtonStyle(colors: [.pastelMint, .pastelBlue]))
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

// MARK: - About View (Onboarding)
struct AboutView: View {
    var body: some View {
        ZStack {
            PastelGradientBackground()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 10) {
                        Text("About the App")
                            .font(.system(size: 28, weight: .black, design: .rounded))
                            .foregroundColor(.primary)
                            .shadow(color: .pastelPurple.opacity(0.3), radius: 2, x: 2, y: 2)
                        
                        Text("A daily music exchange for discovery, connection, and community.")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                    .padding(.top, 24)
                    
                    // Blurb
                    VStack(alignment: .leading, spacing: 14) {
                        Text("ditto! is a daily music exchange.")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        
                        Text("Every morning, you’ll share your song of the day. In return, you’ll get a handpicked recommendation from someone with overlapping taste. Over time, you’ll uncover new artists, moods, and friends — song by song.")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.75))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(LinearGradient(colors: [.pastelPink, .pastelBlue], startPoint: .leading, endPoint: .trailing), lineWidth: 1)
                            )
                    )
                    
                    // How it works
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "How it works", icon: "sparkles")
                        
                        VStack(spacing: 12) {
                            HowItWorksRow(emoji: "1.", text: "Post your song of the day.")
                            HowItWorksRow(emoji: "2.", text: "Get a personalized recommendation from another user.")
                            HowItWorksRow(emoji: "3.", text: "Listen, save, and build your evolving daily playlist.")
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.6))
                    )
                    
                    // Closing line
                    Text("Music isn’t an algorithm - it’s people. This is social discovery built for connection.")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                    
                    // Navigation
                    VStack(spacing: 14) {
                        NavigationLink(destination: HomeView()) {
                            Text("Continue")
                        }
                        .buttonStyle(PastelButtonStyle(colors: [.pastelYellow, .pastelOrange]))
                        
                
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HowItWorksRow: View {
    let emoji: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(emoji)
                .font(.system(size: 20))
            Text(text)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
    }
}
// MARK: - Section Header Component
struct SectionHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.pastelYellow)
                .font(.title2)
            
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
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
            PastelGradientBackground()
            
            VStack(spacing: 25) {
                // Header
                Text("Terms & Conditions")
                    .font(.system(size: 28, weight: .black, design: .rounded))
                    .foregroundColor(.primary)
                    .shadow(color: .pastelPurple.opacity(0.3), radius: 2, x: 2, y: 2)
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
                        .fill(Color.white.opacity(0.8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.white.opacity(0.5), lineWidth: 1)
                        )
                )
                .frame(height: 300)
                
                // Acceptance Toggle
                Button(action: { accepted.toggle() }) {
                    HStack(spacing: 15) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(accepted ? LinearGradient(colors: [.pastelMint, .pastelBlue], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [.gray.opacity(0.3)], startPoint: .leading, endPoint: .trailing))
                                .frame(width: 24, height: 24)
                            
                            if accepted {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.primary)
                                    .font(.system(size: 14, weight: .bold))
                            }
                        }
                        
                        Text("I accept the Terms & Conditions")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.primary)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 25)
                
                // Next Button
                NavigationLink(destination: AboutView()) {
                    Text("Continue")
                }
                .buttonStyle(PastelButtonStyle(colors: [.pastelYellow, .pastelOrange]))
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
                .foregroundColor(.pastelYellow)
            
            Text(content)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.secondary)
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
            PastelGradientBackground()
            
            VStack(spacing: 30) {
                // Header
                //Text("Show Your Style!")
                    //.font(.system(size: 28, weight: .black, design: .rounded))
                    //.foregroundColor(.primary)
                    //.shadow(color: .pastelMint, radius: 2, x: 2, y: 2)
                
                //Text("Add a profile photo to personalize your account!")
                  //  .font(.system(size: 16, weight: .medium, design: .rounded))
                    //.foregroundColor(.secondary)
                    //.multilineTextAlignment(.center)
                
                Spacer()
                
                // Profile Image Section
                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(colors: [.pastelPink.opacity(0.3), .pastelBlue.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .frame(width: 180, height: 180)
                            .overlay(
                                Circle()
                                    .stroke(LinearGradient(colors: [.pastelPink, .pastelBlue, .pastelMint], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 4)
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
                                    .foregroundColor(.secondary)
                                
                                Text("Add Photo")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .shadow(color: .pastelPink.opacity(0.3), radius: 15, x: 0, y: 10)
                    
                    // Photo Selection Buttons
                    HStack(spacing: 20) {
                        PhotosPickerButton(selectedItem: $selectedItem)
                        CameraButton(showingCamera: $showingCamera)
                    }
                }
                
                Spacer()
                
                // Navigation Buttons
                VStack(spacing: 15) {
                    NavigationLink(destination: MusicLinkView()) {
                        Text("Continue")
                    }
                    .buttonStyle(PastelButtonStyle(colors: [.pastelPurple, .pastelPink]))
                    
                    NavigationLink(destination: MusicLinkView()) {
                        Text("Skip for Now")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.secondary)
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

// MARK: - Music Link Placeholder
struct MusicLinkView: View {
    @State private var hasTappedSpotify = false
    @State private var hasTappedApple = false
    
    var body: some View {
        ZStack {
            PastelGradientBackground()
            
            VStack(spacing: 28) {
                // Header
                
               // .padding(.top, 20)
                
                Spacer(minLength: 0)
                
                // Placeholder Buttons
                VStack(spacing: 16) {
                    Button(action: { hasTappedSpotify = true }) {
                        HStack(spacing: 12) {
                            Image(systemName: "music.note.list")
                                .font(.title3)
                            Text(hasTappedSpotify ? "Spotify Linked" : "Link Spotify")
                        }
                    }
                    .buttonStyle(PastelButtonStyle(colors: [.pastelMint, .pastelBlue]))
                    
                    Button(action: { hasTappedApple = true }) {
                        HStack(spacing: 12) {
                            Image(systemName: "applelogo")
                                .font(.title3)
                            Text(hasTappedApple ? "Apple Music Linked" : "Link Apple Music")
                        }
                    }
                    .buttonStyle(PastelButtonStyle(colors: [.pastelPink, .pastelPurple]))
                }
                .padding(.horizontal, 28)
                VStack(spacing: 10) {
                    //Text("Connect Your Music")
                        //.font(.system(size: 28, weight: .black, design: .rounded))
                        //.foregroundColor(.primary)
                        //.shadow(color: .pastelBlue.opacity(0.3), radius: 2, x: 2, y: 2)
                    
                    Text("Link your Spotify or Apple Music to personalize recommendations.")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                
                
                Spacer(minLength: 0)
                
                // Navigation
                VStack(spacing: 14) {
                    NavigationLink(destination: GenreSelectionView()) {
                        Text("Continue")
                    }
                    .buttonStyle(PastelButtonStyle(colors: [.pastelYellow, .pastelOrange]))
                    
                    NavigationLink(destination: GenreSelectionView()) {
                        Text("Skip for Now")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer(minLength: 24)
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
            .foregroundColor(.primary)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                LinearGradient(colors: [.pastelBlue, .pastelMint], startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(25)
            .shadow(color: .pastelBlue.opacity(0.4), radius: 8, x: 0, y: 4)
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
            .foregroundColor(.primary)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                LinearGradient(colors: [.pastelOrange, .pastelYellow], startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(25)
            .shadow(color: .pastelOrange.opacity(0.4), radius: 8, x: 0, y: 4)
        }
    }
}

// MARK: - Genre Selection
struct GenreSelectionView: View {
    @State private var selectedGenres: Set<String> = []
    @State private var animateGenres = false
    
    let genres = [
        ("🎵", "Pop", Color.pastelPink),
        ("🎤", "Hip-Hop", Color.pastelPurple),
        ("🎸", "Rock", Color.pastelOrange),
        ("🎺", "Jazz", Color.pastelBlue),
        ("🎼", "Classical", Color.pastelMint),
        ("💫", "EDM", Color.pastelYellow),
        ("🤠", "Country", Color.pastelPeach),
        ("🌊", "Lo-Fi", Color.pastelLavender),
        ("🔥", "R&B", Color.pastelPink)
    ]
    
    var body: some View {
        ZStack {
            PastelGradientBackground()
            
            VStack(spacing: 25) {
                // Header
                VStack(spacing: 15) {
                    //Text("Your Musical DNA")
                      //  .font(.system(size: 28, weight: .black, design: .serif))
                        //.foregroundColor(.primary)
                        //.shadow(color: .pastelYellow, radius: 2, x: 2, y: 2)
                    
                    Text("Pick 3-5 genres")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
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
                    .foregroundColor(.secondary)
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
                .buttonStyle(PastelButtonStyle(colors: [.pastelMint, .pastelBlue]))
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
        ("", "Taylor Swift", Color.pastelPink),
        ("", "Kendrick Lamar", Color.pastelPurple),
        ("", "Beyoncé", Color.pastelYellow),
        ("", "The Beatles", Color.pastelBlue),
        ("", "Drake", Color.pastelOrange),
        ("", "Billie Eilish", Color.pastelMint),
        ("", "Ed Sheeran", Color.pastelPeach),
        ("", "Ariana Grande", Color.pastelLavender)
    ]
    
    var body: some View {
        ZStack {
            PastelGradientBackground()
            
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 15) {
                        //Text("Your Music Heroes")
                          //  .font(.system(size: 28, weight: .black, design: .serif))
                            //.foregroundColor(.primary)
                            //.shadow(color: .pastelOrange, radius: 2, x: 2, y: 2)
                        
                        Text("Select your top 5 artists")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
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
                                        .foregroundColor(.pastelYellow)
                                        .frame(width: 30)
                                    
                                    TextField("Artist Name", text: $artists[index])
                                        .textFieldStyle(PastelTextFieldStyle())
                                }
                                .opacity(animateArtists ? 1 : 0)
                                .offset(x: animateArtists ? 0 : -100)
                                .animation(.easeOut(duration: 0.6).delay(Double(index) * 0.1), value: animateArtists)
                            }
                        }
                    }
                    
                    // Recommended Artists Section
                    /*VStack(spacing: 20) {
                        SectionHeader(title: "Quick Picks", icon: "hand.point.up.fill")
                        
                        Text("Tap to add to your list")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                        
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
                    }*/
                    
                    // Finish Button
                    NavigationLink(destination: TermsView()) {
                        HStack {
                            Text("Complete Setup")
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title3)
                        }
                    }
                    .buttonStyle(PastelButtonStyle(colors: [.pastelMint, .pastelBlue]))
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
                        .foregroundColor(.primary)
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
    @State private var songOfTheDay: String = ""
    @State private var isSubmitting: Bool = false
    @State private var showRecommendation: Bool = false
    @State private var hasSavedToPlaylist: Bool = false
    
    // Example recommendation
    private let exampleSongTitle: String = "Sunset Lover"
    private let exampleArtistName: String = "Petit Biscuit"
    private let exampleRecommenderName: String = "Alex Kim"
    private let exampleRecommenderHandle: String = "@alex.wav"
    
    var body: some View {
        ZStack {
            PastelGradientBackground()
            
            VStack(spacing: 24) {
                Spacer()
                
                // Centered Header
                VStack(spacing: 8) {
                    
                    
                    Text("What’s your song of the day?")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                
                // Input
                VStack(spacing: 16) {
                    TextField("Song · Artist", text: $songOfTheDay)
                        .textFieldStyle(PastelTextFieldStyle())
                    
                    Button(action: submitSong) {
                        HStack {
                            if isSubmitting { ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .primary)) }
                            Text(isSubmitting ? "Posting..." : "Post Song")
                        }
                    }
                    .buttonStyle(PastelButtonStyle(colors: [.pastelMint, .pastelBlue]))
                    .disabled(songOfTheDay.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isSubmitting)
                    .opacity(songOfTheDay.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.6 : 1.0)
                }
                .padding(.horizontal, 30)
                
                // Recommendation Card
                if showRecommendation {
                    VStack(spacing: 14) {
                        HStack(alignment: .center, spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(colors: [.pastelPink, .pastelBlue], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: 44, height: 44)
                                Text(String(exampleRecommenderName.prefix(1)))
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.primary)
                            }
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Recommended for you")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                                    .foregroundColor(.secondary)
                                Text("by \(exampleRecommenderName) · \(exampleRecommenderHandle)")
                                    .font(.system(size: 13, weight: .medium, design: .rounded))
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        .padding(.bottom, 4)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(exampleSongTitle)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)
                            Text(exampleArtistName)
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                        
                        HStack(spacing: 12) {
                            Button(action: { hasSavedToPlaylist = true }) {
                                Text(hasSavedToPlaylist ? "Saved to Playlist" : "Save to Playlist")
                            }
                            .buttonStyle(PastelButtonStyle(colors: [.pastelYellow, .pastelOrange]))
                            .disabled(hasSavedToPlaylist)
                            
                            Button(action: { showRecommendation = false }) {
                                Text("Dismiss")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.7))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(LinearGradient(colors: [.pastelPink, .pastelBlue], startPoint: .leading, endPoint: .trailing), lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 24)
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
    
    private func submitSong() {
        isSubmitting = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isSubmitting = false
            songOfTheDay = ""
            showRecommendation = true
            hasSavedToPlaylist = false
        }
    }
}

#Preview {
    ContentView()
}
