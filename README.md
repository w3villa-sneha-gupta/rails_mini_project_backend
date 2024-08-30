# README

Name of the project:-Nxtrendz


Functionality:-



Home page


In Home page I have added navbar with contain signup and sign in route which redirects to respective page


<img src="./app/assets/images/home.png">





1. Signup

This is the sign up page in which user required to input email,password, profile picture and mobile number

<img src="./app/assets/images/signup.png">


   
2.Email verification (As confirmation link is send to the user's email)

User required to do email verification ,when sign up button is clicked it sends email confirmation link to user's gmail then when user clicks on confirmation link then email is verified successfully
3.Phone verification through otp using Twilio

when email verification is done,it sends otp to mobile number then user required to verify otp if otp is not received you can resend otp and verify accordingly.I have also implemented such that otp expires after 1 min then user required to resend otp.
Social login

4.Gmail login using Google auth

Gmail login is implemented using Omniauth

<img src="./app/assets/images/gmaillogin1.png">
<img src="./app/assets/images/gmaillogin2.png">
5.Facebook login

facebook login is implemented using omniauth 
<img src="./app/assets/images/facebookpage.png">

6.Sign in 

User allowed to login only when email and otp is verified 

<img src="./app/assets/images/signin.png">

dashboard page
<img src="./app/assets/images/dashboard.png">
7.Sign out

8.Profile picture upload

<img src="./app/assets/images/profileimage.png">

Course plan page

.Basic plan
.Silver plan
.Platinum plan

<img src="./app/assets/images/plan.png">
9.Payment gateway using Stripe

<img src="./app/assets/images/payment.png">

Payment successful page

<img src="./app/assets/images/paymentsuccessful.png">



