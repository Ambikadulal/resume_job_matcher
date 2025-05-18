# 🔍 Resume-Job Matcher (AI-Powered)

A Flutter app that compares a **resume** and a **job description** using **Google Generative AI (Gemini)** and shows the matching results as a summary and visual representation.

Powered by [Google's Generative AI](https://pub.dev/packages/google_generative_ai/), this app highlights matching skills, experiences, keywords, and generates a match score.

## 📱 Features

- ✨ Compare resume and job descriptions using Gemini AI
- 📊 Visual representation of match score
- 🧠 Uses `google_generative_ai` package for AI content generation
- 🔒 API key securely configured by user

### 🔐 Get Your Google Generative AI API Key

## Option 1: Google AI Studio (Quickest)

Visit: https://aistudio.google.com/app/apikey
- Sign in with your Google account
- Click Create API Key
- Copy the generated API key

## Option 2: Google Cloud Console
Visit: https://console.cloud.google.com/
- Create a new project
- Go to APIs & Services > Library
- Search for and enable the Generative Language API
- Go to APIs & Services > Credentials
- Click Create Credentials > API Key
- Copy the API key

### 🧪 How It Works

- Enter a resume and job description in the text input fields.
- The app sends the data to Gemini AI using the google_generative_ai package.
- AI compares both texts and returns:
- Key matching skills/experiences
- Overlapping keywords
- A match score (out of 100)
- Summary of relevance

### The result is displayed in:

📄 Text summary

📊 Visual chart (percent_indicator)

