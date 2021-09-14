module bd_endereco
using SQLite
using DataFrames

#conectar/criar banco de dados
db = SQLite.DB("client.db")

# criar TABLE
SQLite.execute(db,"CREATE TABLE IF NOT EXISTS endereco(
id_cliente  INT  REFERENCES dados (id_cliente) ON DELETE CASCADE ON UPDATE CASCADE PRIMARY KEY UNIQUE,
cep         TEXT,
uf          TEXT,
cidade      TEXT,
bairro      TEXT,
rua         TEXT,
numero      TEXT,
complemento TEXT)")

function inseir_id(id_cliente)
    SQLite.execute(db,"INSERT INTO endereco(id_cliente) VALUES ($id_cliente)")
end

function  atualiza_endere(id_cliente ,coluna , linha)


SQLite.execute(db,"UPDATE endereco SET $coluna = '$linha' WHERE id_cliente = $id_cliente")
    
end

# function inseir(cep,uf,cidade,bairro,rua,numero,complemento)
    
#     SQLite.execute(db,"INSERT INTO endereco(
#     cep, 
#     uf,
#     cidade,
#     bairro,
#     rua,
#     numero,
#     complemento) VALUES
#     ('$cep','$uf','$cidade','$bairro','$rua','$numero','$complemento')")
    
# end

end