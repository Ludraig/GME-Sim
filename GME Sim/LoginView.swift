import SwiftUI

enum DemirAlert {
case demir, vesvich, dgir, ironsheldonrailroad, stultoman, FleuveNil, topofhead, eliza
}

struct LoginView: View {
    @State var showingSignup = false // pour alterner entre sign in et sign up
    @State var showingFinishReg = false
    @Environment(\.presentationMode) var presentationMode
    
    @State var email = ""
    @State var password = ""
    @State var repeatPassword = ""
    @State private var showAlert = false
    @State private var demirAlert:DemirAlert = .demir



    
    var body: some View {
        
        VStack {
            Text("Sign In")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.bottom, .top], 20)
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    TextField("Enter your email", text: $email)
                    Divider()
                    Text("Password (Min 6 chars.)")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    SecureField("Enter your password", text: $password)
                    Divider()
                    
                    if showingSignup {
                        Text("Repeat Password")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(Color.init(.label))
                            .opacity(0.75)
                        
                        SecureField("Repeat password", text: $repeatPassword)
                        Divider()
                    }
                }
                .alert(isPresented: $showAlert) {
                    switch demirAlert {
                    case.demir:
                   return  Alert(title: Text("Log In Failure "), message: Text("You failed to log in. Verify your info, and try again!"), dismissButton: .default(Text("I admit I am a failure.")))
                    case.vesvich:
                    return Alert(title: Text("Error registering user "), message: Text("You failed to resgister an account. Verify your info, and try again!"), dismissButton: .default(Text("I admit I am a failure")))
                    case.dgir:
                    return Alert(title: Text("user created "), message: Text("You created your user. Thank you for shopping GameStop! Please check your email to verify your account."), dismissButton: .default(Text("I will enjoy my time shopping for Demir Photos and GME Stock")))
                    case.ironsheldonrailroad:
                    return Alert(title: Text("Password not match "), message: Text("You failed to match your passwords. Verify your info, and try again!"), dismissButton: .default(Text("I admit I am a failure")))
                    case.stultoman:
                    return Alert(title: Text("email password set "), message: Text("You failed to set your email and password. Verify your info, and try again!"), dismissButton: .default(Text("I admit I am a failure")))
                    case.FleuveNil:
                    return Alert(title: Text("Error sending reset "), message: Text("You failed to get a reset password email. Verify your info, and try again!"), dismissButton: .default(Text("I admit I am a failure")))
                    case.topofhead:
                    return Alert(title: Text("check email "), message: Text("Please check your email for verification!"), dismissButton: .default(Text("I will enjoy my time shopping for Demir Photos and GME Stock")))
                    case.eliza:
                    return Alert(title: Text("empty email "), message: Text("You failed to input a proper email. Verify your info, and try again!"), dismissButton: .default(Text("I admit I am a failure")))
                    }
                }
                .padding(.bottom, 15)
                .animation(.easeOut(duration: 0.1))
                //Fin du VStack
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.resetPassword()
                    }, label: {
                        Text("Forgot Password?")
                            .foregroundColor(Color.gray.opacity(0.5))
                    })
                }//Fin du HStack
                
            } .padding(.horizontal, 6)
            //Fin du VStack
            Button(action: {

                self.showingSignup ? self.signUpUser() : self.loginUser()
            }, label: {
                Text(showingSignup ? "Sign Up" : "Sign In")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 120)
                    .padding()
            }) //Fin du  Button
                .background(Color.blue)
                .clipShape(Capsule())
                .padding(.top, 45)
            
            SignUpView(showingSignup: $showingSignup)
        }//Fin du VStack
        .sheet(isPresented: $showingFinishReg)
        {
            FinishRegistrationView()
        }
        
    }//Fin du body

    private func loginUser()
    {// à compléter
        if email != "" && password != "" {
                    FUser.loginUserWith(email: email, password: password) { (error, isEmailVerified) in
                        
                        if error != nil {
                            demirAlert = .demir
                            self.showAlert.toggle()
                            return
                        }
                        //permettre d'ouvrir la fenêtre pour finaliser l'enregistrement si ce n'est pas encore fait
                        if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                            self.presentationMode.wrappedValue.dismiss() // fermer la fenêtre qui est en mode présentation
                        } else {
                            self.showingFinishReg.toggle()
                        }
                    }
                }

        
    }
    private func signUpUser()
    {
        if email != "" && password != "" && repeatPassword != "" {
            if password == repeatPassword {
                
                FUser.registerUserWith(email: email, password: password) { (error) in
                    
                    if error != nil {
                        demirAlert = .vesvich
                        self.showAlert.toggle()
                        return
                    }
                    demirAlert = .dgir
                    self.showAlert.toggle()
                    self.showingFinishReg.toggle()
                    //retourner à l'application
                    //vérifier si onBoard a été fait
                }

                
            } else {
                demirAlert = .ironsheldonrailroad
                self.showAlert.toggle()
            }
            
            
        } else {
            demirAlert = .stultoman
            self.showAlert.toggle()
            
        }
        
        
    }
    private func resetPassword()
    {
        if email != ""
        {
            FUser.resetPassword(email: email)
            {(error) in
                if error != nil
                {
                    demirAlert = .FleuveNil
                    self.showAlert.toggle()
                    return
                }
                demirAlert = .topofhead
                self.showAlert.toggle()
            }
        }
        else
        {
            demirAlert = .eliza
            self.showAlert.toggle()
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct SignUpView : View {
    @Binding var showingSignup: Bool
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 8) {
                Text("Don't have an Account?")
                    .foregroundColor(Color.gray.opacity(0.5))
                Button(action: {
                    self.showingSignup.toggle()
                }, label: {
                    Text("Sign Up")
                })
                    .foregroundColor(.blue)
            }//Fin de HStack
                .padding(.top, 25)
        } //Fin de VStack
    }
}
