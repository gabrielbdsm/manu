module login
using Genie
using Genie.Router, Genie.Renderer, Genie.Renderer.Html, Genie.Renderer.Json, Genie.Requests
using JSON
using DataFrames
using JSONTables
include("bd_cadrato.jl")
include("conta.jl")


#ic-banking-2021 

# println(JSON.json(x))

route("/login" , method = POST) do
    cpf = postpayload(:cpf)
    senha = postpayload(:senha)
    usuario = bd_cadrato.consultar("cpf",cpf)
   
    if usuario == -1
        return "CPF NÃO cadrastada"
    elseif senha != usuario.senha
        return "senha incorreta"
    else

        dados = conta.consultar("id_cliente",usuario.id_cliente)
        dados = JSON.json(dados)
        dados = JSON.Parser.parse(dados)
        #dados["cpf"] = cpf
        
        
        return  JSON.json(dados)
    end
        
end
  


end
