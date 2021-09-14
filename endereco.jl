module endereco
    

using Genie
using Genie.Router, Genie.Renderer, Genie.Renderer.Html, Genie.Renderer.Json, Genie.Requests
using JSON
using DataFrames
using JSONTables
using  JSON , HTTP
include("bd_endereco.jl")

route("/Endereco", method = POST) do 
    id_cliente = postpayload(:id_cliente)
    id_cliente = parse(Int64 ,id_cliente)
    cep = postpayload(:cep)
    dados=api_endereco(cep)
    
    if dados == false
        return "CEP não encontrado"
    else
        numero = postpayload(:numero)
        complemeto = postpayload(:complemento)
        bd_endereco.atualiza_endere(id_cliente ,"cep",cep)
        bd_endereco.atualiza_endere(id_cliente ,"uf",dados["uf"])
        bd_endereco.atualiza_endere(id_cliente ,"cidade",dados["localidade"])
        bd_endereco.atualiza_endere(id_cliente ,"bairro",dados["bairro"])
        bd_endereco.atualiza_endere(id_cliente ,"rua",dados["logradouro"])
        bd_endereco.atualiza_endere(id_cliente ,"numero" , numero)
        bd_endereco.atualiza_endere(id_cliente ,"complemento" , complemeto)
        return "POST ok"
    end

    
end

function api_endereco(cep)
    
    url = "https://viacep.com.br/ws/$cep/json/"
    try
        resp = HTTP.get(url)
    catch
        return false
        
    end
    resp = HTTP.get(url)
    dados = JSON.Parser.parse(String(resp.body))
    return dados

    
end



end