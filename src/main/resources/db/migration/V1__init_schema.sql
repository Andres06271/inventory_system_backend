-- ==========================================
-- V1__init_schema.sql
-- Inventory Management - Initial Schema
-- PostgreSQL
-- ==========================================

-- =========================
-- ROLES (table, not enum)
-- =========================
CREATE TABLE roles
(
    role_id     BIGSERIAL PRIMARY KEY,
    role_name   VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);

-- =========================
-- USERS (email + password)
-- =========================
CREATE TABLE users
(
    user_id       BIGSERIAL PRIMARY KEY,
    full_name     VARCHAR(150) NOT NULL,
    email         VARCHAR(150) NOT NULL UNIQUE,
    phone         VARCHAR(30),
    password_hash VARCHAR(255) NOT NULL,
    is_active     BOOLEAN      NOT NULL DEFAULT TRUE,
    role_id       BIGINT       NOT NULL,
    created_at    TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP,

    CONSTRAINT fk_users_role
        FOREIGN KEY (role_id)
            REFERENCES roles (role_id)
);

-- =========================
-- CUSTOMERS
-- =========================
CREATE TABLE customers
(
    customer_id BIGSERIAL PRIMARY KEY,
    full_name   VARCHAR(150) NOT NULL,
    phone       VARCHAR(30),
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- =========================
-- PRODUCTS
-- Enums as INTEGER:
--   size -> INTEGER (nullable)
--   status -> INTEGER (not null)
-- brand/location/color -> VARCHAR (free text)
-- =========================
CREATE TABLE products
(
    product_id     BIGSERIAL PRIMARY KEY,
    product_code   VARCHAR(100)   NOT NULL UNIQUE, -- CUP
    name           VARCHAR(150)   NOT NULL,

    product_type   INTEGER        NOT NULL,        -- enum ProductType

    -- Optional characteristics (nullable)
    size           VARCHAR(100),
    color          VARCHAR(50),
    brand          VARCHAR(100),
    location       VARCHAR(100),

    -- Physical dimensions (nullable)
    width          NUMERIC(10, 2),
    height         NUMERIC(10, 2),
    depth          NUMERIC(10, 2),

    status         INTEGER        NOT NULL,        -- enum ProductStatus

    purchase_price NUMERIC(10, 2) NOT NULL CHECK (purchase_price >= 0),
    sale_price     NUMERIC(10, 2) NOT NULL CHECK (sale_price >= 0),
    stock_quantity INTEGER        NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),

    created_at     TIMESTAMP      NOT NULL DEFAULT NOW(),
    updated_at     TIMESTAMP,

    -- Soft enum guards (avoid garbage values)
    CONSTRAINT chk_product_type_range CHECK (product_type >= 0 AND product_type <= 99),
    CONSTRAINT chk_status_range CHECK (status >= 0 AND status <= 99),

    -- Dimensions must be positive if present
    CONSTRAINT chk_dimensions_positive CHECK (
        (width  IS NULL OR width  > 0) AND
        (height IS NULL OR height > 0) AND
        (depth  IS NULL OR depth  > 0)
    )
);


-- =========================
-- SALES
-- status as INTEGER enum
-- =========================
CREATE TABLE sales
(
    sale_id     BIGSERIAL PRIMARY KEY,
    customer_id BIGINT,
    created_by  BIGINT         NOT NULL,

    total       NUMERIC(10, 2) NOT NULL CHECK (total >= 0),
    paid_total  NUMERIC(10, 2) NOT NULL DEFAULT 0 CHECK (paid_total >= 0),

    status      INTEGER        NOT NULL, -- enum ordinal in Java
    created_at  TIMESTAMP      NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_sales_customer
        FOREIGN KEY (customer_id)
            REFERENCES customers (customer_id),

    CONSTRAINT fk_sales_user
        FOREIGN KEY (created_by)
            REFERENCES users (user_id),

    CONSTRAINT chk_sales_status_range CHECK (status >= 0 AND status <= 99),
    CONSTRAINT chk_sales_paid_not_over_total CHECK (paid_total <= total)
);

-- =========================
-- SALE_ITEMS (composite PK)
-- unit_price: sale price at the moment
-- unit_cost: purchase cost at the moment (profit analytics)
-- =========================
CREATE TABLE sale_items
(
    sale_id    BIGINT         NOT NULL,
    product_id BIGINT         NOT NULL,

    quantity   INTEGER        NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0),
    unit_cost  NUMERIC(10, 2) NOT NULL CHECK (unit_cost >= 0),

    PRIMARY KEY (sale_id, product_id),

    CONSTRAINT fk_sale_items_sale
        FOREIGN KEY (sale_id)
            REFERENCES sales (sale_id),

    CONSTRAINT fk_sale_items_product
        FOREIGN KEY (product_id)
            REFERENCES products (product_id)
);

-- =========================
-- PAYMENTS
-- method as INTEGER enum
-- =========================
CREATE TABLE payments
(
    payment_id  BIGSERIAL PRIMARY KEY,
    sale_id     BIGINT         NOT NULL,
    customer_id BIGINT,
    created_by  BIGINT         NOT NULL,

    amount      NUMERIC(10, 2) NOT NULL CHECK (amount > 0),
    method      INTEGER        NOT NULL, -- enum ordinal in Java
    notes       VARCHAR(255),

    created_at  TIMESTAMP      NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_payments_sale
        FOREIGN KEY (sale_id)
            REFERENCES sales (sale_id),

    CONSTRAINT fk_payments_customer
        FOREIGN KEY (customer_id)
            REFERENCES customers (customer_id),

    CONSTRAINT fk_payments_user
        FOREIGN KEY (created_by)
            REFERENCES users (user_id),

    CONSTRAINT chk_payments_method_range CHECK (method >= 0 AND method <= 99)
);

-- =========================
-- INVENTORY_MOVEMENTS
-- movement_type as INTEGER enum
-- reference_type/reference_id are generic linking (e.g. SALE)
-- =========================
CREATE TABLE inventory_movements
(
    movement_id    BIGSERIAL PRIMARY KEY,
    product_id     BIGINT    NOT NULL,
    created_by     BIGINT    NOT NULL,

    movement_type  INTEGER   NOT NULL, -- enum ordinal in Java
    quantity       INTEGER   NOT NULL CHECK (quantity > 0),

    reference_type INTEGER NOT NULL,
    reference_id   BIGINT,

    notes          VARCHAR(255),
    created_at     TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
            REFERENCES products (product_id),

    CONSTRAINT fk_inventory_user
        FOREIGN KEY (created_by)
            REFERENCES users (user_id),

    CONSTRAINT chk_inventory_movement_type_range CHECK (movement_type >= 0 AND movement_type <= 99)
);