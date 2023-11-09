import 'dotenv/config'

// Controllers Users -----------------------------------------------------------------------------------------

import ClienteController from './Controller/Users/ClienteController.js'
import EmpresaController from './Controller/Users/EmpresaController.js'
import AdmController from './Controller/Users/AdmController.js'

// Controllers Produto -----------------------------------------------------------------------------------------

import CategoriaController from './Controller/Produto/CategoriaController.js'
import IngressoController from './Controller/Produto/IngressoController.js'
import TipoIngressoController from './Controller/Produto/TipoIngressoController.js'
import LocalEventoController from './Controller/Produto/LocalEventoController.js'
import PedidoController from './Controller/Produto/PedidoController.js'
import CompraController from './Controller/Produto/CompraController.js'
import DataseHorarios from './Controller/Produto/Datas_horariosController.js'

import cors from 'cors'
import express from 'express'


const server = express()

server.use(cors())
server.use(express.json())

server.use('/Storage/capasIngressos', express.static('Storage/capasIngressos'))

server.use(ClienteController)
server.use(EmpresaController)
server.use(AdmController)


server.use(CategoriaController)
server.use(IngressoController)
server.use(TipoIngressoController)
server.use(LocalEventoController)
server.use(PedidoController)
server.use(CompraController)
server.use(DataseHorarios)



server.listen(process.env.PORT, 
            () => console.log(`A API está funcionando na porta ${process.env.PORT}`))

