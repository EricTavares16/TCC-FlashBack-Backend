
USE INFOADB;

-- INSERTS USERS----------------------------------------------------------------------------------------------------------

INSERT INTO TB_CADASTRO_CLIENTE (NM_CLIENTE, NM_SOBRENOME, DS_CPF, DS_TELEFONE, NM_USUARIO, DS_EMAIL, DS_SENHA)
	VALUE (?, ?, ?, ?, ?, ?, ?);
    
INSERT INTO TB_CADASTRO_EMPRESA (DS_CNPJ, NM_RAZAO_SOCIAL, DS_EMAIL_EMPRESA, DS_SENHA_EMPRESA)
	VALUE (?, ?, ?, ?);

INSERT INTO TB_CADASTRO_ADM (DS_EMAIL_ADM, DS_SENHA_ADM)
	VALUE (?, ?);
    
-- -----------------------------------------------------------------------------------------------------------------
    

SELECT * FROM TB_CADASTRO_CLIENTE;
SELECT * FROM TB_CADASTRO_EMPRESA;
SELECT * FROM TB_CADASTRO_ADM;


-- INSERTS INGRESSO --------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO TB_CATEGORIA_INGRESSO(NM_CATEGORIA_INGRESSO)
	   VALUES ("Festas e Shows");
INSERT INTO TB_CATEGORIA_INGRESSO(NM_CATEGORIA_INGRESSO)
	   VALUES ("Teatros e Espetáculos");
INSERT INTO TB_CATEGORIA_INGRESSO(NM_CATEGORIA_INGRESSO)
	   VALUES ("Palestras e Congressos");
INSERT INTO TB_CATEGORIA_INGRESSO(NM_CATEGORIA_INGRESSO)
	   VALUES ("Festas Juninas");
INSERT INTO TB_CATEGORIA_INGRESSO(NM_CATEGORIA_INGRESSO)
	   VALUES ("Infantil");

       
INSERT INTO TB_LOCAL_EVENTO (DS_CEP, DS_LOGRADOURO, DS_BAIRRO, DS_LOCALIDADE, DS_UF)
		VALUES ("04839-000", "Av. Muriçoca", "Jd. Flavor", "Belo Horizonte", "MG");
       
INSERT INTO TB_INGRESSO(ID_CATEGORIA_INGRESSO, ID_EMPRESA, ID_LOCAL_EVENTO, NM_EVENTO, DS_EVENTO, DT_COMECO, DT_FIM, IMAGEM_INGRESSO, DT_CADASTRO, BT_DESTAQUE)
		VALUES (1, 1, 1, "Numanice", "Bebidas Dorgas bla bla sex", '2023-10-12 20:00:00', '2023-10-12 22:00:00', 'Storage\capasIngressos\2379eac7d81d235ed5fb04c4b184063b', now(), TRUE),
			   (2, 1, 1, "Inter Tenda", "Bebidas Dorgas bla bla sex", '2023-10-12 20:00:00', '2023-10-12 22:00:00', 'Storage\capasIngressos\d8a7eea9ba4faf59ba881ee6ea63f776', now(), TRUE),
			   (3, 1, 1, "FaroFada", "Bebidas Dorgas bla bla sex", '2023-10-12 20:00:00', '2023-10-12 22:00:00', 'Storage\capasIngressos\716b8e60209d60b398d5c3f905de5a5a',now(), TRUE),
               (4, 1, 1, "Alok & Jefferson .M", "Bebidas Dorgas bla bla sex", '2023-10-12 20:00:00', '2023-10-12 22:00:00', 'Storage\capasIngressos\292882a2b6c72b4f7dc931d178b68d9a',now(), TRUE),
			   (5, 1, 1, "Inutilismo", "Bebidas Dorgas bla bla sex", '2023-10-12 20:00:00', '2023-10-12 22:00:00', 'Storage\capasIngressos\d8a7eea9ba4faf59ba881ee6ea63f776',now(), TRUE);
       
INSERT INTO TB_TIPOS_INGRESSO (ID_INGRESSO, NM_TIPO_INGRESSO, QTD_TIPO_INGRESSO, VL_PRECO_TIPO) 
	   VALUES  (1, "Front", 100, 300),
			   (2, "Front", 100, 300),
			   (3, "Front", 100, 300),
			   (4, "Front", 100, 300),
			   (5, "Front", 100, 300);	


-- SELECTS  INGRESSO --------------------------------------------------------------------------------------------------------------------------------------------       

SELECT * FROM TB_TIPOS_INGRESSO;
SELECT * FROM TB_CATEGORIA_INGRESSO;
SELECT * FROM TB_LOCAL_EVENTO;

SELECT * FROM TB_INGRESSO;


SELECT  NM_CATEGORIA_INGRESSO,
	NM_TIPO_INGRESSO, 
        QTD_TIPO_INGRESSO, 
        VL_PRECO_TIPO, 
        NM_EVENTO, 
        DT_COMECO,
        DT_FIM,
        DS_LOGRADOURO,
        DS_LOCALIDADE,
        DS_UF,
        DS_EVENTO,
        IMAGEM_INGRESSO,
        DT_CADASTRO,
        BT_DESTAQUE
        
        FROM 			TB_INGRESSO					INGRESSO
	INNER JOIN 		TB_CATEGORIA_INGRESSO 	 		        CATEGORIA		ON CATEGORIA.ID_CATEGORIA_INGRESSO = INGRESSO.ID_CATEGORIA_INGRESSO
        INNER JOIN 		TB_TIPOS_INGRESSO   			        TIPO 			ON TIPO.ID_INGRESSO = INGRESSO.ID_INGRESSO
        INNER JOIN		TB_LOCAL_EVENTO					LOCAL			ON LOCAL.ID_LOCAL_EVENTO = INGRESSO.ID_LOCAL_EVENTO
	ORDER BY  	        NM_CATEGORIA_INGRESSO, NM_TIPO_INGRESSO;  
      
      
      
-- INSERTS PEDIDOS --------------------------------------------------------------------------------------------------------------------------------------------
      
INSERT INTO TB_CARTAO(NR_CARTAO, DT_VALIDADE, NR_CVV)
	   VALUES (12323, '2029-10-12', 190);      
      
INSERT INTO TB_FORMA_PAGAMENTO(ID_CARTAO)
	   VALUES (1);      
      
 INSERT INTO TB_PEDIDO_INGRESSO(ID_CLIENTE, ID_INGRESSO, ID_TIPO_INGRESSO, QTD_ITENS)
	   VALUES (1, 1, 1, 2); 
       
 INSERT INTO TB_PEDIDO(ID_PEDIDO_INGRESSO, ID_FORMA_PAGAMENTO, DT_PEDIDO, BT_SITUACAO)
	   VALUES (1, 1, now(), true); 
       

-- SELECTS  PEDIDO --------------------------------------------------------------------------------------------------------------------------------------------       

SELECT * FROM TB_CARTAO;
SELECT * FROM TB_FORMA_PAGAMENTO;
SELECT * FROM TB_PEDIDO_INGRESSO;

SELECT * FROM TB_PEDIDO;

      
   
SELECT  ID_PEDIDO,
        NM_CLIENTE,
        NM_SOBRENOME,
        DS_CPF,
        DS_TELEFONE,
        NM_EVENTO, 
        DT_COMECO,
        DT_FIM,
        DS_EVENTO,
        NM_TIPO_INGRESSO,
        VL_PRECO_TIPO,
        QTD_ITENS,
        DT_PEDIDO
            
        FROM 			TB_PEDIDO			PEDIDO
        INNER JOIN 		TB_PEDIDO_INGRESSO 	 	PDINGRESSO				ON PDINGRESSO.ID_PEDIDO_INGRESSO = PEDIDO.ID_PEDIDO_INGRESSO
        INNER JOIN 		TB_CADASTRO_CLIENTE 	        CLIENTE					ON CLIENTE.ID_CLIENTE = PDINGRESSO.ID_CLIENTE
        INNER JOIN 		TB_INGRESSO 	 		INGRESSO				ON INGRESSO.ID_INGRESSO = PDINGRESSO.ID_INGRESSO
	INNER JOIN 		TB_TIPOS_INGRESSO 	 	TIPO					ON TIPO.ID_TIPO_INGRESSO = PDINGRESSO.ID_TIPO_INGRESSO
        INNER JOIN 		TB_FORMA_PAGAMENTO   		FORMA_PAGAMENTO			        ON FORMA_PAGAMENTO.ID_FORMA_PAGAMENTO = PEDIDO.ID_FORMA_PAGAMENTO;
 

SELECT  NM_CATEGORIA_INGRESSO, 
        NM_EVENTO, 
        DT_COMECO,
        DS_EVENTO,
        IMAGEM_INGRESSO
        
        FROM 			TB_INGRESSO				INGRESSO
        INNER JOIN 		TB_CATEGORIA_INGRESSO 	 		CATEGORIA		ON CATEGORIA.ID_CATEGORIA_INGRESSO = INGRESSO.ID_CATEGORIA_INGRESSO
    WHERE NM_CATEGORIA_INGRESSO = "Museu"


SELECT 
  PI.ID_PEDIDO_INGRESSO,
  PI.ID_CLIENTE,
  PI.ID_INGRESSO,
  PI.ID_TIPO_INGRESSO,
  PI.QTD_ITENS,
  TI.NM_TIPO_INGRESSO,
  TI.QTD_TIPO_INGRESSO,
  TI.VL_PRECO_TIPO,
  ING.ID_CATEGORIA_INGRESSO,
  ING.ID_EMPRESA,
  ING.ID_LOCAL_EVENTO,
  ING.NM_EVENTO,
  ING.DS_EVENTO,
  ING.DT_COMECO,
  ING.DT_FIM,
  ING.IMAGEM_INGRESSO,
  ING.DT_CADASTRO,
  ING.BT_DESTAQUE
FROM TB_PEDIDO_INGRESSO PI
INNER JOIN TB_TIPOS_INGRESSO TI ON PI.ID_TIPO_INGRESSO = TI.ID_TIPO_INGRESSO
INNER JOIN TB_INGRESSO ING ON PI.ID_INGRESSO = ING.ID_INGRESSO;



SELECT 
  PI.ID_PEDIDO_INGRESSO,
  PI.ID_CLIENTE,
  PI.ID_INGRESSO,
  PI.ID_TIPO_INGRESSO,
  PI.QTD_ITENS,
  C.DS_EMAIL,
  C.ID_CLIENTE
FROM TB_PEDIDO_INGRESSO PI
INNER JOIN TB_CADASTRO_CLIENTE C ON PI.ID_CLIENTE = C.ID_CLIENTE;

-- Delete Pedido

delete from tb_pedido where ID_PEDIDO = 1 ;

delete from tb_pedido_ingresso where ID_PEDIDO_INGRESSO = 1;


-- Compra ingresso

INSERT INTO TB_CARTAO (NR_CARTA,DT_VALIDADE, NR_CVV) 
		VALUES ('11', '11', '11');



INSERT INTO TB_FORMA_PAGAMENTO (ID_CARTAO) 
	   VALUES ('1');



INSERT INTO TB_PEDIDO_INGRESSO (ID_CLIENTE, ID_INGRESSO, ID_TIPO_INGRESSO, QTD_ITENS) 
	   VALUES ('1', '1', '1', '50');



INSERT INTO TB_PEDIDO (ID_PEDIDO_INGRESSO, ID_FORMA_PAGAMENTO, DT_PEDIDO, BT_SITUACAO) 
			VALUES ('1', '1', now(), true);


-- fazer aqui pra baixo

UPDATE TB_PEDIDO_INGRESSO SET ID_CLIENTE = '2', ID_INGRESSO = '2', ID_TIPO_INGRESSO = '2', QTD_ITENS = '300' 
       WHERE (ID_PEDIDO_INGRESSO = '1');


UPDATE TB_PEDIDO SET BT_SITUACAO = '0' WHERE (`ID_PEDIDO` = '4');


SELECT *
FROM TB_PEDIDO_INGRESSO
INNER JOIN TB_CADASTRO_CLIENTE ON TB_PEDIDO_INGRESSO.ID_CLIENTE = TB_CADASTRO_CLIENTE.ID_CLIENTE
INNER JOIN TB_INGRESSO ON TB_PEDIDO_INGRESSO.ID_INGRESSO = TB_INGRESSO.ID_INGRESSO
INNER JOIN TB_TIPOS_INGRESSO ON TB_PEDIDO_INGRESSO.ID_TIPO_INGRESSO = TB_TIPOS_INGRESSO.ID_TIPO_INGRESSO;


SELECT *
FROM TB_PEDIDO
INNER JOIN TB_PEDIDO_INGRESSO ON TB_PEDIDO.ID_PEDIDO_INGRESSO = TB_PEDIDO_INGRESSO.ID_PEDIDO_INGRESSO
INNER JOIN TB_FORMA_PAGAMENTO ON TB_PEDIDO.ID_FORMA_PAGAMENTO = TB_FORMA_PAGAMENTO.ID_FORMA_PAGAMENTO;



