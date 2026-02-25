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

const authRoutes = require("./routes/auth.routes");
app.use("/api/auth", authRoutes);

//ruta base
app.get('/', (req, res) => {
  res.send('AllpaSys API Running 🚀');
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Servidor corriendo en puerto ${PORT}`);
});