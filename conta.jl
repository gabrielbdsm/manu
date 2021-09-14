module conta
using SQLite
using DataFrames


#conectar/criar banco de dados
db = SQLite.DB("client.db")

# criar TABLE
SQLite.execute(db,"CREATE TABLE IF NOT EXISTS conta(
    id_cliente INTEGER REFERENCES dados (id_cliente) ON DELETE CASCADE
                                                     ON UPDATE CASCADE
                       UNIQUE,
    n_conta    INTEGER PRIMARY KEY AUTOINCREMENT
                       UNIQUE,
    saldo      REAL    DEFAULT (0),
    agencia    TEXT
)")




function inseir_id(id_cliente)
    SQLite.execute(db,"INSERT INTO conta(id_cliente , agencia) VALUES ($id_cliente , '0001')")
end



function verificar_existencia(coluna , linha )
    try
        
            select =SQLite.DBInterface.execute(db, "SELECT $coluna FROM conta WHERE $coluna = '$linha'")
            select = DataFrames.DataFrame(select)
            select = Tuple(select[1,:])
        catch
            return false
        end
        
        return true
    

end

function  consultar(coluna , linha)
    if  verificar_existencia(coluna , linha) == true
    select =SQLite.DBInterface.execute(db, "SELECT * FROM conta WHERE $coluna = '$linha'")
    select = DataFrames.DataFrame(select)
    select= NamedTuple(select[1,:])
    
    return select
   else
        return -1
     end
end



end