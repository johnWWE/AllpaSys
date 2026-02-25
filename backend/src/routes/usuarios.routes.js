/** backend/src/routes/usuarios.routes.js */
const express = require('express');
const router = express.Router();
const { loginUsuario } = require('../controllers/usuarios.controller');
const { verificarToken } = require('../middlewares/auth.middleware');
const { verificarAdmin } = require('../middlewares/rol.middleware');

router.post('/login', loginUsuario);

// Ruta protegida
router.get('/perfil', verificarToken, (req, res) => {
  res.json({
    mensaje: 'Acceso autorizado',
    usuario: req.usuario
  });
});
// Ruta solo para admin
router.get(
  '/admin-only',
  verificarToken,
  verificarAdmin,
  (req, res) => {
    res.json({
      mensaje: 'Bienvenido administrador',
      usuario: req.usuario
    });
  }
);

module.exports = router;