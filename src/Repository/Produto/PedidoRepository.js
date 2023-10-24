import { con } from "../connection.js";



export async function InserirPedidoIngresso(pedido){

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


export async function InserirPedido(pedido){

    const comando = 
    `
    INSERT INTO tb_pedido (ID_PEDIDO_INGRESSO, ID_FORMA_PAGAMENTO, DT_PEDIDO, BT_SITUACAO) 
           VALUES (?, ?, now(), ?)
    `

    const [resposta] = await con.query(comando, 
    [
        pedido.PedidoIngresso,
        pedido.FormaPagamento,
        pedido.Situacao
    ])

    pedido.id = resposta.insertId

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


export async function ListarPedidoIngresso(){
    const comando = 
    `
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
        INNER JOIN TB_INGRESSO ING ON PI.ID_INGRESSO = ING.ID_INGRESSO
    `
    

    const [resposta] = await con.query(comando)

    return resposta
}


export async function DeletarPedido(id){
    const comando = 
    `
        DELETE FROM TB_PEDIDO 
                    WHERE ID_PEDIDO = ?
    `

    const [resposta] = await con.query(comando,[id])

    return resposta.affectedRows
}



export async function DeletarPedidoIngresso(id){

    const comando1 = 
    `
    
        DELETE FROM TB_PEDIDO 
                    WHERE ID_PEDIDO_INGRESSO = ?

    `


    const comando2 = 
    `

        DELETE FROM TB_PEDIDO_INGRESSO 
                    WHERE ID_PEDIDO_INGRESSO = ?

    `

    const [resposta1] = await con.query(comando1, [id])
    const [resposta2] = await con.query(comando2, [id])

    return resposta2.affectedRows
}