--[[
	Libreria para la facil adicion del teclado Danzeff
	Autor: David Nuñez
	Fecha: 09/11/14
	Interprete: ONELUA
	Funciones:
]]
--[[
Recursos para el teclado Danzeff
]]
 kb_bg = image.load("system/lib_kbd/graficos/osk_bg.png")
 kb_overlay = image.load("system/lib_kbd/graficos/osk_main.png")
 kb_overlayB = image.load("system/lib_kbd/graficos/osk_num.png")
 kb_overlayA = image.load("system/lib_kbd/graficos/osk_A.png")
 kb_highlight = image.load("system/lib_kbd/graficos/highlight.png")
 
 kbd = {}
 function kbd.theme(Theme)
 if Theme then
	kb_bg = image.load("system/lib_kbd/graficos/"..Theme.."/osk_bg.png")
 kb_overlay = image.load("system/lib_kbd/graficos/"..Theme.."/osk_main.png")
 kb_overlayB = image.load("system/lib_kbd/graficos/"..Theme.."/osk_num.png")
 kb_overlayA = image.load("system/lib_kbd/graficos/"..Theme.."/osk_A.png")
 kb_highlight = image.load("system/lib_kbd/graficos/"..Theme.."/highlight.png")
 end
end
  select = { }
 scrollnum = 1
 count_up = 0
 count_down = 0
 count_right = 0
 count_left = 0
 mode = 0
 nem = 0
 --texto = ""

 kbd.x = 0
 kbd.y = 0

--[[ 
Fin De Recursos De Teclado 
]]
--[[
Funciones para el teclado Danzeff
]]
function kbd.set(X,Y)
 kbd.x = X
 kbd.y = Y
end
function kbd.main()
characters={}
characters[1] = {"a", "b", "c", "," }
characters[2] = {"d", "e", "f", "." }
characters[3] = {"g", "h", "i", "!" }
characters[4] = {"j", "k", "l", "-" }
characters[5] = {"m", " ", "n", del}
characters[6] = {"o", "p", "q", "?" }
characters[7] = {"r", "s", "t", "(" }
characters[8] = {"u", "v", "w", ":" }
characters[9] = {"x", "y", "z", ")" }

characters1={}
characters1[1] = {"A", "B", "C", "," }
characters1[2] = {"D", "E", "F", "." }
characters1[3] = {"G", "H", "I", "!" }
characters1[4] = {"J", "K", "L", "-" }
characters1[5] = {"M", " ", "N", del}
characters1[6] = {"O", "P", "Q", "?" }
characters1[7] = {"R", "S", "T", "(" }
characters1[8] = {"U", "V", "W", ":" }
characters1[9] = {"X", "Y", "Z", ")" }

characters2={}
characters2[1] = {"<", " ", "1", "[" }
characters2[2] = {">", " ", "2", "=" }
characters2[3] = {"*", " ", "3", "]" }
characters2[4] = {"_", " ", "4", " " }
characters2[5] = {"+", " ", "5", del }
characters2[6] = {"-", " ", "6", " " }
characters2[7] = {"'", "", "7", "{"  }
characters2[8] = {"\"", "", "8", "\\"}
characters2[9] = {"/", "0", "9", "}"  }

charsel = characters
cursory =  0
cursorx = 0
end

function kbd.controls()
if dx then
    select.x = 3
    if dy1 then
    hx=99
    hy=99
    elseif dy then
    hx=99
    hy=1
    else
    hx=99
    hy=50
    end
    elseif dx1 then
    select.x = 1
    if dy1 then
    hx=1
    hy=99
    elseif dy then
    hx=1
    hy=1
    else
    hx=1
    hy=50
    end
    else
    select.x = 2
    if dy1 then
    hx=50
    hy=99
    elseif dy then
    hx=50
    hy=1
    else
    hx=50
    hy=50
     end
    end
    if dy1 then
    select.y = 3
    elseif dy then
    select.y = 1
    else
    select.y = 2
    end 
	if mode == 0 then
	mx = 309
	my = 191
	end
	if mode == 1 then
	mx = 359
	my = 191
	end
	if mode == 2 then
	mx = 409
	my = 191
	end

	  if mode == 0 then --smal letters
	  charsel = characters
	  elseif mode == 1 then --capital letters
	  charsel = characters1
	  elseif mode == 2 then --num and specialsymbols
	  charsel = characters2
	  end
	
	  if select.y == 1 and select.x == 1 then
	  cursory = 1
	  elseif select.y == 1 and select.x == 2 then
	  cursory = 2
	  elseif select.y == 1 and select.x == 3 then
	  cursory = 3
	  elseif select.y == 2 and select.x == 1 then
	  cursory = 4
	  elseif select.y == 2 and select.x == 2 then
	  cursory = 5
	  elseif select.y == 2 and select.x == 3 then
	  cursory = 6
	  elseif select.y == 3 and select.x == 1 then
	  cursory = 7
	  elseif select.y == 3 and select.x == 2 then
	  cursory = 8
	  elseif select.y == 3 and select.x == 3 then
	  cursory = 9
	  end
	  
	  if buttons.r then mode = mode + 1 end
	  if buttons.l then mode = mode - 1 end
	 -- if buttons.select then mode = mode + 1 end
	  
	  if mode < 0 then mode = 2 end
	  if mode > 2 then mode = 0 end
end
 

   
 function kbd.init(texto)
kbd.main()
--texto="" --para concatenar cada ch
--buttons.read()
dx = (buttons.held.right)
dy = (buttons.held.up)  
dy1 = (buttons.held.down)
dx1 = (buttons.held.left)
--kb_funcbg:blit(120,50) 
	
kbd.controls()
	
      if buttons.square then
	  cursorx = 1
	  texto = texto..charsel[cursory][cursorx]
	  elseif buttons.cross then
	  cursorx = 2
      texto = texto..charsel[cursory][cursorx]
	  elseif buttons.circle then
	  cursorx = 3
	  texto = texto..charsel[cursory][cursorx]
	  elseif buttons.triangle then
	  cursorx = 4 
	   if charsel[cursory][cursorx]==del then
	   length = string.len(texto)
	   texto=string.sub(texto, 1,length-1) 
	   --elseif charsel[cursory][cursorx]~=del then
	   
	   elseif charsel[cursory][cursorx]~=del then
	   texto = texto..charsel[cursory][cursorx]
	   end
	  end

kb_bg:blit(kbd.x , kbd.y)
kb_highlight:blit(hx+kbd.x, hy+kbd.y)
if (mode == 0) then
kb_overlay:blit(kbd.x+2, kbd.y+2)
end
if (mode == 1)then
kb_overlayA:blit(kbd.x+2, kbd.y+2)
end
if (mode == 2) then
 kb_overlayB:blit(kbd.x+2, kbd.y+2)
end
if texto == "" then
return texto
else
return texto 
--InsertNewChar(texto)
end
--screen.waitvblankstart()
end
--[[ 
Fin De Funciones De Teclado 
]]