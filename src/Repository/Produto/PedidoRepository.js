import { con } from "../connection.js";



export async function InserirPedido(pedido){

    const comando = `
    
        INSERT INTO TB_PEDIDO_INGRESSO(ID_CLIENTE, ID_INGRESSO, ID_TIPO_INGRESSO, QTD_ITENS)
               VALUES (?, ?, ?, ?) 
    `

    const [resposta] = await con.query(comando, 
        [
            pedido.Cliente, 
            pedido.Ingresso,
            pedido.TipoIngresso,
            pedido.Itens
        ])

    pedido.ID = resposta.insertId


    return pedido
}



export async function ListarPedido(){
    const comando = `
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
            
        FROM 			TB_PEDIDO				PEDIDO
        INNER JOIN 		TB_PEDIDO_INGRESSO 	 	PDINGRESSO				ON PDINGRESSO.ID_PEDIDO_INGRESSO = PEDIDO.ID_PEDIDO_INGRESSO
        INNER JOIN 		TB_CADASTRO_CLIENTE 	CLIENTE					ON CLIENTE.ID_CLIENTE = PDINGRESSO.ID_CLIENTE
        INNER JOIN 		TB_INGRESSO 	 		INGRESSO				ON INGRESSO.ID_INGRESSO = PDINGRESSO.ID_INGRESSO
        INNER JOIN 		TB_TIPOS_INGRESSO 	 	TIPO					ON TIPO.ID_TIPO_INGRESSO = PDINGRESSO.ID_TIPO_INGRESSO
        INNER JOIN 		TB_FORMA_PAGAMENTO   	FORMA_PAGAMENTO			ON FORMA_PAGAMENTO.ID_FORMA_PAGAMENTO = PEDIDO.ID_FORMA_PAGAMENTO
    `

    const [resposta] = await con.query(comando)

    return resposta
}
