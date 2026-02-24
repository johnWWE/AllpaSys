/*backend/src/app.js */
const express = require('express');
require('dotenv').config(); // 🔥 IMPORTANTE
require('./config/db');

const app = express();

// Middleware
app.use(express.json());

// Rutas
const usuariosRoutes = require('./routes/usuarios.routes');
app.use('/api/usuarios', usuariosRoutes);

app.get('/', (req, res) => {
  res.send('AllpaSys API Running 🚀');
});

const PORT = 3000;

app.listen(PORT, () => {
  console.log(`Servidor corriendo en puerto ${PORT}`);
});