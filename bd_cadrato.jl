module test_bd
    
using MySQL
using DBInterface
using DataFrames

db = DBInterface.connect(MySQL.Connection, "127.0.0.1", "root", "gabriel2808" , port=3306)
try
    DBInterface.execute(db, "CREATE DATABASE test")
    
catch
    println("database já esxite")
end
DBInterface.execute(db, "use test")
DBInterface.execute(db, """CREATE TABLE IF NOT EXISTS dados
(
    id_cliente INT NOT NULL AUTO_INCREMENT,
    cpf          varchar(255) NOT NULL,
    nome         varchar(255) NOT NULL,
    senha        varchar(255) NOT NULL,
    email        varchar(255) NOT NULL,
    telefone     varchar(255) NOT NULL,
    senha_cartao varchar(255) NOT NULL,
    PRIMARY KEY (id_cliente)
    
                 );""")
                 
                 
function insert(cpf,nome,senha , email , telefone ,senha_cartao )
                    
    DBInterface.execute(db, """INSERT INTO dados(cpf,nome,senha, email, telefone , senha_cartao) VALUES
    ('$cpf','$nome','$senha' ,'$email', '$telefone' ,'$senha_cartao');""")
                    
end


function verificar_existencia(coluna , linha )
    try
        
            select =DBInterface.execute(db, "SELECT $coluna FROM dados WHERE $coluna = '$linha'")
            select = DataFrames.DataFrame(select)
            select = Tuple(select[1,:])
        catch
            return false
        end
        
        return true
    

end

function  consultar(coluna , linha)
    if  verificar_existencia(coluna , linha) == true
    select = DBInterface.execute(db, "SELECT * FROM dados WHERE $coluna = '$linha'")
    select = DataFrames.DataFrame(select)
    select= NamedTuple(select[1,:])
    
    return select
   else
        return -1
     end
end





end