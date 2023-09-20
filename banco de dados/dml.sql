USE INFOADB;

-- INSERTS USERS----------------------------------------------------------------------------------------------------------

INSERT INTO TB_CADASTRO_CLIENTE (NM_CLIENTE, NM_SOBRENOME, DS_CPF, DS_TELEFONE, NM_USUARIO, DS_EMAIL, DS_SENHA)
	VALUE (?, ?, ?, ?, ?, ?, ?);
    

INSERT INTO TB_CADASTRO_EMPRESA (DS_CNPJ, NM_RAZAO_SOCIAL, DS_EMAIL_EMPRESA, DS_SENHA_EMPRESA, DS_ENDERECO_EMPRESA)
	VALUE (?, ?, ?, ?, ?);
    
-- -----------------------------------------------------------------------------------------------------------------
    

SELECT * FROM TB_CADASTRO_CLIENTE;
SELECT * FROM TB_CADASTRO_EMPRESA;
SELECT * FROM TB_CADASTRO_ADM;


-- INSERTS INGRESSO --------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO TB_CATEGORIA_INGRESSO(NM_CATEGORIA_INGRESSO)
	   VALUES ("Museu");
       
INSERT INTO TB_DATA_INGRESSO(DT_COMECO, DT_FIM)
	   VALUES ('2023-10-12 20:00:00', '2023-11-12 10:00:00');
       
INSERT INTO TB_INGRESSO(ID_CATEGORIA_INGRESSO, ID_EMPRESA, ID_DATA_INGRESSO, NM_EVENTO, DS_EVENTO, DT_CADASTRO)
	   VALUES (1, 1, 1, "Nuuu", "Bebidas Dorgas bla bla sex", now());
       
INSERT INTO TB_TIPOS_INGRESSO (ID_INGRESSO, NM_TIPO_INGRESSO, QTD_TIPO_INGRESSO, VL_PRECO_TIPO) 
	   VALUES (1, "Front", 100, 200.20);	

-- SELECTS  INGRESSO --------------------------------------------------------------------------------------------------------------------------------------------       

SELECT * FROM TB_TIPOS_INGRESSO;
SELECT * FROM TB_CATEGORIA_INGRESSO;
SELECT * FROM TB_CADASTRO_EMPRESA;

SELECT * FROM TB_INGRESSO;


SELECT  NM_CATEGORIA_INGRESSO,
	NM_TIPO_INGRESSO, 
        QTD_TIPO_INGRESSO, 
        VL_PRECO_TIPO, 
        NM_EVENTO, 
        DT_COMECO,
        DT_FIM,
        DS_EVENTO
	FROM 			TB_INGRESSO				        INGRESSO
	INNER JOIN 		TB_CATEGORIA_INGRESSO 	 		        CATEGORIA		ON CATEGORIA.ID_CATEGORIA_INGRESSO = INGRESSO.ID_CATEGORIA_INGRESSO
    INNER JOIN 		        TB_DATA_INGRESSO   				DATAS			ON DATAS.ID_DATA_INGRESSO = INGRESSO.ID_DATA_INGRESSO
    INNER JOIN 		        TB_TIPOS_INGRESSO   			        TIPO 			ON TIPO.ID_INGRESSO = INGRESSO.ID_INGRESSO
      ORDER BY  	        NM_CATEGORIA_INGRESSO, NM_TIPO_INGRESSO; 
      
      
      
-- INSERTS PEDIDOS --------------------------------------------------------------------------------------------------------------------------------------------
      
INSERT INTO TB_CARTAO(NR_CARTAO, DT_VALIDADE, NR_CVV)
	   VALUES (12323, '2029-10-12', 190);      
      
INSERT INTO TB_FORMA_PAGAMENTO(ID_CARTAO)
	   VALUES (1);      
      
 INSERT INTO TB_PEDIDO_INGRESSO(ID_CLIENTE, ID_INGRESSO)
	   VALUES (1, 1); 
       
 INSERT INTO TB_PEDIDO(ID_PEDIDO_INGRESSO, ID_FORMA_PAGAMENTO, DT_PEDIDO, BT_SITUACAO)
	   VALUES (1, 1, now(), true); 
       

-- SELECTS  PEDIDO --------------------------------------------------------------------------------------------------------------------------------------------       

SELECT * FROM TB_CARTAO;
SELECT * FROM TB_FORMA_PAGAMENTO;
SELECT * FROM TB_PEDIDO_INGRESSO;

SELECT * FROM TB_PEDIDO;

      
   
SELECT  	ID_PEDIDO,
                NM_CLIENTE,
                NM_EVENTO, 
                DT_COMECO,
                DT_FIM,
                DS_EVENTO,
                DT_PEDIDO
            
	FROM 			TB_PEDIDO				    PEDIDO
	INNER JOIN 		TB_PEDIDO_INGRESSO 	 		    PDINGRESSO				ON PDINGRESSO.ID_PEDIDO_INGRESSO = PEDIDO.ID_PEDIDO_INGRESSO
    INNER JOIN 		TB_FORMA_PAGAMENTO   			            FORMA_PAGAMENTO			ON FORMA_PAGAMENTO.ID_FORMA_PAGAMENTO = PEDIDO.ID_FORMA_PAGAMENTO
      ORDER BY  	NM_CATEGORIA_INGRESSO, NM_TIPO_INGRESSO;   
   