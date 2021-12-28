-- Lib para Mensajes del sistema
--Written By David Nuñez XD
--Based On ZeroZelta
mensaje = {}
mensaje.blucle = false

function mensaje.print(mode,msn_titulo,msn_icono,msn_texto,imagen)
mensaje.blucle = true
if mode == 1 then 
IMG_MENSAJE = image.load("system/grafics/mensaje_critico.png");
elseif mode == 2 then
IMG_MENSAJE = image.load("system/grafics/mensaje.png");
elseif mode == 3 then
IMG_MENSAJE = image.load("system/grafics/mensajewo.png");
end

if imagen == nil then IMG_MENSAJE_SCREEN = screen.toimage() end
if IMG_MENSAJE_SCREEN == nil then IMG_MENSAJE_SCREEN = screen.toimage() end

for i = 0,255,15 do
	IMG_MENSAJE_SCREEN:blit(0,0,255)
	IMG_MENSAJE:blit(0,0,i)
	msn_icono:blit(350,80,i)
	screen.print(92,60,msn_titulo,0.8,color.new(0,0,0,i),color.new(255,255,255,i))
	screen.print(92,83,msn_texto,0.6,color.new(0,0,0,i))
	if mode == 3 then
	screen.print(140,185,Okay,0.6,color.new(0,0,0,i))
	screen.print(280,185,Cancel,0.6,color.new(0,0,0,i))
	else 
	screen.print(211,187,Okay,0.6,color.new(0,0,0,i))
	end
	screen.flip()
end

while mensaje.blucle do
	IMG_MENSAJE_SCREEN:blit(0,0,255)
	IMG_MENSAJE:blit(0,0,255)
	msn_icono:blit(350,80,255)

	screen.print(92,60,msn_titulo,0.8,color.new(0,0,0),color.new(255,255,255))
	screen.print(92,83,msn_texto,0.6,color.new(0,0,0))
	if mode == 3 then
	screen.print(140,185,Okay,0.6,color.new(0,0,0))
	screen.print(280,185,Cancel,0.6,color.new(0,0,0))
	else 
	screen.print(211,187,Okay,0.6,color.new(0,0,0))
	end
	mensaje.controlsRead()
	screen.flip()
end

for i = 255,0,-15 do
IMG_MENSAJE_SCREEN:blit(0,0,255)
IMG_MENSAJE:blit(0,0,i)
msn_icono:blit(350,80,i)
	screen.print(92,60,msn_titulo,0.8,color.new(0,0,0,i),color.new(255,255,255,i))
	screen.print(92,83,msn_texto,0.6,color.new(0,0,0,i))
	if mode == 3 then
	screen.print(140,185,Okay,0.6,color.new(0,0,0,i))
	screen.print(280,185,Cancel,0.6,color.new(0,0,0,i))
	else 
	screen.print(211,187,Okay,0.6,color.new(0,0,0,i))
	end
screen.flip()
end

buttons.read() -- Leemos los botones
IMG_MENSAJE_SCREEN:blit(0,0,255)
screen.flip()
if mode == 3 then
return Opcion
end
end

function mensaje.controlsRead()
buttons.read() -- Leemos los botones

if buttons.circle then
mensaje.blucle = false
Opcion = false
end

if buttons.cross then
mensaje.blucle = false
Opcion = true 
end

end

function mensaje.free(full)
IMG_MENSAJE=nil
--sound_alerta:free()
mensaje.blucle = nil
msn_texto = nil

if full == true then 
IMG_MENSAJE_SCREEN=nil
mensaje = nil
end

collectgarbage("collect")
end
