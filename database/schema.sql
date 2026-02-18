-- =====================================
-- TABLA: usuarios
-- =====================================

CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    rol VARCHAR(50) NOT NULL DEFAULT 'admin',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_usuarios_email ON usuarios(email);

-- =====================================
-- TABLA: clientes
-- =====================================

CREATE TABLE IF NOT EXISTS clientes (
    id SERIAL PRIMARY KEY,
    nombre_institucion VARCHAR(150) NOT NULL,
    tipo_cliente VARCHAR(100),
    responsable VARCHAR(100),
    telefono VARCHAR(20),
    direccion TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================
-- TABLA: productos
-- =====================================

CREATE TABLE IF NOT EXISTS productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    categoria VARCHAR(100),
    unidad_medida VARCHAR(50),
    precio_unitario NUMERIC(10,2) NOT NULL CHECK (precio_unitario >= 0),
    stock_actual INTEGER DEFAULT 0 CHECK (stock_actual >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================
-- TABLA: pedidos
-- =====================================

CREATE TABLE IF NOT EXISTS pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    fecha_pedido DATE DEFAULT CURRENT_DATE,
    estado VARCHAR(50) DEFAULT 'pendiente',
    total NUMERIC(12,2) DEFAULT 0 CHECK (total >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_cliente
        FOREIGN KEY(cliente_id)
        REFERENCES clientes(id)
        ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_pedidos_cliente ON pedidos(cliente_id);

-- =====================================
-- TABLA: detalle_pedidos
-- =====================================

CREATE TABLE IF NOT EXISTS detalle_pedidos (
    id SERIAL PRIMARY KEY,
    pedido_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC(10,2) NOT NULL CHECK (precio_unitario >= 0),
    subtotal NUMERIC(12,2) NOT NULL CHECK (subtotal >= 0),

    CONSTRAINT fk_pedido
        FOREIGN KEY(pedido_id)
        REFERENCES pedidos(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_producto
        FOREIGN KEY(producto_id)
        REFERENCES productos(id)
);

CREATE INDEX IF NOT EXISTS idx_detalle_pedido ON detalle_pedidos(pedido_id);
CREATE INDEX IF NOT EXISTS idx_detalle_producto ON detalle_pedidos(producto_id);