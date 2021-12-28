DownVelocity = timer.new()
DownVelocity:start()
SobreUpDate = true

function onExtractFiles(size,bytes,file)
	system.draw_back(0) -- Sin estrellas
	system.draw_bar()
	draw.fillrect(5,30,330,115,Black_Mate)
	screen.print(10,35,txtDescarga)
	draw.fillrect(5,150,330,115,Black_Mate)
	screen.print(10,155,txtInstalacion)
	draw.fillrect(340,30,135,70,Black_Mate)
	screen.print(345,35,advertencia,0.6)
	Warning:blit(445,30)
	--draw.fillrect(340,237,135,30,Black_Mate)
	draw.rect(10,100,320,21,color.white)
	draw.fillrect(12,102,316,17,color.green)
    screen.print(285,35,"100 %")
	--shotimg:blit(0,0)
	screen.print(10,167,file)
	if (size ~= 0) then
		screen.print(285,155,math.floor(bytes*(100)/size).." % ")
		draw.rect(10,200,320,21,color.white)
		local Ancho = math.floor(bytes*(316)/size)
		draw.fillrect(12,202,Ancho,17,color.green)
	else
		screen.print(285,155,txtEscritos..bytes.."Bytes")
	end
	screen.flip()
end


function onNetGetFile(size,bytes)
	if SobreUpDate then
	Back_UpDate(size,bytes)
	else
	Back_CallBack(size,bytes)
	end
	screen.flip()
end

function Back_CallBack(size,bytes)
	system.draw_back(0) -- Sin estrellas
	system.draw_bar()
	draw.fillrect(5,30,330,115,Black_Mate)
	screen.print(10,35,txtDescarga)
	draw.fillrect(5,150,330,115,Black_Mate)
	screen.print(10,155,txtInstalacion)
	draw.fillrect(340,30,135,70,Black_Mate)
	screen.print(345,35,advertencia,0.6)
	Warning:blit(445,30)
	--draw.fillrect(340,237,135,30,Black_Mate)
	if (size ~= 0) then
		draw.rect(10,100,320,21,color.white)
		local Ancho = math.floor(bytes*(316)/size)
		draw.fillrect(12,102,Ancho,17,color.green)
	    screen.print(285,35,math.floor(bytes*(100)/size).." % ")
		screen.print(120,125,bytes.." - "..size.."Bytes")
	else
		draw.rect(10,100,320,21,color.white)
		draw.fillrect(12,102,158,17,color.green)
		screen.print(120,125,txtEscritos..bytes.."Bytes")
	end
end

function Back_UpDate(size,bytes)
	if not backUD then	backUD = image.load("system/grafics/upback.png") end
	if backUD then backUD:blit(0,0) end
	if not licen then	licen = image.load("system/grafics/cc_by-sa.png") end
	if licen then licen:blit(5,30) end
	system.draw_bar()
	draw.fillrect(340,105,135,70,Black_Mate)
	screen.print(345,110,txtActualizando)
	draw.fillrect(340,30,135,70,Black_Mate)
	screen.print(345,35,advertencia,0.6)
	Warning:blit(445,30)
	draw.fillrect(5,200,470,62,Black_Mate)
	screen.print(38,204,txtDescarga)
	if (size ~= 0) then
		draw.rect(38,218,404,21,color.white)
		local Ancho = math.floor(bytes*(400)/size)
		draw.fillrect(40,220,Ancho,17,color.green)
	    screen.print(100,240,math.floor(bytes*(100)/size).." % ")
	else
		draw.rect(38,218,404,21,color.white)
		draw.fillrect(40,220,200,17,color.green)
		screen.print(100,240,txtEscritos..bytes.."Bytes")
	end
end