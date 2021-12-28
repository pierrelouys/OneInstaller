
function post(Link,Comment)
 	w,x = string.find(Link, "/",1,true)
	host = string.sub(Link, 1, w-1)
	form =string.sub(Link, w)
	local Mysocket,error,bytesSent,header,longitud,leer,total
	-- Abrimos el puerto a el servidor
	Mysocket = socket.connect(host,80)
	os.delay(20)
	-- Enviamos Peticion Post :) 
	Mysocket:send("POST "..form.." HTTP/1.1\r\n".."host: "..host.."\r\n")
	Mysocket:send("Content-Type: application/x-www-form-urlencoded\r\n")
	Mysocket:send("Content-Length: "..string.len(Comment).."\r\n\r\n")
	Mysocket:send(Comment.."\r\n")
	os.delay(10)
 
	-- Recibimos Header con info
	header=""
	tmp0 = ""
	while true do
	tmp0 = Mysocket:recv(1)
	    header = header.. tmp0
	    if tmp0 == "" then 
			break 
		end
    end
	--screen.print(10,10,"Cabecera Recibida")
	--screen.print(10,30,header) 
	-- Obtenemos el Size del archivo a descargar
	--screen.flip()
	--Iniciamos la recepcion del archivo
	--os.delay(50)
	Mysocket:close()
	 return fin
end