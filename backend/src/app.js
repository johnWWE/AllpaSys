const express = require('express');
require('./config/db');

const app = express();

app.use(express.json());

app.get('/', (req, res) => {
  res.send('AllpaSys API Running 🚀');
});

const PORT = 3000;

app.listen(PORT, () => {
  console.log(`Servidor corriendo en puerto ${PORT}`);
});

const pool = require('./config/db');

app.get('/usuarios', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM usuarios');
    res.json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error al obtener usuarios' });
  }
});
