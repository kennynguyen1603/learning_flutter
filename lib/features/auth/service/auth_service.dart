import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    hostedDomain: "", // Allow any domain
    clientId:
        "967719220804-35p45ahsplqqal8nkbdfeldvsuqq76os.apps.googleusercontent.com", // iOS client ID
  );

  Future<UserCredential?> signInWithGoogle() async {
    try {
      debugPrint('Starting Google Sign In process...');

      // Check if device is online
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isEmpty || result[0].rawAddress.isEmpty) {
          throw Exception('No internet connection');
        }
        debugPrint('Internet connection available');
      } catch (_) {
        debugPrint('No internet connection available');
        throw Exception('Please check your internet connection and try again');
      }

      // Ensure clean auth state
      debugPrint('Cleaning up previous auth state...');
      await _auth.signOut();
      await _googleSignIn.signOut();
      await Future.delayed(const Duration(seconds: 1)); // Give time for cleanup

      // Trigger the authentication flow
      debugPrint('Initiating Google Sign In...');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      debugPrint('Google Sign In result: ${googleUser?.email ?? 'null'}');

      if (googleUser == null) {
        debugPrint('Google Sign In was cancelled by user');
        throw Exception('Google Sign In was cancelled by user');
      }

      debugPrint('Getting auth details...');
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      debugPrint(
          'Got auth details. Access token exists: ${googleAuth.accessToken != null}');

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        debugPrint('Failed to get Google Auth tokens');
        throw Exception('Failed to get Google Auth tokens');
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      debugPrint('Created Firebase credential');

      // Try to sign in with credential
      try {
        debugPrint('Attempting to sign in with Firebase...');
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        debugPrint('Firebase sign in completed');

        if (userCredential.user == null) {
          debugPrint('Failed to get user information');
          throw Exception('Failed to get user information');
        }

        debugPrint('Successfully signed in: ${userCredential.user?.email}');
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // Handle linking accounts if needed
          debugPrint('Account exists with different credential');
          throw Exception(
              'This email is already associated with a different sign-in method');
        }
        rethrow;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth Error: ${e.code} - ${e.message}');
      rethrow;
    } on SocketException catch (e) {
      debugPrint('Network Error: $e');
      throw Exception(
          'Network connection error. Please check your internet connection.');
    } on Exception catch (e) {
      debugPrint('Error signing in with Google: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      debugPrint('Signing out...');
      await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
      debugPrint('Successfully signed out');
    } catch (e) {
      debugPrint('Error signing out: $e');
      rethrow;
    }
  }
}
