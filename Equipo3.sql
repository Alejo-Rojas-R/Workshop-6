# CREACION DE LA BASE DE DATOS
CREATE DATABASE Workshop6;

USE Workshop6;
#DROP DATABASE Workshop6;
CREATE TABLE Usuarios(
	Id_usuario int NOT NULL AUTO_INCREMENT,
	Nombre varchar(10),
    Apellido varchar(10),
    Nombre_de_usuario varchar(20),
    Correo_electronico varchar(50),
    PRIMARY KEY (Id_usuario)
);

CREATE TABLE Publicaciones(
	Id_publicacion int NOT NULL AUTO_INCREMENT,
	Contenido varchar(100),
    Id_usuario int,
    Fecha date,
    PRIMARY KEY (Id_publicacion),
    FOREIGN KEY (Id_usuario) REFERENCES Usuarios(Id_usuario)
);

CREATE TABLE Amistades(
	Id_amistad int NOT NULL AUTO_INCREMENT,
    estado_de_peticion varchar(10),
    Fecha_de_respuesta datetime,
    Id_amigo1 int,
    Id_amigo2 int,
    PRIMARY KEY (Id_amistad),
    FOREIGN KEY (Id_amigo1) REFERENCES Usuarios(Id_usuario),
    FOREIGN KEY (Id_amigo2) REFERENCES Usuarios(Id_usuario)
);

CREATE TABLE Comentarios(
	Id_comentario int NOT NULL AUTO_INCREMENT,
    texto varchar(100),
    Id_publicacion int,
    Id_usuario int,
    Fecha date,
    PRIMARY KEY (Id_comentario),
    FOREIGN KEY (Id_publicacion) REFERENCES Publicaciones(Id_publicacion),
    FOREIGN KEY (Id_usuario) REFERENCES Usuarios(Id_usuario)
);

CREATE TABLE Mensajes(
	Id_mensaje int NOT NULL AUTO_INCREMENT,
    texto varchar(100),
    Id_emisor int,
    Id_receptor int,
    Fecha datetime,
    PRIMARY KEY (Id_mensaje),
    FOREIGN KEY (Id_emisor) REFERENCES Usuarios(Id_usuario),
    FOREIGN KEY (Id_receptor) REFERENCES Usuarios(Id_usuario)
);


# CREACION DE DATOS

INSERT INTO Usuarios VALUES 
(0, "Osneris","Martinez","osnerismartinez","osnerismartinez@gmail.com"),
(0, "Alejandra","Valencia","alejavalencia","alejavalencia@gmail.com"),
(0, "Alejandro","Rojas","alejorojas","alejorojas@gmail.com"),
(0, "Eliana","Restrepo","elianarestrepo","elianarestrepo@gmail.com"),
(0, "Andres","Palacios","andrespalacios","andrespalacios@gmail.com"),
(0, "David","Useche","daviduseche","daviduseche@gmail.com");

INSERT INTO Amistades VALUES 
(0, "Aceptada", "2023-10-20 10:15:00", 4, 2),
(0, "Aceptada", "2023-10-20 10:15:00", 4, 1),
(0, "Aceptada", "2023-10-27 10:15:00", 1, 2),
(0, "Aceptada", "2023-10-27 10:15:00", 1, 5),
(0, "Aceptada", "2023-09-30 10:15:00", 3, 5),
(0, "Pendiente", "2023-10-20 10:15:00", 4, 5),
(0, "Rechazada", "2023-09-27 10:15:00", 2, 3);

INSERT INTO Mensajes VALUES 
(0, "Hola, como estas?", 1, 2, "2023-10-20 09:15:00"),
(0, "Muy bien y tu?", 2, 1, "2023-10-20 10:15:00"),
(0, "Bien bien gracias", 1, 2, "2023-10-20 11:00:00"),
(0, "Me alegra", 2, 1, "2023-10-20 12:15:00"),
(0, "Hola", 4, 2, "2023-10-20 13:15:00"),
(0, "Como estas?", 4, 2, "2023-10-20 14:00:00"),
(0, "Hola, como estas?", 3, 5, "2023-10-20 15:15:00"),
(0, "Enfermo y tu?", 5, 3, "2023-10-20 16:15:00"),
(0, "que mal, yo bien", 3, 5, "2023-10-20 17:15:00"),
(0, "Me alegra", 5, 3, "2023-10-20 18:00:00");

INSERT INTO Publicaciones VALUES 
(0, "Hoy es un buen día", 1, "2023-10-01"),
(0, "Ayer me cai", 2, "2023-10-01"),
(0, "Hoy almorcé en un restaurante", 3, "2023-10-02"),
(0, "Me siento feliz!", 4, "2023-10-03"),
(0, "Que hay pa hacer hoy?", 5, "2023-10-04");

INSERT INTO Comentarios VALUES 
(0, "Me alegro por ti", 1, 2, "2023-10-01"),
(0, "Gracias", 1, 1, "2023-10-02"),
(0, "Jajaja", 2, 3, "2023-10-01"),
(0, "Que mala suerte tienes", 2, 4, "2023-10-02"),
(0, "Que fino", 3, 5, "2023-10-02"),
(0, "Yo igual", 3, 1, "2023-10-02"),
(0, "Yo tambien", 4, 1, "2023-10-03"),
(0, "Que bien", 4, 2, "2023-10-03"),
(0, "Voy para una fiesta, vamos?", 5, 2, "2023-10-04"),
(0, "No estoy", 5, 3, "2023-10-04");


# CREACION DE CONSULTAS

# 1. Obtener todas las publicaciones de un usuario
SELECT * FROM Publicaciones WHERE Id_usuario = 1;

# 2. Buscar publicaciones con cierta palabra clave
SELECT * FROM Publicaciones WHERE Contenido LIKE "%Hoy%";

# 3. Mostrar los comentarios de una publicación
SELECT * FROM Comentarios WHERE Id_publicacion = "2";

# 4. Encontrar los amigos de un usuario
SELECT Nombre
FROM Usuarios
INNER JOIN Amistades ON (Id_usuario = Id_amigo1 OR Id_usuario = Id_amigo2)
WHERE (Id_amigo1 = 1 OR Id_amigo2 = 1)
AND estado_de_peticion = "Aceptada"
AND Id_usuario <> 1;

# 5. Contar la cantidad de amigos de un usuario
SELECT COUNT(*) as Cantidad_de_Amigos_del_Usuario_2
FROM (
	SELECT Nombre
	FROM Usuarios
	INNER JOIN Amistades ON (Id_usuario = Id_amigo1 OR Id_usuario = Id_amigo2)
	WHERE (Id_amigo1 = 2 OR Id_amigo2 = 2)
	AND estado_de_peticion = "Aceptada"
	AND Id_usuario <> 2
) as Amigos;

# 6. Mostrar las publicaciones de los amigos de un usuario
SELECT u.Nombre, p.Contenido
FROM (Publicaciones p INNER JOIN Usuarios u ON p.Id_usuario = u.Id_usuario)
INNER JOIN Amistades a ON (u.Id_usuario = a.Id_amigo1 OR u.Id_usuario = a.Id_amigo2)
WHERE (a.Id_amigo1 = 1 OR a.Id_amigo2 = 1)
AND a.estado_de_peticion = "Aceptada"
AND u.Id_usuario <> 1;

# 7. Listar los usuarios que han comentado una publicación
SELECT Nombre FROM 
Usuarios u INNER JOIN Comentarios c ON u.Id_usuario = c.Id_usuario
WHERE c.Id_publicacion = 2;

# 8. Buscar amigos que aún no han aceptado la solicitud de amistad
SELECT u.Nombre, u.Apellido
FROM Usuarios u
INNER JOIN Amistades a ON (u.Id_usuario = a.Id_amigo1 OR u.Id_usuario = a.Id_amigo2)
WHERE (a.Id_amigo1 = 4 OR a.Id_amigo2 = 4)
AND a.estado_de_peticion = 'Pendiente';

# 9. Mostrar las publicaciones más recientes ordenadas por fecha
SELECT * FROM Publicaciones
ORDER BY Fecha DESC;

# 10. Mostrar la actividad reciente (publicaciones y comentarios) de un usuario.
SELECT 'Publicacion' AS Tipo, p.Contenido AS Actividad, p.Fecha
FROM Publicaciones p
WHERE p.Id_usuario = 5
UNION
SELECT 'Comentario' AS Tipo, c.texto AS Actividad, c.Fecha
FROM Comentarios c
WHERE c.Id_usuario = 5
ORDER BY Fecha DESC;

# 11. Encontrar las publicaciones de amigos en un rango de fechas
SELECT p.*
FROM Publicaciones p
INNER JOIN Amistades a ON (p.Id_usuario = a.Id_amigo1 OR p.Id_usuario = a.Id_amigo2)
WHERE ((a.Id_amigo1 = 4 OR a.Id_amigo2 = 4)
AND a.estado_de_peticion = 'Aceptada')
AND p.Fecha BETWEEN '2023-10-01' AND '2023-10-31';

# 12. Obtener los usuarios que han enviado mensajes a otro usuario
SELECT DISTINCT u.Nombre AS Nombre_emisor, u2.Nombre AS Nombre_receptor
FROM Usuarios u
INNER JOIN Mensajes m ON u.Id_usuario = m.Id_emisor
INNER JOIN Usuarios u2 ON m.Id_receptor = u2.Id_usuario;

# 13. Mostrar los mensajes entre dos usuarios
SELECT *
FROM Mensajes
WHERE (Id_emisor = 1 AND Id_receptor = 2)
   OR (Id_emisor = 2 AND Id_receptor = 1)
ORDER BY Fecha;

# 14. Encontrar usuarios que no tienen amigos
SELECT *
FROM Usuarios
WHERE Id_usuario NOT IN (
    SELECT DISTINCT Id_amigo1 FROM Amistades
    UNION
    SELECT DISTINCT Id_amigo2 FROM Amistades
);

# 15. Mostrar los usuarios que han comentado sus propias publicaciones
SELECT u.Nombre, u.Apellido
FROM Usuarios u
INNER JOIN Publicaciones p ON u.Id_usuario = p.Id_usuario
INNER JOIN Comentarios c ON p.Id_publicacion = c.Id_publicacion
WHERE c.Id_usuario = u.Id_usuario;

# 16. Listar las 3 publicaciones más comentadas
SELECT p.Id_publicacion, p.Contenido, COUNT(*) as Total_comentarios
FROM Publicaciones p
INNER JOIN Comentarios c ON p.Id_publicacion = c.Id_publicacion
GROUP BY p.Id_publicacion, p.Contenido
ORDER BY Total_comentarios DESC
LIMIT 3;


