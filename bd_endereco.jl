module bd_endereco
using MySQL
using DBInterface
using DataFrames



db = DBInterface.connect(MySQL.Connection, "us-cdbr-east-04.cleardb.com", "be33b42da89cde", "767dbcfc" , port=3306 , reconnect = true ,connect_timeout = 120 )
DBInterface.execute(db, "use heroku_3761ec7676be692")

DBInterface.execute(db, """CREATE TABLE IF NOT EXISTS conta
(
    id_cliente INT ,
    cep          varchar(255) NOT NULL,
    uf         varchar(255) NOT NULL,
    cidade        varchar(255) NOT NULL,
    email        varchar(255) NOT NULL,
    bairro     varchar(255) NOT NULL,
    rua varchar(255) NOT NULL,
    numero varchar(255) NOT NULL,
    complemento varchar(255) ,
    FOREIGN KEY (id_cliente) REFERENCES dados(id_cliente) ON DELETE CASCADE
    
                 );""")
DBInterface.close(db)

function inseir_id(id_cliente)
    db = DBInterface.connect(MySQL.Connection, "us-cdbr-east-04.cleardb.com", "be33b42da89cde", "767dbcfc" , port=3306 , reconnect = true ,connect_timeout = 3600 )
    DBInterface.execute(db, "use heroku_3761ec7676be692")
    DBInterface.execute(db,"INSERT INTO endereco(id_cliente ) VALUES ($id_cliente)")

    DBInterface.close(db)
end

function  atualiza_endere(id_cliente ,coluna , linha)
    db = DBInterface.connect(MySQL.Connection, "us-cdbr-east-04.cleardb.com", "be33b42da89cde", "767dbcfc" , port=3306 , reconnect = true ,connect_timeout = 3600 )
    DBInterface.execute(db, "use heroku_3761ec7676be692")

    DBInterface.execute(db,"UPDATE endereco SET $coluna = '$linha' WHERE id_cliente = $id_cliente")
    
    DBInterface.close(db)

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