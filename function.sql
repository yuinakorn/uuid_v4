CREATE DEFINER=`YOUR_CURRENT_USER`@`%` FUNCTION `uuidv4`(my_string VARCHAR(255)) RETURNS char(36) CHARSET utf8mb4
BEGIN
    DECLARE hexStr CHAR(32);
    DECLARE hashedInput CHAR(32);

    -- Hash the inputName (using MD5 in this example, but you can choose a different hashing algorithm)
    SET hashedInput = MD5(my_string);

    SET hexStr = CONCAT(
        hashedInput,
        '4', -- Version 4 UUID
        LPAD(HEX(FLOOR(RAND() * 0x10000)), 3, '0'),
        '8', -- Variant for UUID
        LPAD(HEX(FLOOR(RAND() * 0x10000)), 3, '0'),
        LPAD(HEX(FLOOR(RAND() * 0x100000000)), 8, '0')
    );

    RETURN CONCAT(
        SUBSTR(hexStr, 1, 8), '-',
        SUBSTR(hexStr, 9, 4), '-',
        '4', SUBSTR(hexStr, 14, 3), '-',
        LPAD(HEX(FLOOR(RAND() * 0x10000)), 4, '0'), '-',
        SUBSTR(hexStr, 20)
    );
END