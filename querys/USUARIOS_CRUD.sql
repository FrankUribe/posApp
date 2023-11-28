DELIMITER //

CREATE PROCEDURE USUARIOS_CRUD(
    IN p_Method CHAR(1),
    IN p_IDUSUARIO VARCHAR(20),
    IN p_CONTRA VARCHAR(200),
    IN p_NOMBRES VARCHAR(50),
    IN p_APELLIDOS VARCHAR(50),
    IN p_IDESTADO CHAR(3),
    IN p_FOTO VARCHAR(1000)
)
BEGIN
    IF p_Method = 'C' THEN
        -- Método CREATE
        INSERT INTO usuarios (CONTRA, NOMBRES, APELLIDOS, IDESTADO, FOTO)
        VALUES (p_CONTRA, p_NOMBRES, p_APELLIDOS, p_IDESTADO, p_FOTO);
    ELSEIF p_Method = 'R' THEN
        -- Método READ
        SELECT * FROM usuarios;
    ELSEIF p_Method = 'U' THEN
        -- Método UPDATE
        UPDATE usuarios
        SET
            CONTRA = COALESCE(p_CONTRA, CONTRA),
            NOMBRES = COALESCE(p_NOMBRES, NOMBRES),
            APELLIDOS = COALESCE(p_APELLIDOS, APELLIDOS),
            IDESTADO = COALESCE(p_IDESTADO, IDESTADO),
            FOTO = COALESCE(p_FOTO, FOTO)
        WHERE IDUSUARIO = p_IDUSUARIO;
    ELSEIF p_Method = 'D' THEN
        -- Método DELETE
        DELETE FROM usuarios WHERE IDUSUARIO = p_IDUSUARIO;
    ELSE
        -- Manejo de errores si se proporciona un método no válido
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid method provided';
    END IF;
END //

DELIMITER ;
