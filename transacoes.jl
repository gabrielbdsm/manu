using SQLite
using DataFrames

function  atualiza_endere(id_cliente ,coluna , linha)


    SQLite.execute(db,"UPDATE endereco SET $coluna = '$linha' WHERE id_cliente = $id_cliente")
end    