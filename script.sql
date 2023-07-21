CREATE DATABASE testsql;
USE testsql;

CREATE TABLE A1 (
    A1_COD INT PRIMARY KEY,
    A1_NOME VARCHAR(100),
    A1_TIPO VARCHAR(20)
);

INSERT INTO A1 (A1_COD, A1_NOME, A1_TIPO)
VALUES
    (1001, 'MARIA DA SILVA', 'Pessoa Física'),
    (1002, 'JOSE DE ALENCAR', 'Pessoa Física'),
    (1003, 'AFONSO COSTA', 'Pessoa Física'),
    (1004, 'JOAO DOS SANTOS', 'Pessoa Jurídica');

SELECT * FROM A1;

CREATE TABLE A3 (
    A3_COD INT PRIMARY KEY,
    A3_NOME VARCHAR(100),
    A3_REGIAO VARCHAR(50)
);

INSERT INTO A3 (A3_COD, A3_NOME, A3_REGIAO)
VALUES
    (111, 'PAULO DA MATA', 'CENTRO'),
    (112, 'ANDERSON SILVA', 'LESTE'),
    (113, 'TYLER OLIVEIRA', 'OESTE'),
    (114, 'OTTO ALBUQUERQUE', 'NORTE');

SELECT * FROM A3;

CREATE TABLE C5 (
    C5_NUM INT PRIMARY KEY,
    C5_EMISSAO DATE,
    C5_CODCLI INT,
    C5_CODVEN INT,
    FOREIGN KEY (C5_CODCLI) REFERENCES A1(A1_COD),
    FOREIGN KEY (C5_CODVEN) REFERENCES A3(A3_COD)
);

INSERT INTO C5 (C5_NUM, C5_EMISSAO, C5_CODCLI, C5_CODVEN)
VALUES
    (9001, '2023-01-25', 1001, 112),
    (9002, '2023-01-15', 1002, 111),
    (9003, '2023-02-02', 1003, 113),
    (9004, '2023-03-03', 1004, 114);

SELECT * FROM C5;

CREATE TABLE C6 (
    C6_NUM INT,
    C6_ITEM INT,
    C6_CODPROD INT,
    C6_QTD INT,
    C6_PRUNIT DECIMAL(10, 2),
    PRIMARY KEY (C6_NUM, C6_ITEM),
    FOREIGN KEY (C6_NUM) REFERENCES C5(C5_NUM)
);

INSERT INTO C6 (C6_NUM, C6_ITEM, C6_CODPROD, C6_QTD, C6_PRUNIT)
VALUES
    (9001, 001, 7001, 70, 15.90),
    (9001, 002, 7002, 60, 19.70),
    (9003, 001, 7001, 90, 11.33),
    (9003, 002, 7004, 210, 21.70);

#2.1) Consulta que retorne todos os pedidos do cliente “AFONSO COSTA”
SELECT C5.*
FROM A1
JOIN C5 ON A1.A1_COD = C5.C5_CODCLI
WHERE A1.A1_NOME = 'AFONSO COSTA';

SELECT C5.C5_NUM, C5.C5_EMISSAO, A1.A1_NOME AS NOME_CLIENTE, A3.A3_NOME AS NOME_VENDEDOR
FROM C5
JOIN A1 ON C5.C5_CODCLI = A1.A1_COD
JOIN A3 ON C5.C5_CODVEN = A3.A3_COD
WHERE A1.A1_COD = 1003;

#2.2) Consulta que retorne todos os pedidos (com seus itens respectivos) emitidos no mês de janeiro de 2023
SELECT C5.C5_NUM, C5.C5_EMISSAO, A1.A1_NOME AS NOME_CLIENTE, A3.A3_NOME AS NOME_VENDEDOR,
       C6.C6_ITEM, C6.C6_CODPROD, C6.C6_QTD, C6.C6_PRUNIT
FROM C5
JOIN A1 ON C5.C5_CODCLI = A1.A1_COD
JOIN A3 ON C5.C5_CODVEN = A3.A3_COD
JOIN C6 ON C5.C5_NUM = C6.C6_NUM
WHERE C5.C5_EMISSAO BETWEEN '2023-01-01' AND '2023-01-31';

#2.3) Consulta que retorne o valor total dos pedidos em fevereiro de 2023
SELECT C5.C5_NUM, SUM(C6.C6_QTD * C6.C6_PRUNIT) AS VALOR_TOTAL
FROM C5
JOIN C6 ON C5.C5_NUM = C6.C6_NUM
WHERE C5.C5_EMISSAO BETWEEN '2023-02-01' AND '2023-02-28'
GROUP BY C5.C5_NUM;

#2.4) Consulta que retorne o valor total dos pedidos agrupados por nome de vendedor
SELECT A3.A3_NOME AS NOME_VENDEDOR, COALESCE(SUM(C6.C6_QTD * C6.C6_PRUNIT), 0) AS VALOR_TOTAL_PEDIDOS
FROM A3
LEFT JOIN C5 ON A3.A3_COD = C5.C5_CODVEN
LEFT JOIN C6 ON C5.C5_NUM = C6.C6_NUM
GROUP BY A3.A3_NOME;

#2.5) Consulta que retorne o valor total dos pedidos, vendidos em 2022 agrupados por tipo de cliente (pessoa física ou jurídica)

#2022 ?
SELECT A1.A1_TIPO, COALESCE(SUM(C6.C6_QTD * C6.C6_PRUNIT), 0) AS VALOR_TOTAL_PEDIDOS
FROM A1
LEFT JOIN C5 ON A1.A1_COD = C5.C5_CODCLI
LEFT JOIN C6 ON C5.C5_NUM = C6.C6_NUM
WHERE C5.C5_EMISSAO BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY A1.A1_TIPO;

#2023 
SELECT A1.A1_TIPO, COALESCE(SUM(C6.C6_QTD * C6.C6_PRUNIT), 0) AS VALOR_TOTAL_PEDIDOS
FROM A1
LEFT JOIN C5 ON A1.A1_COD = C5.C5_CODCLI
LEFT JOIN C6 ON C5.C5_NUM = C6.C6_NUM
WHERE C5.C5_EMISSAO BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY A1.A1_TIPO;

#2.6) Consulta que retorne o valor total dos pedidos, vendidos no primeiro semestre de 2023 agrupados por região do vendedor
SELECT A3.A3_REGIAO AS REGIAO_VENDEDOR, COALESCE(SUM(C6.C6_QTD * C6.C6_PRUNIT), 0) AS VALOR_TOTAL_PEDIDOS
FROM A3
LEFT JOIN C5 ON A3.A3_COD = C5.C5_CODVEN
LEFT JOIN C6 ON C5.C5_NUM = C6.C6_NUM
WHERE C5.C5_EMISSAO BETWEEN '2023-01-01' AND '2023-06-30'
GROUP BY A3.A3_REGIAO;





