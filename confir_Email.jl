module confir_Email
    
using PyCall

function enviar_email(email)
    
    smtplib = pyimport("smtplib")
    random = pyimport("random")
    
    # ic.interner.banking@gmail.com tqshgnuadzjgsgqo senha Ic.Banking2021
    
    msg_From = "ic.interner.banking@gmail.com"
    msg_To = email
    password = "tqshgnuadzjgsgqo"
    
    codigo =random.randrange(1000,9999)
    
    SUBJECT = "IC internet banking "
    TEXT = "Seu codigo de reconhecimento:  $codigo"
    message = "Subject: $SUBJECTrnrn$TEXT"
    
    
    server = smtplib.SMTP_SSL("smtp.gmail.com", 465)
    server.login(msg_From, password )
    server.sendmail(
        msg_From,
        msg_To,
        message)
        
        server.quit()
    return codigo        
end
    
    
end