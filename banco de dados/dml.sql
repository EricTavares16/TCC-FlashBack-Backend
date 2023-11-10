

USE INFOADB;

-- INSERTS USERS----------------------------------------------------------------------------------------------------------


INSERT INTO TB_CADASTRO_CLIENTE (NM_CLIENTE, NM_SOBRENOME, DS_CPF, DT_NASCIMENTO ,DS_TELEFONE, NM_USUARIO, DS_EMAIL, DS_SENHA, DT_CADASTRO)
	VALUE ("Eric", "Tasa", "499.333.100-90", "2023-11-12", "(11) 96777-9088", "Tuu", "epp@gmail.com", "K@1BHBHBH", now());

INSERT INTO TB_CADASTRO_EMPRESA (DS_CNPJ, NM_RAZAO_SOCIAL, DS_EMAIL_EMPRESA, DS_SENHA_EMPRESA)
	VALUE ("33344983983", "MC donalds", "mc@gmail.com", "1234");
    
INSERT INTO TB_CADASTRO_ADM (DS_EMAIL_ADM, DS_SENHA_ADM)
	VALUE ("admin", "1234");
    
-------------------------------------------------------------------------------------------------------------------
    

SELECT * FROM TB_CADASTRO_CLIENTE;
SELECT * FROM TB_CADASTRO_EMPRESA;
SELECT * FROM TB_CADASTRO_ADM;


-- INSERTS INGRESSO --------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO TB_CATEGORIA_INGRESSO(NM_CATEGORIA_INGRESSO)
	   VALUES ("Museu");
       
INSERT INTO TB_LOCAL_EVENTO (DS_CEP, DS_LOGRADOURO, DS_BAIRRO, DS_LOCALIDADE, DS_UF)
	   VALUES ("04839-000", "Av. Muriçoca", "Jd. Flavor", "Belo Horizonte", "MG");
       
INSERT INTO TB_INGRESSO(ID_CATEGORIA_INGRESSO, ID_EMPRESA, ID_LOCAL_EVENTO, NM_EVENTO, DS_EVENTO, DT_CADASTRO, BT_DESTAQUE)
	   VALUES (1, 1, 1, "Nuuu", "Festas", now(), TRUE);
       
INSERT INTO TB_DATAS_INGRESSO (ID_INGRESSO, DT_INGRESSO) 
	   VALUES 	(1, '2023-11-08'),
				(1, '2023-11-09');
       
INSERT INTO TB_HORARIOS_DATAS_INGRESSO (ID_DATA_INGRESSO, DS_HORARIO) 
	   VALUES 	(1, '11:00:00'),
				(2, '11:00:00');	
       
INSERT INTO TB_TIPOS_INGRESSO (ID_INGRESSO, NM_TIPO_INGRESSO, QTD_TIPO_INGRESSO, VL_PRECO_TIPO) 
	   VALUES (1, "Front", 100, 300);	

-- SELECTS  INGRESSO --------------------------------------------------------------------------------------------------------------------------------------------       

SELECT * FROM TB_TIPOS_INGRESSO;
SELECT * FROM TB_CATEGORIA_INGRESSO;
SELECT * FROM TB_LOCAL_EVENTO;
SELECT * FROM TB_DATAS_INGRESSO;

SELECT * FROM TB_INGRESSO;

--SELECT LISTAGEM INGRESSOS

SELECT  NM_CATEGORIA_INGRESSO,
		NM_TIPO_INGRESSO, 
        QTD_TIPO_INGRESSO, 
        VL_PRECO_TIPO, 
        NM_EVENTO, 
		MIN(DT_INGRESSO) AS DT_COMECO,
		MAX(DT_INGRESSO) AS DT_FIM,
        DS_HORARIO,
        DS_LOGRADOURO,
        DS_LOCALIDADE,
        DS_UF,
        DS_EVENTO,
        IMAGEM_INGRESSO,
        DT_CADASTRO,
        BT_DESTAQUE
        
	FROM 			TB_INGRESSO						INGRESSO
	INNER JOIN 		TB_CATEGORIA_INGRESSO 	 		CATEGORIA		ON CATEGORIA.ID_CATEGORIA_INGRESSO = INGRESSO.ID_CATEGORIA_INGRESSO
    INNER JOIN 		TB_TIPOS_INGRESSO   			TIPO 			ON TIPO.ID_INGRESSO = INGRESSO.ID_INGRESSO
    INNER JOIN		TB_LOCAL_EVENTO					LOCAL			ON LOCAL.ID_LOCAL_EVENTO = INGRESSO.ID_LOCAL_EVENTO
	INNER JOIN		TB_DATAS_INGRESSO				DATAS			ON DATAS.ID_INGRESSO = INGRESSO.ID_INGRESSO
	INNER JOIN		TB_HORARIOS_DATAS_INGRESSO		HORARIOS		ON HORARIOS.ID_DATA_INGRESSO = DATAS.ID_DATA_INGRESSO
    
    WHERE DT_INGRESSO = (SELECT MIN(DT_INGRESSO) FROM TB_DATAS_INGRESSO WHERE ID_INGRESSO = INGRESSO.ID_INGRESSO) 
	AND DS_HORARIO= (SELECT MIN(DS_HORARIO) FROM TB_HORARIOS_DATAS_INGRESSO WHERE ID_DATA_INGRESSO = DATAS.ID_DATA_INGRESSO)
    
    GROUP BY
    NM_CATEGORIA_INGRESSO, NM_TIPO_INGRESSO, QTD_TIPO_INGRESSO, VL_PRECO_TIPO, NM_EVENTO, DS_HORARIO, DS_LOGRADOURO, DS_LOCALIDADE, DS_UF, DS_EVENTO, IMAGEM_INGRESSO, DT_CADASTRO, BT_DESTAQUE

    ORDER BY  	NM_CATEGORIA_INGRESSO, NM_TIPO_INGRESSO;


--SELECT INGRESSOS DESTAQUE

    SELECT  INGRESSO.ID_INGRESSO,
            NM_CATEGORIA_INGRESSO,
            NM_TIPO_INGRESSO, 
            QTD_TIPO_INGRESSO, 
            VL_PRECO_TIPO, 
            NM_EVENTO, 
            MIN(DT_INGRESSO) AS DT_COMECO,
			MAX(DT_INGRESSO) AS DT_FIM,
			DS_HORARIO,
            DS_LOGRADOURO,
            DS_LOCALIDADE,
            DS_UF,
            DS_EVENTO,
            IMAGEM_INGRESSO,
            DT_CADASTRO,
            BT_DESTAQUE
        
        FROM 			TB_INGRESSO						INGRESSO
		INNER JOIN 		TB_CATEGORIA_INGRESSO 	 		CATEGORIA		ON CATEGORIA.ID_CATEGORIA_INGRESSO = INGRESSO.ID_CATEGORIA_INGRESSO
		INNER JOIN 		TB_TIPOS_INGRESSO   			TIPO 			ON TIPO.ID_INGRESSO = INGRESSO.ID_INGRESSO
        INNER JOIN		TB_LOCAL_EVENTO					LOCAL			ON LOCAL.ID_LOCAL_EVENTO = INGRESSO.ID_LOCAL_EVENTO
        INNER JOIN		TB_DATAS_INGRESSO				DATAS			ON DATAS.ID_INGRESSO = INGRESSO.ID_INGRESSO
		INNER JOIN		TB_HORARIOS_DATAS_INGRESSO		HORARIOS		ON HORARIOS.ID_DATA_INGRESSO = DATAS.ID_DATA_INGRESSO
       
		WHERE 			INGRESSO.BT_DESTAQUE = 1 
        AND DT_INGRESSO = (SELECT MIN(DT_INGRESSO) FROM TB_DATAS_INGRESSO WHERE ID_INGRESSO = INGRESSO.ID_INGRESSO) 
		AND DS_HORARIO= (SELECT MIN(DS_HORARIO) FROM TB_HORARIOS_DATAS_INGRESSO WHERE ID_DATA_INGRESSO = DATAS.ID_DATA_INGRESSO)
    
		GROUP BY
		INGRESSO.ID_INGRESSO,NM_CATEGORIA_INGRESSO, NM_TIPO_INGRESSO, QTD_TIPO_INGRESSO, VL_PRECO_TIPO, NM_EVENTO, DS_HORARIO, DS_LOGRADOURO, DS_LOCALIDADE, DS_UF, DS_EVENTO, IMAGEM_INGRESSO, DT_CADASTRO, BT_DESTAQUE

        ORDER BY NM_EVENTO ASC  
      
      
      
-- INSERTS PEDIDOS --------------------------------------------------------------------------------------------------------------------------------------------
      
INSERT INTO TB_CARTAO(NR_CARTAO, DT_VALIDADE, NR_CVV)
	   VALUES (12323, '2029-10-12', 190);      
      
INSERT INTO TB_FORMA_PAGAMENTO(ID_CARTAO)
	   VALUES (1);      
      
 INSERT INTO TB_PEDIDO_INGRESSO(ID_CLIENTE, ID_INGRESSO, ID_TIPO_INGRESSO, QTD_ITENS)
	   VALUES (3, 1, 1, 5); 
       
 INSERT INTO TB_PEDIDO(ID_PEDIDO_INGRESSO, ID_FORMA_PAGAMENTO, DT_PEDIDO, BT_SITUACAO)
	   VALUES (1, 1, now(), true); 
       

-- SELECTS  PEDIDO --------------------------------------------------------------------------------------------------------------------------------------------       

SELECT * FROM TB_CARTAO;
SELECT * FROM TB_FORMA_PAGAMENTO;
SELECT * FROM TB_PEDIDO_INGRESSO;

SELECT * FROM TB_PEDIDO;

      
   
 SELECT  	ID_PEDIDO,
			NM_CLIENTE,
            NM_SOBRENOME,
            DS_CPF,
            DS_EMAIL,
            DS_TELEFONE,
			NM_EVENTO, 
            IMAGEM_INGRESSO,
			DS_EVENTO,
            NM_TIPO_INGRESSO,
            VL_PRECO_TIPO,
            QTD_ITENS,
            DT_PEDIDO
            
	FROM 			TB_PEDIDO						PEDIDO
	INNER JOIN 		TB_PEDIDO_INGRESSO 	 		    PDINGRESSO				ON PDINGRESSO.ID_PEDIDO_INGRESSO = PEDIDO.ID_PEDIDO_INGRESSO
	INNER JOIN 		TB_CADASTRO_CLIENTE 	 		CLIENTE					ON CLIENTE.ID_CLIENTE = PDINGRESSO.ID_CLIENTE
    INNER JOIN 		TB_INGRESSO 	 				INGRESSO				ON INGRESSO.ID_INGRESSO = PDINGRESSO.ID_INGRESSO
	INNER JOIN 		TB_TIPOS_INGRESSO 	 			TIPO					ON TIPO.ID_TIPO_INGRESSO = PDINGRESSO.ID_TIPO_INGRESSO
    INNER JOIN 		TB_FORMA_PAGAMENTO   			FORMA_PAGAMENTO			ON FORMA_PAGAMENTO.ID_FORMA_PAGAMENTO = PEDIDO.ID_FORMA_PAGAMENTO;
 
   
   
SELECT 	DT_INGRESSO,
		DS_HORARIO
		
	FROM 			TB_INGRESSO						INGRESSO
	INNER JOIN		TB_DATAS_INGRESSO				DATAS			ON DATAS.ID_INGRESSO = INGRESSO.ID_INGRESSO
	INNER JOIN		TB_HORARIOS_DATAS_INGRESSO		HORARIOS		ON HORARIOS.ID_DATA_INGRESSO = DATAS.ID_DATA_INGRESSO

	WHERE INGRESSO.ID_INGRESSO = 1 AND DATAS.ID_DATA_INGRESSO = 1;
        

SELECT  NM_CATEGORIA_INGRESSO, 
        NM_EVENTO, 
        DT_COMECO,
        DS_EVENTO,
        IMAGEM_INGRESSO
        
        FROM 			TB_INGRESSO				INGRESSO
        INNER JOIN 		TB_CATEGORIA_INGRESSO 	 		CATEGORIA		ON CATEGORIA.ID_CATEGORIA_INGRESSO = INGRESSO.ID_CATEGORIA_INGRESSO
    WHERE NM_CATEGORIA_INGRESSO = "Museu"


-- PARTE ADM

-- LISTAGEM POR DATA 
SELECT 
    P.*, 
    PI.*,
    FP.*
FROM 
    TB_PEDIDO P
    INNER JOIN TB_PEDIDO_INGRESSO PI ON P.ID_PEDIDO_INGRESSO = PI.ID_PEDIDO_INGRESSO
    INNER JOIN TB_FORMA_PAGAMENTO FP ON P.ID_FORMA_PAGAMENTO = FP.ID_FORMA_PAGAMENTO
WHERE 
    P.DT_PEDIDO LIKE '2023-11-09%';


-- TODA A LISTAGEM DA COMPRA 

SELECT * FROM TB_PEDIDO;

--OU 
    SELECT 
    P.*, 
    PI.*,
    FP.*
FROM 
    TB_PEDIDO P
    INNER JOIN TB_PEDIDO_INGRESSO PI ON P.ID_PEDIDO_INGRESSO = PI.ID_PEDIDO_INGRESSO
    INNER JOIN TB_FORMA_PAGAMENTO FP ON P.ID_FORMA_PAGAMENTO = FP.ID_FORMA_PAGAMENTO;


-- LISTAGEM POR UF ( VAI PRECISAR MAIS	 DE DUAS CHAMADAS)

SELECT  	ID_PEDIDO,
			NM_CLIENTE,
            NM_SOBRENOME,
            DS_CPF,
            DS_EMAIL,
            DS_TELEFONE,
			NM_EVENTO,
            DS_UF,
            IMAGEM_INGRESSO,
			DS_EVENTO,
            NM_TIPO_INGRESSO,
            VL_PRECO_TIPO,
            QTD_ITENS,
            DT_PEDIDO
            
	FROM 			TB_PEDIDO						PEDIDO
	INNER JOIN 		TB_PEDIDO_INGRESSO 	 		    PDINGRESSO				ON PDINGRESSO.ID_PEDIDO_INGRESSO = PEDIDO.ID_PEDIDO_INGRESSO
	INNER JOIN 		TB_CADASTRO_CLIENTE 	 		CLIENTE					ON CLIENTE.ID_CLIENTE = PDINGRESSO.ID_CLIENTE
    INNER JOIN 		TB_INGRESSO 	 				INGRESSO				ON INGRESSO.ID_INGRESSO = PDINGRESSO.ID_INGRESSO
    INNER JOIN		TB_LOCAL_EVENTO					LOCAL					ON LOCAL.ID_LOCAL_EVENTO = INGRESSO.ID_LOCAL_EVENTO
	INNER JOIN 		TB_TIPOS_INGRESSO 	 			TIPO					ON TIPO.ID_TIPO_INGRESSO = PDINGRESSO.ID_TIPO_INGRESSO
    INNER JOIN 		TB_FORMA_PAGAMENTO   			FORMA_PAGAMENTO			ON FORMA_PAGAMENTO.ID_FORMA_PAGAMENTO = PEDIDO.ID_FORMA_PAGAMENTO
 
   WHERE DS_UF = 'MG'

-- LISTAR EMPRESAS 

SELECT * FROM TB_CADASTRO_EMPRESA;


-- LISTAR USUARIOS 

SELECT * FROM TB_CADASTRO_CLIENTE;





-- PARTE EMPRESA 

--LISTAGEM POR ID DA EMPRESA 

SELECT  *
	FROM 			TB_INGRESSO						INGRESSO
    INNER JOIN 		TB_CADASTRO_EMPRESA				EMPRESA			ON EMPRESA.ID_EMPRESA = INGRESSO.ID_EMPRESA
	INNER JOIN 		TB_CATEGORIA_INGRESSO 	 		CATEGORIA		ON CATEGORIA.ID_CATEGORIA_INGRESSO = INGRESSO.ID_CATEGORIA_INGRESSO
    INNER JOIN 		TB_TIPOS_INGRESSO   			TIPO 			ON TIPO.ID_INGRESSO = INGRESSO.ID_INGRESSO
    INNER JOIN		TB_LOCAL_EVENTO					LOCAL			ON LOCAL.ID_LOCAL_EVENTO = INGRESSO.ID_LOCAL_EVENTO
WHERE INGRESSO.ID_EMPRESA = 1;


