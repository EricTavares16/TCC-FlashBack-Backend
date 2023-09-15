
import { con } from "../connection.js";


export async function InserirCliente (cliente) {

    const comando = 
    `      INSERT INTO TB_CADASTRO_CLIENTE (NM_CLIENTE, NM_SOBRENOME, DS_CPF, DS_TELEFONE, NM_USUARIO, DS_EMAIL, DS_SENHA)
	            VALUE (?, ?, ?, ?, ?, ?, ?)`

    const [resposta] = await con.query(comando, 
        [
            cliente.Nome,
            cliente.Sobrenome,
            cliente.CPF,
            cliente.Telefone,
            cliente.NomeUsuario,
            cliente.Email,
            cliente.Senha,

        ])

    cliente.ID = resposta.insertId;

    return cliente;
}

export async function login(email, senha){
    
    const comando = 
    `   SELECT  NM_USUARIO,    
                DS_EMAIL,      
                DS_SENHA   
        FROM TB_CADASTRO_CLIENTE 
        WHERE  DS_EMAIL = ? 
        AND    DS_SENHA = ?`
    
    const [resposta] = await con.query(comando,[email, senha])
    return resposta[0]
}