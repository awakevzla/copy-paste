require('dotenv').config();
const express = require('express');
const cors = require('cors');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;
const SECRET = process.env.CLIPBOARD_SECRET;

// In-memory storage
let clipboardText = '';

// Middleware
app.use(cors());
app.use(express.json({ limit: '10mb' }));
app.use(express.static(path.join(__dirname, 'public')));

// Middleware: Validate secret if defined
const validateSecret = (req, res, next) => {
  if (SECRET) {
    const providedSecret = req.headers['x-clipboard-secret'];
    if (!providedSecret || providedSecret !== SECRET) {
      return res.status(401).json({ error: 'Unauthorized' });
    }
  }
  next();
};

// Routes
app.get('/clipboard', validateSecret, (req, res) => {
  res.json({ text: clipboardText });
});

app.post('/clipboard', validateSecret, (req, res) => {
  const { text } = req.body;

  if (text === undefined || text === null) {
    return res.status(400).json({ error: 'Text is required' });
  }

  clipboardText = String(text);
  res.json({ success: true, text: clipboardText });
});

app.delete('/clipboard', validateSecret, (req, res) => {
  clipboardText = '';
  res.json({ success: true, text: '' });
});

// Root endpoint
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Start server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Clipboard server running on http://0.0.0.0:${PORT}`);
  console.log(`📍 Access from local network at http://<your-ip>:${PORT}`);
  if (SECRET) {
    console.log(`🔐 Secret validation enabled`);
  } else {
    console.log(`⚠️  No secret set (set CLIPBOARD_SECRET env var for security)`);
  }
});
