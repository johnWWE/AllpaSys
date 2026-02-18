const express = require('express');
require('./config/db');

const app = express();

app.use(express.json());

app.get('/', (req, res) => {
  res.send('AllpaSys API Running 🚀');
});

const PORT = 3000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
