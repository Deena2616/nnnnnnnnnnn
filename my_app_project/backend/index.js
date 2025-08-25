
const express = require('express');
const admin = require('firebase-admin');
const cors = require('cors');
const dotenv = require('dotenv');
const path = require('path');

// Load environment variables
dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

// Enable CORS for all routes
app.use(cors({
  origin: '*',
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));

app.use(express.json({ limit: '10mb' }));

// Initialize Firebase
let db;
try {
  // Check if Firebase service account is provided
  if (!process.env.FIREBASE_SERVICE_ACCOUNT) {
    console.error('FIREBASE_SERVICE_ACCOUNT environment variable is not set');
    process.exit(1);
  }

  // Parse the Firebase service account JSON from environment variable
  const serviceAccount = JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT);

  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
  });

  db = admin.firestore();
  console.log('Firebase initialized successfully');
} catch (error) {
  console.error('Failed to initialize Firebase:', error.message);
  process.exit(1);
}

// Form submission endpoint
app.post('/submit-form', async (req, res) => {
  try {
    console.log('Received form data:', req.body);
    const formData = req.body;

    // Add timestamp to the form data
    formData.submittedAt = admin.firestore.FieldValue.serverTimestamp();

    // Save to Firestore
    const docRef = await db.collection('form_submissions').add(formData);
    console.log('Form submitted with ID:', docRef.id);

    res.status(200).json({
      success: true,
      id: docRef.id,
      message: 'Form submitted successfully'
    });
  } catch (error) {
    console.error('Error submitting form:', error);
    res.status(500).json({
      success: false,
      error: error.message
    });
  }
});

// Get all form submissions
app.get('/form-submissions', async (req, res) => {
  try {
    const snapshot = await db.collection('form_submissions').orderBy('submittedAt', 'desc').get();
    const submissions = [];

    snapshot.forEach(doc => {
      submissions.push({
        id: doc.id,
        ...doc.data()
      });
    });

    res.status(200).json({
      success: true,
      submissions: submissions
    });
  } catch (error) {
    console.error('Error fetching form submissions:', error);
    res.status(500).json({
      success: false,
      error: error.message
    });
  }
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'OK',
    firebase: 'Initialized'
  });
});

// Start server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
