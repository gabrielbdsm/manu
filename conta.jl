module conta
using MySQL
using DBInterface
using DataFrames


# #conectar/criar banco de dados
# db = SQLite.DB("client.db")

# # criar TABLE
# SQLite.execute(db,"CREATE TABLE IF NOT EXISTS conta(
#     id_cliente INTEGER REFERENCES dados (id_cliente) ON DELETE CASCADE
#                                                      ON UPDATE CASCADE
#                        UNIQUE,
#     n_conta    INTEGER PRIMARY KEY AUTOINCREMENT
#                        UNIQUE,
#     saldo      REAL    DEFAULT (0),
#     agencia    TEXT
# )")

function conectar()
db = DBInterface.connect(MySQL.Connection, "us-cdbr-east-04.cleardb.com", "be33b42da89cde", "767dbcfc" , port=3306 , reconnect = true ,connect_timeout = 3600 )

DBInterface.execute(db, "use heroku_3761ec7676be692")
DBInterface.execute(db, """CREATE TABLE IF NOT EXISTS conta
(
    id_cliente INT ,
    n_conta     INT NOT NULL AUTO_INCREMENT,
    agencia     varchar(255) DEFAULT '0001',
    saldo FLOAT DEFAULT 0,
    PRIMARY KEY (n_conta),
    FOREIGN KEY (id_cliente) REFERENCES dados(id_cliente) ON DELETE CASCADE
    
                )AUTO_INCREMENT = 100000000;""")

  return db         

end

function inseir_id(id_cliente)
    db = conectar()
    DBInterface.execute(db,"INSERT INTO conta(id_cliente ) VALUES ($id_cliente)")
    DBInterface.close!(db::MySQL.Connection)
end



function verificar_existencia(coluna , linha )
    try
            db = conectar()
            select =DBInterface.execute(db, "SELECT $coluna FROM conta WHERE $coluna = '$linha'")
            select = DataFrames.DataFrame(select)
            select = Tuple(select[1,:])
            DBInterface.close!(db::MySQL.Connection)
        catch
            return false
        end
        
        return true
    

end

function  consultar(coluna , linha)
    if  verificar_existencia(coluna , linha) == true
    db = conectar()
    select = DBInterface.execute(db, "SELECT * FROM conta WHERE $coluna = '$linha'")
    select = DataFrames.DataFrame(select)
    select= NamedTuple(select[1,:])
    DBInterface.close!(db::MySQL.Connection)
    return select
   else
        return -1
     end

end

end


