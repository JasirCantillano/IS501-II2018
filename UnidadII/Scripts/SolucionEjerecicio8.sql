
/*
1. Mostrar todos los usuarios que no han creado ningún tablero, para dichos usuarios mostrar el
nombre completo y correo, utilizar producto cartesiano con el operador (+).
*/

--51 REGISTRO
SELECT A.NOMBRE || ' ' ||A.APELLIDO AS NOMBRE_COMPLETO, 
        A.CORREO
FROM TBL_USUARIOS A,
    TBL_TABLERO B
WHERE A.CODIGO_USUARIO = B.CODIGO_USUARIO_CREA (+)
AND B.CODIGO_USUARIO_CREA IS NULL;


/*
Mostrar la cantidad de usuarios que se han registrado por cada red social, mostrar inclusive la
cantidad de usuarios que no están registrados con redes sociales.
*/


SELECT *
FROM TBL_USUARIOS;

SELECT * 
FROM TBL_REDES_SOCIALES;
--119 EN FACEBOOK
SELECT NVL(B.NOMBRE_RED_SOCIAL,'SIN RED SOCIAL') AS RED_SOCIAL, 
        COUNT(*) AS CANTIDAD_USUARIOS
FROM TBL_USUARIOS A
LEFT JOIN TBL_REDES_SOCIALES B
ON (A.CODIGO_RED_SOCIAL = B.CODIGO_RED_SOCIAL)
GROUP BY NVL(B.NOMBRE_RED_SOCIAL,'SIN RED SOCIAL');

/*
3. Consultar el usuario que ha hecho más comentarios sobre una tarjeta (El más prepotente), para
este usuario mostrar el nombre completo, correo, cantidad de comentarios y cantidad de
tarjetas a las que ha comentado (pista: una posible solución para este último campo es utilizar
count(distinct campo))

*/

SELECT A.CODIGO_USUARIO, A.NOMBRE, A.APELLIDO, COUNT(*)
FROM TBL_USUARIOS  A
INNER JOIN TBL_COMENTARIOS B
ON A.CODIGO_USUARIO = B.CODIGO_USUARIO
GROUP BY A.CODIGO_USUARIO, A.NOMBRE, A.APELLIDO
ORDER BY CODIGO_USUARIO;