CREATE TABLE users
(
  username text NOT NULL,
  role text NOT NULL,
  age integer NOT NULL,
  state text NOT NULL,
  CONSTRAINT users_pkey PRIMARY KEY (username)
)

CREATE TABLE categories
(
  category text NOT NULL,
  description text,
  CONSTRAINT pkey_category PRIMARY KEY (category)
)

CREATE TABLE products
(
  name text NOT NULL,
  sku text NOT NULL,
  category text NOT NULL,
  price numeric NOT NULL, -- has to be non-negitive...
  CONSTRAINT products_pkey PRIMARY KEY (sku),
  CONSTRAINT "product-category-fkey" FOREIGN KEY (category)
      REFERENCES categories (category) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT chk_non_negative_values CHECK (price > 0::numeric)
)

CREATE TABLE orders
(
  id serial NOT NULL,
  username text,
  productsku text,
  quantity integer,
  CONSTRAINT "id-pkey" PRIMARY KEY (id),
  CONSTRAINT "product-pkey" FOREIGN KEY (productsku)
      REFERENCES products (sku) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT "user-pkey" FOREIGN KEY (username)
      REFERENCES users (username) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)