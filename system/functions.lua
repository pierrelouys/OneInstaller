-- Modulo Funciones 
-- Cargamos la lib_stars
dofile("system/libs/lib_stars.lua")
-- Cargamos Lib_Post
dofile("system/libs/lib_post.lua")--post(Link,Comment)
-- Cargamos Lib KBD
dofile("system/lib_kbd/lib_kbd.lua")
kbd.theme("bluefish")
kbd.set(320,70)
-- Cargamos Modulo Comentarios
dofile("system/Comment.lua")

-- Inicializamos las stars
stars.init(color.yellow)
--Vars de scroll's
limit = {}
init={}
selit = {}
Actualizar_MS = true
Categoria_Actual = 1
sel_menu = true
sel_hb = false
-- Funciones Principales 
system = {}
-- Funciones Impresion
show = {}
-- Carga Recursos IMG
function system.load()
img_intensidad = {image.load("system/grafics/wifi0.png"),image.load("system/grafics/wifi1.png"),image.load("system/grafics/wifi2.png"),image.load("system/grafics/wifi3.png")}
iconoprx = image.load("system/icons/generic_prx_1.png")
Warning =image.load("system/grafics/alert.png")
img_update = image.load("system/grafics/update network.png")
Question = image.load("system/grafics/question.png")
pad = image.load("system/grafics/pad.png")
ico_One = image.load("system/grafics/one_ico.png")
Memory_ico = image.load("system/grafics/ms_icon.png")
end
-- Carga el Texto segun el idioma
function system.detect_language()
	if os.getlanguage() == "SPANISH" then
		dofile("system/language/spanish.lua")
	else
		dofile("system/language/english.lua")
	end
end
-- Dibuja el Fondo y las estrellas
function system.draw_back(mode)
	if back then
		back:blit(0,0)
	else 
		back = image.load("system/grafics/bg.png")
	end
	if mode == nil then
		stars.draw()
	end
end
-- Dibuja la barra superior
function system.draw_bar()
	draw.fillrect(5,5,470,20,Black_Mate)
	--Hora = string.sub(os.getdate(),14,18)
	--screen.print(345,10,Hora)
	screen.print(10,8,"OneInstaller 1.4.0v")
	local tmpi = system.draw_batt(450,10)
	screen.print(400,10,tmpi.."%")
	draw.line(395,5,395,25,color.white)
	local intensidad_wifi = wlan.strength()
	if intensidad_wifi then
		if intensidad_wifi > 75 then
			frame = 4
		elseif intensidad_wifi > 50 then
			frame = 3
		elseif intensidad_wifi > 25 then
			frame = 2
		else
			frame = 1
		end
		img_intensidad[frame]:blit(370,10)
		screen.print(320,10,intensidad_wifi.."%")
	else
		img_intensidad[1]:blit(370,10)
		screen.print(320,10,"0%")
	end
	draw.line(318,5,318,25,color.white)
	Memory_ico:blit(295,7)
	sizeMSFREE = ""
	sizeMSMAX = ""
	if Actualizar_MS then
		Actualizar_MS = false
		MS = os.infoms0()
		if MS.free and MS.max then
			if MS.free > 1* 1024*1024*1024	then -- GB
				MS.free = MS.free/ 1024/1024/1024
				sizeMSFREE = "Gb"
			elseif MS.free > 1*1024*1024 then --MB
				MS.free = MS.free/1024/1024
				sizeMSFREE = "Mb"
			elseif MS.free > 1*1024 then --KB
				MS.free = MS.free/1024
				sizeMSFREE = "Kb"
			else
				MS.free = MS.free
				sizeMSFREE = "B"
			end
			
			if MS.max > 1* 1024*1024*1024 then -- GB
				MS.max = MS.max/ 1024/1024/1024
				sizeMSMAX = "Gb"
			elseif MS.max > 1*1024*1024 then --MB
				MS.max = MS.max/1024/1024
				sizeMSMAX = "Mb"
			elseif MS.free > 1*1024 then --KB
				MS.max = MS.max/1024
				sizeMSMAX = "Kb"
			else 
				MS.max = MS.max
				sizeMSMAX = "B"
			end
			
			MS.free = string.format("%.2f"..sizeMSFREE,MS.free)
			MS.max = string.format("%.2f"..sizeMSMAX,MS.max)
		end
	end
	screen.print(160,8,MS.free.."/"..MS.max,0.6)
	draw.line(156,5,156,25,color.white)
end
--Dibuja la bateria
function system.draw_batt(x,y)
	if batt.exists () then
		local porcent = batt.lifepercent()
		
		if porcent == "-" then
			draw.fillrect(x-3,y+2,3,5,color.new(255,255,255))
			draw.fillrect(x,y,20,10,color.new(255,255,255))		
			return "0"
		end
		
		local thecolor = color.new(0,255,0)
		if porcent then
		if porcent > 75 then 
			thecolor = color.new(0,255,0)
		elseif porcent > 50 then
			thecolor = color.new(100,200,0)
		elseif porcent > 25 then
			thecolor = color.new(200,100,0)
		else
			thecolor = color.new(255,0,0)
		end

		draw.fillrect(x-3,y+2,3,5,color.new(255,255,255))
		draw.fillrect(x,y,20,10,color.new(255,255,255))
		draw.fillrect(x+1,y+1,18,8,thecolor)
		
		return porcent
		else return "0"
		end
	else 
		draw.fillrect(x-3,y+2,3,5,color.new(255,255,255))
		draw.fillrect(x,y,20,10,color.new(255,255,255))
		return "0"
	end
end
function system.exit()
	system.fadeout()
	os.exit()
end
function system.credits()
	local tmpshot = system.fadeout()
	while true do
		buttons.read()
		if buttons.circle then
			system.fadeout()
			tmpshot:blit(0,0)
			break
		end
	draw.fillrect(5,5,470,262,color.new(55,90,254,100))
	stars.draw()
	draw.fillrect(100-30,80-50,280+65,100+100,color.new(55,90,254,200))
	draw.rect(100-30,80-50,280+65,100+100,color.new(255,255,255,200))
	screen.print(90,35,Creditos_txt,0.7,color.new(255,255,255))
	screen.flip()
	end
end
function system.fadeout()
	local capt = screen.toimage()
	local textura = image.new(480,272,color.new(0,0,0))
	for i = 0,255,11 do
		capt:blit(0,0,255)
		textura:blit(0,0,i)
		screen.flip()
	end	
return capt
end

tiempo = timer.new()
tiempo:start()
tiempo_show=0

function system.blink()
	if tiempo:time() >(255*4) then
		if tiempo_show == 0 then
			tiempo_show = 1
		else 
			tiempo_show =0 
		end
	
		tiempo:reset()
		tiempo:start()
	end
		
	if tiempo:time() <(255*4) and tiempo_show==0 then
		trans = (tiempo:time() / 4)
	end
		
	if tiempo:time() <(255*4) and tiempo_show==1 then
		trans = 255 - (tiempo:time() / 4) 
	end
	return trans
end
function system.reload_list()
	LineaMax = nil
	init.listahb= 1
	selit.listahb= 1
	if #Lista[Categoria_Actual].Title > 4 then 
		limit.listahb=4 
	else 
		limit.listahb=#Lista[Categoria_Actual].Title 
	end
end
-- Entramos en el dialogo de La noticia o app
function show.notice()
	trans = system.blink()
	system.draw_back()
	system.draw_bar()
	draw.fillrect(5,30,330,272-35,Black_Mate)
	draw.fillrect(340,30,480-345,70,Black_Mate)
	draw.fillrect(340,105,480-345,40,Black_Mate)
	draw.fillrect(340,150,480-345,82,Black_Mate)
	pad:resize(60,60)
	pad:blit(375,160)
	draw.fillrect(340,237,480-345,30,Black_Mate)
	draw.fillrect(340,237,480-345,30,color.new(0,72,255,trans))
	--iconoprx:blit(325-140,35)
	if not Lista[Categoria_Actual].ico[selit.listahb] then
		if files.exists("system/icons/notices/"..Lista[Categoria_Actual].HB[selit.listahb].."_ico.png") then
			Lista[Categoria_Actual].ico[selit.listahb] = image.load("system/icons/notices/"..Lista[Categoria_Actual].HB[selit.listahb].."_ico.png")
		else
		local alternative = math.random(1,3)
			Lista[Categoria_Actual].ico[selit.listahb] = image.load("system/icons/generic_prx_"..alternative..".png")
		end
	end
	Lista[Categoria_Actual].ico[selit.listahb]:blit(325-140,35)
	screen.print(15,45,txttitle)
	screen.print(15,60,Lista[Categoria_Actual].Title[selit.listahb])
	screen.print(15,80,txtversion)
	screen.print(15,95,Lista[Categoria_Actual].Ver[selit.listahb])
	screen.print(85,80,Autor)
	screen.print(85,95,Lista[Categoria_Actual].Autor[selit.listahb])
	screen.print(15,125,Lista[Categoria_Actual].Des[selit.listahb])
	screen.print(345,35,advertencia,0.6)
	Warning:blit(445,30)
	screen.print(345,110,Descargara,0.6)
	screen.print(345,125,Lista[Categoria_Actual].Size[selit.listahb])
	screen.print(360,245,"X: "..Descargar,0.6)
	if buttons.circle then
		OnNotice = 0 
	end
	if buttons.cross then
		state= system.download()
		--respaldar_Plugs()
		if state then
			if files.exists(Lista[Categoria_Actual].HB[selit.listahb]..".zip" ) then
				files.extract(Lista[Categoria_Actual].HB[selit.listahb]..".zip" ,"ms0:/PSP/GAME")
				files.delete(Lista[Categoria_Actual].HB[selit.listahb]..".zip" )
				Actualizar_MS = true
				--Rewrite_NewPlugs()
			end
		end
	end
end
--Funciones Plugins 
function respaldar_Plugs()
	if Categoria_Actual == 5 then
		configuradores = {"vsh","game","pops"}
			RutaPlugs = "ms0:/seplugins/"
		for i=1,#configuradores do 
			if files.exists(RutaPlugs..configuradores[i]..".txt") then
				--system.mensaje(3,"Existe",RutaPlugs..configuradores[i]..".txt")
				files.rename(RutaPlugs..configuradores[i]..".txt",RutaPlugs..configuradores[i].."original.txt")
			else
				--system.mensaje(1,"ERROR",RutaPlugs..configuradores[i]..".txt")
			end	
		end
	end
end


function Rewrite_NewPlugs()
	if Categoria_Actual == 5 then
		configuradores = {"vsh","game","pops"}
		RutaPlugs = "ms0:/seplugins/"
		for i=1,#configuradores do 
			if files.exists(RutaPlugs..configuradores[i]..".txt") then
				Contenidos = {}
				w_file = io.open(RutaPlugs..configuradores[i]..".txt", "r+")
				for w_line in w_file:lines() do table.insert(Contenidos, w_line) end
				w_file:close()
				w_file = io.open(RutaPlugs..configuradores[i].."original.txt", "r+")
				for w_line in w_file:lines() do table.insert(Contenidos, w_line) end
				w_file:close()
				
				w_file = io.open(RutaPlugs..configuradores[i]..".txt", "w+")
				for i=1, #Contenidos do
					w_file:write(Contenidos[i])
				end
				w_file:close()
				
				files.delete(RutaPlugs..configuradores[i].."original.txt")
			else
				--system.mensaje(1,"ERROR",RutaPlugs..configuradores[i]..".txt")
				if files.exists(RutaPlugs..configuradores[i].."original.txt") then
					files.rename(RutaPlugs..configuradores[i].."original.txt",RutaPlugs..configuradores[i]..".txt")
				end
			end	
	end
end
end

-- Controles
controls = {}
function controls.principal()
	if buttons.left then
		sel_hb = false
		sel_menu = true
	end
	if buttons.right then
		sel_hb = true
		sel_menu = false
	end
	if not sel_menu and sel_hb then
		controls.lista()
	elseif sel_menu and not sel_hb then
		controls.menu()
	end
end

function controls.menu()
if buttons.down then
	if selit.menu < #opciones_menu then		
		if selit.menu<limit.menu then selit.menu=selit.menu+1
		elseif limit.menu+1<=#opciones_menu  then
			init.menu,selit.menu,limit.menu=init.menu+1,selit.menu+1,limit.menu+1
		end
			end
		end
		
	if buttons.up  then
			if selit.menu>init.menu  then selit.menu=selit.menu-1
		elseif init.menu-1>=1 then
			init.menu,selit.menu,limit.menu=init.menu-1,selit.menu-1,limit.menu-1
		end
	end 
	if buttons.cross then
		if selit.menu == 1 then -- Categoria Juegos
			Categoria_Actual = 1
			system.reload_list()
		elseif selit.menu == 2 then-- Categoria Emuladores
			Categoria_Actual = 2
			system.reload_list()		
		elseif selit.menu == 3 then-- Categoria Aplicaciones
			Categoria_Actual = 3
			system.reload_list()
		elseif selit.menu == 4 then -- Categoria Lanzadores
			Categoria_Actual = 4
			system.reload_list()
		elseif selit.menu == 5 then -- Categoria Plugins
			Categoria_Actual = 5
			system.reload_list()
		elseif selit.menu == 6 then -- Categoria Temas
			Categoria_Actual = 6
			system.reload_list()
		elseif selit.menu == 7 then
		if CheckComment() then
		MaximoComentarios = #Comentarios
		while true do
		buttons.read()
		if buttons.up then
			actual_comentario = actual_comentario - 1
			if actual_comentario < 1 then
				actual_comentario = 1 
			end
		elseif buttons.down then
			actual_comentario = actual_comentario + 1
			if actual_comentario > #Comentarios then
			actual_comentario = #Comentarios
			end
		end
		if buttons.circle then
		actual_comentario = 1
		break
		end
		system.draw_back()
		back_comment()
		screen.flip()
		end
		end
		elseif selit.menu == 8 then
		Dialogo_Comentario()
		elseif selit.menu == 9 then
			CheckNewVersion()
		elseif selit.menu == 10 then
			system.credits()
		elseif selit.menu == 11 then
			system.exit()
		end
	end
end
function CheckNewVersion()
SobreUpDate = true
	state=wlan.getfile(Servidor.."system/updates.lua","system/updates.lua")
SobreUpDate = false
	if state then
		if files.exists("system/updates.lua") then
			dofile("system/updates.lua")
		end
	end
end
function SUMA_Comment()
no_comments = no_comments + 1
end
function CheckComment()
SobreUpDate = true
if os.getlanguage() == "SPANISH" then
estado = wlan.getfile("http://devonelua.x10.mx/home/devonelu/public_html/comentariosESP.txt","system/comentario.txt")
else
estado = wlan.getfile("http://devonelua.x10.mx/home/devonelu/public_html/comentariosENG.txt","system/comentario.txt")
end
SobreUpDate = false
if estado then 
dofile("system/comentario.txt")
end
return estado
end
actual_comentario = 1
function back_comment()

draw.fillrect(10,10,225,20, Black_Mate)
screen.print(13,13,Comentarios[actual_comentario].title)

draw.fillrect(245,10,225,20, Black_Mate)
screen.print(248,13,Comentarios[actual_comentario].fecha)

draw.fillrect(10, 40, 297, 192, Black_Mate)
screen.print(13,43,Comentarios[actual_comentario].msg)
draw.fillrect(317, 40, 480-327, 192, Black_Mate)
screen.print(350,46,SeccionComment)
ico_One:blit(320,90)
img_update:blit(320,170)
Question:blit(410,170)
draw.fillrect(10, 242, 460, 20, Black_Mate)
screen.print(13,245,"No: "..actual_comentario.." - "..MaximoComentarios)
screen.print(140,245,LastComment..Comentarios[MaximoComentarios].fecha)
end
function controls.lista()
if buttons.down or buttons.held.r then
	if selit.listahb < #Lista[Categoria_Actual].Title then		
		if selit.listahb<limit.listahb then selit.listahb=selit.listahb+1
		elseif limit.listahb+1<=#Lista[Categoria_Actual].Title then
			init.listahb,selit.listahb,limit.listahb=init.listahb+1,selit.listahb+1,limit.listahb+1
		end
			end
		end
		
	if buttons.up or buttons.held.l then
			if selit.listahb>init.listahb  then selit.listahb=selit.listahb-1
		elseif init.listahb-1>=1 then
			init.listahb,selit.listahb,limit.listahb=init.listahb-1,selit.listahb-1,limit.listahb-1
		end
	end
	
	if buttons.released.cross then
		OnNotice = 1
	end
end

function show.principal()
show.inicio()
controls.principal()
end

function system.intro()
	local SPLASHIMG = image.load("system/grafics/SplashOneInstaller.png")
	for i = 0,255,1 do
		system.draw_back()
		SPLASHIMG:blit(0,0,i)
		screen.flip()
	end	

	for i = 255,0,-1 do
		system.draw_back()
		SPLASHIMG:blit(0,0,i)
		screen.flip()
	end	
	local capt = image.load("system/grafics/psp_logo.png")
	local licen = image.load("system/grafics/cc_by-sa.png")
	--capt:center(50,50)
	local textura = image.new(480,272,color.new(0,0,0))
	for i = 0,255,3 do
		system.draw_back()
		capt:blit(50,70,i)
		licen:blit(390,230,i)
		screen.flip()
	end	
		for i = 255,0,-3 do
		system.draw_back()
		capt:blit(50,70,i)
		licen:blit(390,230,i)
		screen.flip()
	end	
return capt
end
--Funciones de Descagas
-- Variables de Descagas
Servidor = "http://archive.org/download/one-installer.-7z/one_install/"
function system.update()
state = false
	if os.getlanguage() == "SPANISH" then
		state=wlan.getfile(Servidor.."system/HomeBrewsSFspa.lua","system/HomeBrewsSF.lua")
	else
		state=wlan.getfile(Servidor.."system/HomeBrewsSFeng.lua","system/HomeBrewsSF.lua")
	end
if state then
		if files.exists("system/HomeBrewsSF.lua") then
			dofile("system/HomeBrewsSF.lua")
			system.reload_list()
			system.downicons()
		end
else 
		if files.exists("system/HomeBrewsSF.lua") then
			dofile("system/HomeBrewsSF.lua")
			system.reload_list()
			system.downicons()
		end
end
SobreUpDate = false
Actualizar_MS = true
end
function system.downicons()
	for y=1, 6 do
		for o=1, #Lista[y].Title do
			if not files.exists("system/icons/notices/"..Lista[y].HB[o].."_ico.png") and Lista[y].defico[o] == false then
				wlan.getfile(Servidor.."homebrews/"..Lista[y].HB[o].."_ico.png","system/icons/notices/"..Lista[y].HB[o].."_ico.png")
			end
		end
	end
end
function system.download()
	IAR_identifier = Lista[Categoria_Actual].IAR_identifier[selit.listahb]
	lua_value = JSON_to_lua(IAR_identifier)
	filename = get_IAR_URL(lua_value)
	return wlan.getfile(filename,Lista[Categoria_Actual].HB[selit.listahb]..".zip")
end
function system.install(file)
	if files.exists(Lista[Categoria_Actual].HB[selit.listahb]..".zip" ) then
		files.extract(Lista[Categoria_Actual].HB[selit.listahb]..".zip" ,"ms0:/PSP/GAME")
		files.delete(Lista[Categoria_Actual].HB[selit.listahb]..".zip" )
	end
end
function show.inicio()
system.draw_back()
system.draw_bar()
ico_One:blit(15,25)

draw.fillrect(5,100,165,35,Black_Mate)
draw.fillrect(5,140,165,35,Black_Mate)
draw.fillrect(5,180,165,35,Black_Mate)
draw.fillrect(5,220,165,35,Black_Mate)


draw.fillrect(190,35,280,52,Black_Mate)
draw.fillrect(190,92,280,52,Black_Mate)
draw.fillrect(190,149,280,52,Black_Mate)
draw.fillrect(190,206,280,52,Black_Mate)
y = 55
for i=init.listahb,limit.listahb do
if i==selit.listahb and sel_hb then
	trans = system.blink()
		if y == 55 then
		draw.fillrect(190,35,280,52,color.new(0,72,251,trans))
		elseif y == 115 then
		draw.fillrect(190,92,280,52,color.new(0,72,251,trans))
		elseif y == 175 then
		draw.fillrect(190,149,280,52,color.new(0,72,251,trans))
		elseif y == 235 then
		draw.fillrect(190,206,280,52,color.new(0,72,251,trans))
		end
		screen.print(200,y-15,i..". "..Lista[Categoria_Actual].Title[i] or "",0.7,color.white)
		screen.print(200,y+5,(string.sub(Lista[Categoria_Actual].Des[i] or "",1,35) or ""),0.7,color.white)
else
screen.print(200,y-15,i..". "..Lista[Categoria_Actual].Title[i] or "",0.7,color.white)
screen.print(200,y+5,(string.sub(Lista[Categoria_Actual].Des[i] or "",1,35) or ""),0.7,color.white)
end 
y = y + 60
end
if not LineaMax then
LineaMax = #Lista[Categoria_Actual].Title
end
	if LineaMax> 4 then
		local pos_height = math.max(223/LineaMax, 5)
		draw.fillrect(475, 36, 5, 222, Black_Mate)
		draw.fillrect(475, 36+((223-pos_height)/(LineaMax-1))*(selit.listahb-1), 5, pos_height, color.new(255,255,255))
	end
--else
y =115
for i=init.menu,limit.menu do
if i==selit.menu and sel_menu then
	trans = system.blink()
		if y == 115 then
		draw.fillrect(5,100,165,35,color.new(0,72,251,trans))
		elseif y == 155 then
		draw.fillrect(5,140,165,35,color.new(0,72,251,trans))
		elseif y == 195 then
		draw.fillrect(5,180,165,35,color.new(0,72,251,trans))
		elseif y == 235 then
		draw.fillrect(5,220,165,35,color.new(0,72,251,trans))
		end
		screen.print(65,y-5,opciones_menu[i] or "",0.7,color.white)
else
screen.print(65,y-5,opciones_menu[i] or "",0.7,color.white)
end 
y = y + 40
end
if not LineaMax1 then
LineaMax1 = #opciones_menu
end
	if LineaMax1> 4 then
		local pos_height = math.max(155/LineaMax1, 5)
		draw.fillrect(175, 100, 5, 155, Black_Mate)
		draw.fillrect(175, 100+((155-pos_height)/(LineaMax1-1))*(selit.menu-1), 5, pos_height, color.new(255,255,255))
	end
end
--Mostrar Mensajes.
function system.mensaje(modo,msn_titulo,msn_texto) --- muestra un mensaje en pantalla
	if modo == 3 then
	--Retorna true/false segun la eleccion
	msn_icono = Question
	elseif modo == 1 then 
	msn_icono = Warning
	elseif modo == 2 then
	msn_icono = img_update
	end
	if mensaje == nil then dofile("system/mensajes.lua") end
	return mensaje.print(modo,msn_titulo,msn_icono,msn_texto,nil)
	--mensaje.free(true) Libera todo lo relacionado con mensajes
end

-- get zip url from parsed json metadata from internet archive
function get_IAR_URL(json_lua_value)
	local IAR_download_prefix = "http://archive.org/download/"
	local IAR_identifier = json_lua_value["metadata"]["identifier"]
	item_files = json_lua_value["files"]

	for k, file_metadata in pairs(item_files) do
		file_name = file_metadata["name"]
		if file_name:find ".zip" then
			if not file_name:find "Versions" then
				print(file_name)
				return(IAR_download_prefix..IAR_identifier.."/"..file_name)
			end
		end
	end
end


-- json parser for IAR metadata
function JSON_to_lua(IAR_identifier)
	JSON = (loadfile "system/json-lua/JSON.lua")() -- one-time load of the routines
	
	IAR_metadata_prefix = "http://archive.org/metadata/"
	
	state = wlan.getfile(IAR_metadata_prefix..IAR_identifier,"IAR_metadata.txt")
	
	local f = assert(io.open("IAR_metadata.txt", "rb"))
    local raw_json_text = f:read("*all")
    f:close()

	local lua_value = JSON:decode(raw_json_text) -- decode example
	return lua_value
end