
import {inserirIngresso, removerIngresso, ListarIngressos, alterarIngresso, AlterarCapaIngresso} from "../../Repository/Produto/IngressoRepository.js"

import multer from "multer";

const upload = multer ({dest: 'Storage/capasIngressos'})

import { Router } from "express";
const endpoints  = Router();



endpoints.post('/ingresso', async (req, resp) => {

    try {

        const inserir = req.body

        if(!inserir.Categoria)
            throw new Error('Nome categoria obrigatória!')

        if(!inserir.Empresa)
            throw new Error('Nome Empresa obrigatória!')
        
        if(!inserir.NomeEvento)
            throw new Error('Nome evento obrigatório!')

        if(!inserir.Descricao)
            throw new Error('Descrição obrigatória!')
     
        if(!inserir.DataComeco)
           throw new Error('Data de início obrigatória!')

        if(!inserir.DataFim)
           throw new Error('Data de fim obrigatória!')


        const ingressoInserido = await inserirIngresso(inserir)

        if(ingressoInserido.length > 0)
            throw new Error('Ingresso já cadastrado')

        resp.send(ingressoInserido)
        
    } catch (err) {
        resp.status(404).send({
            erro: err.message
        })     
    }
})


endpoints.get('/ingresso',async (req, resp) => {
    try{
        // n tem validação 
        const listagem = await ListarIngressos()
        resp.send(listagem)

    } catch(err) {
        resp.status(400).send({
            erro: err.message
        })
    }
    
})


endpoints.put('/ingresso/:id/capa', upload.single('capa'), async (req, resp) => {

    try {

        const {id} = req.params

        const imagem = req.file.path
        
        const resposta = await AlterarCapaIngresso(imagem, id)

        if (resposta != 1)
            throw new Error ('A imagem não pode ser salva')  

        resp.status(204).send()
        
    } catch (err) {
        resp.status(401).send({
            erro: err.message
        })
    }

})


endpoints.put('/ingresso/:id', async (req, resp) => {

    try {
        
        const {id} = req.params

        const ingresso = req.body

        
        if(!ingresso.Categoria)
            throw new Error('Nome categoria obrigatória!')

        if(!ingresso.Empresa)
            throw new Error('Nome Empresa obrigatória!')
        
        if(!ingresso.NomeEvento)
            throw new Error('Nome evento obrigatório!')

        if(!ingresso.Descricao)
            throw new Error('Descrição obrigatória!')
     
        if(!ingresso.DataComeco)
           throw new Error('Data de início obrigatória!')

        if(!ingresso.DataFim)
           throw new Error('Data de fim obrigatória!')

        if(isNaN(id))
            throw new Error('Id obrigatório')
        

        const alterar = await alterarIngresso(id, ingresso)

        resp.status(204).send()

    } catch (err) {

        resp.status(400).send({
            erro: err.message
        })
        
    }
})


endpoints.delete('/ingresso/:id', async (req, resp) => {
    try {
        
        const {id} = req.params

        const deletar = await removerIngresso(id)

        if(deletar == 0)
            throw new Error('ingresso  não pode ser deletada');
        
        resp.status(204).send()

    } catch (err) {
        resp.status(400).send({
            erro: err.message
       })
    }
})

export default endpoints;