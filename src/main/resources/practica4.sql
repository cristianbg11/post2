
INSERT INTO PUBLIC.USUARIO(ID, USERNAME, PASSWORD, ADMINISTRADOR, AUTOR, NOMBRE) VALUES
(0, 'admin2', '1234', TRUE, FALSE, 'cris'),
(1, 'admin', '1234', TRUE, TRUE, 'Cristian'),
(2, 'enmanuel', 'enmanuel', FALSE, FALSE, 'camacho'),
(3, 'crisfox', '123456', FALSE, FALSE, 'cristian'),
(4, 'prueba3', 'admin', FALSE, FALSE, 'pepe'),
(5, 'jasperadmin', 'jasperadmin', TRUE, FALSE, 'Cristian Bueno'),
(6, 'guest', '1234', TRUE, FALSE, 'Juan');

INSERT INTO PUBLIC.ETIQUETA(ID, ETIQUETA, ARTICULO_ID) VALUES
(3, 'Vida', 6),
(4, 'actualizada', 6),
(5, 'nuevo', 6),
(10, 'web', 8),
(11, 'jpa', 8),
(12, 'hibernate', 8),
(13, 'life', 7),
(14, 'nuevo', 7),
(15, 'web', 7),
(20, ' actualizada', 1),
(21, 'nuevo', 1);

INSERT INTO PUBLIC.COMENTARIO(ID, COMENTARIO, USUARIO_ID, ARTICULO_ID) VALUES
(1, 'bien hecho', 2, 6),
(6, 'muy buen articulo', 1, 7),
(9, 'me gusta el escrito', 5, 1),
(10, 'me gusta la tv', 5, 3),
(11, 'muy bien       ', 5, 1),
(12, 'ey hola', 5, 2);

INSERT INTO PUBLIC.ARTICULO(ID, TITULO, CUERPO, USUARIO_ID, FECHA) VALUES
(1, 'A writing', STRINGDECODE('Sadly, at time of writing, I have signally failed to find a way to slash the cost of this train ticket. Even the ingenious ticket splitting site cannot help. A house move is on the cards; it has to be. In the meantime I am medicating with sleep, homemade flapjacks and an iPod diet of Nina Simone and Dolly. Send help! You\u2019ll find me inside a TransPennine Express train just outside Huddersfield, listening to our conductor Paul explain which of the loos are out of order today.'), 1, DATE '2019-11-20'),
(2, 'hello there', STRINGDECODE('En LG ponemos a tu disposici\u00f3n televisores inteligentes con conexi\u00f3n a internet por Wi-Fi. Nuestras Smart TV te permitir\u00e1n disfrutar de una amplia gama de funcionalidades y contenidos exclusivos. Las televisiones LED de LG est\u00e1n pensadas para llevar tu experiencia de visionado a un nuevo nivel.'), 1, DATE '2019-10-09'),
(3, 'Smart TV', STRINGDECODE('En LG ponemos a tu disposici\u00f3n televisores inteligentes con conexi\u00f3n a internet por Wi-Fi. Nuestras Smart TV te permitir\u00e1n disfrutar de una amplia gama de funcionalidades y contenidos exclusivos. Las televisiones LED de LG est\u00e1n pensadas para llevar tu experiencia de visionado a un nuevo nivel.'), 1, DATE '2019-10-10'),
(6, 'Ultimos', STRINGDECODE('A very well designed and slick blog that\u2019s all about being your own boss and creating your own wealth. It\u2019s a blog with a very active podcast feed. Their podcasts are insanely popular on itunes, and no doubt they make a fair bit of money from selling ad space on those podcasts'), 1, DATE '2019-10-17'),
(7, 'web1', STRINGDECODE('One of my favourite type of Blog is the \u201ctech blog\u201d.  Now this isn\u2019t something new to blog about, as Tech bloggers have been blogging about technology news and gadget reviews in detail online since the beginning of the internet, But because it\u2019s such a vast niche, you could carve out yourself a really good angle within the tech blog sphere. The trick is to have your own take on tech and don\u2019t just follow the trend. One area which hasn\u2019t really been covered specifically is eco tech, so something to think about. Maybe a blog specifically covering tech aimed at becoming more environmentally conscious.'), 1, DATE '2019-10-11'),
(8, 'JPA', STRINGDECODE('Every entity object that is stored in the database has a primary key. Once assigned, the primary key cannot be modified. It represents the entity object as long as it exists in the database.\r\n\r\nAs an object database, ObjectDB supports implicit object IDs, so an explicitly defined primary key is not required. But ObjectDB also supports explicit standard JPA primary keys, including composite primary keys and automatic sequential value generation. This is a very powerful feature of ObjectDB that is absent from other object oriented databases.'), 5, DATE '2019-11-09');
