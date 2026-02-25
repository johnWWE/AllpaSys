const verificarAdmin = (req, res, next) => {
  try {
    if (!req.usuario) {
      return res.status(401).json({ error: 'No autenticado' });
    }

    if (req.usuario.rol !== 'admin') {
      return res.status(403).json({ error: 'Acceso denegado: solo admin' });
    }

    next();
  } catch (error) {
    return res.status(500).json({ error: 'Error en validación de rol' });
  }
};

module.exports = {
  verificarAdmin
};