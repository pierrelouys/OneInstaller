--=============================================
--[[
	Libreria Stars 
	Version 1.0
	Creada y diseñada por: 
	David Nuñez A. David.nunezaguilera.131@gmail.com
	01/12/2014 a las 10:30 PM
	
	Descripcion:
	Esta Lib Nos Facilita la tarea de dibujar estrellas o particulas aleatorias :)
	
	Modo de Uso:
	"Cargamos la libreria"
		dofile(ruta a libreria)
		"Ejemplo"
			dofile("libstars.lua")
	"Iniciamos los recursos" Nota: Solo se realiza una vez.
	stars.init(MyColor) 
	MyColor = Objeto color con el cual se dibujaran las particulas
	Si se omite se usara el default, Blanco
	"Dibujamos Particulas" Nota: Normalmente, dentro de un bucle
	stars.draw(Mode)
	Mode = Tipo de dezplazamiento
	Mode = 0 o Omitido: Derecha a Izqierda
	Mode = 1: Izqierda a Derecha
	Mode = 2: Arriba a Abajo
	Mode = 3: Abajo a Arriba
	"Una Muestra del Funcionamiento" 
	Nota: es solo de muestra por lo cual, solo se carga la lib y esta funcion y se mostrara en pantalla un ejemplo
	stars.test(MyColor)
	MyColor = Objeto color con el cual se dibujaran las particulas.
	Con los Botones de direcciones muestra los cuatro modos disponibles
	Espero a mas de una persona le sea util. :)
--]]
--=============================================
stars = {}
function stars.init(MyColor)
	if MyColor then
	stars.obj = image.new(3,3,MyColor)
	else
	stars.obj = image.new(3,3,color.new(255,255,255))
	end
	stars.aleatorio={}
	for i=1,100 do
		stars.aleatorio[i] = {X=math.random(480,960), Y=math.random(0,272),S=(math.random(0,2)+math.random(0,1)),B=math.random(0,255),W=math.random(0,500)}
	end
end

function stars.draw(Mode)
	if Mode == 3 then
		for i=1,100 do--Abajo hacia arriba
			stars.aleatorio[i].Y=stars.aleatorio[i].Y-stars.aleatorio[i].S
			stars.aleatorio[i].B=stars.aleatorio[i].B-1
			if stars.aleatorio[i].Y<=0 then
				stars.aleatorio[i].Y=272
				stars.aleatorio[i].X=math.random(0,480)
			end
			if stars.aleatorio[i].B<=0 then
				stars.aleatorio[i].B=255
			end
			stars.obj:blit(stars.aleatorio[i].X, stars.aleatorio[i].Y,stars.aleatorio[i].B)
		end
	elseif Mode == 2 then
		for i=1,100 do--Arriba a Abajo
			stars.aleatorio[i].Y=stars.aleatorio[i].Y+stars.aleatorio[i].S
			stars.aleatorio[i].B=stars.aleatorio[i].B-1
			if stars.aleatorio[i].Y>=272 then
				stars.aleatorio[i].Y=0
				stars.aleatorio[i].X=math.random(0,480)
			end
			if stars.aleatorio[i].B<=0 then
				stars.aleatorio[i].B=255
			end
			stars.obj:blit(stars.aleatorio[i].X, stars.aleatorio[i].Y,stars.aleatorio[i].B)
		end
	elseif Mode == 1 then
		--Solucionado, solo se crea la var, W de 0 - 480 X de 480 - 960
		-- No Implementado, No encuentro el error :(
		for i=1,100 do -- izqierda a derecha
			stars.aleatorio[i].W=stars.aleatorio[i].W+stars.aleatorio[i].S
			stars.aleatorio[i].B=stars.aleatorio[i].B-1
			if stars.aleatorio[i].W>=480 then
				stars.aleatorio[i].W=0
				stars.aleatorio[i].Y=math.random(0,272)
			end
			if stars.aleatorio[i].B<=0 then
				stars.aleatorio[i].B=255
			end
			stars.obj:blit(stars.aleatorio[i].W, stars.aleatorio[i].Y,stars.aleatorio[i].B)
		end
	elseif Mode == 0 or Mode == nil then
		for i=1,100 do -- derecha a izqierda
			stars.aleatorio[i].X=stars.aleatorio[i].X-stars.aleatorio[i].S
			stars.aleatorio[i].B=stars.aleatorio[i].B-1
			if stars.aleatorio[i].X<=0 then
				stars.aleatorio[i].X=480
				stars.aleatorio[i].Y=math.random(0,272)
			end
			if stars.aleatorio[i].B<=0 then
				stars.aleatorio[i].B=255
			end
			stars.obj:blit(stars.aleatorio[i].X, stars.aleatorio[i].Y,stars.aleatorio[i].B)
		end
	end
end
function stars.test(MyColor)
	stars.init(MyColor)
	modo = 0
	while true do
		buttons.read()
	if buttons.up then
	modo = 3
	elseif buttons.down then
	modo = 2
	elseif buttons.right then
	modo = 1
	elseif buttons.left then
	modo = 0
	end
		stars.draw(modo)
		screen.flip()
	end
end
