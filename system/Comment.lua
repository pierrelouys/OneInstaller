Blink = {}
cursor = timer.new()
cursor:start()

function Blink.Cursor(x,y)
if cursor:time() < 500 then
draw.line(x,y,x,y+15,color.white)
elseif cursor:time() > 1000 then
cursor:reset()
cursor:start()
end
end

function Dibujar_Comentario()
system.draw_back()
--
draw.fillrect(10, 10, 220, 20, Black_Mate)
screen.print(13,13,os.getnick ())
--
draw.fillrect(240, 10, 230, 20, Black_Mate)
screen.print(243,13,os.getdate ())
--
draw.fillrect(10, 40, 297, 192, Black_Mate)
Mini_Editor()
--
draw.fillrect(10, 242, 460, 20, Black_Mate)
screen.print(310,245,"Start:On/Off KBD")
screen.print(30,245,"SELECT: Enter")
--

end
function checkLen()
	if string.len(text[selector]) > 21 then
		if selector < 12 then
			selector = selector + 1
			--table.insert(text, selector, "")
		else
			text[selector] = string.sub(text[selector],1,21)
		end
	end
end
function InsertNL()
	if selector < 12 then
		selector = selector + 1
		--table.insert(text, selector, "")
	end
end
function Mini_Editor()
	ON_KBD()
	checkLen()
	y = 50
	for i=1,#text do
		screen.print(20,y,text[i])
		y = y + 15
	end
	Cordenada_Cursor_X = screen.textwidth(text[selector])
	y = 35
	Blink.Cursor(Cordenada_Cursor_X+20,y+15*selector)
end

function ON_KBD()
if OnKbd then
text[selector] = kbd.init(text[selector])
else
draw.fillrect(320, 70, 150, 130, Black_Mate)
screen.print(323,73,"X: Send\nO: Cancel\nStart: On/Off KBD\nUp: Up Line\nDown: Down Line")
end
end

function ExtraCTRL()
if buttons.cross then
return 1
elseif buttons.circle then
return 0
elseif buttons.up then
return 4
elseif buttons.down then
return 3
end
end

function Dialogo_Comentario()
selector = 1
text = {"","","","","","","","","","","",""}
OnKbd= false
main_comment()
end

function main_comment()
	
	while true do
		buttons.read()
		
		if buttons.select then
			InsertNL()
		end
		
		if buttons.start then
			OnKbd = not OnKbd
		end
		
		if not OnKbd then
			val=ExtraCTRL() 
			if val == 0 then
				break
			elseif val == 4 then
			if selector > 1 then
			selector = selector -1
			end
			elseif val == 3 then
			if selector < 12 then
			selector = selector + 1
			end
			elseif val == 1 then
				POSTMSG = ""
				for i=1,#text do
					if string.len(text[i]) > 0 then
						POSTMSG = POSTMSG..text[i]
						if string.len(text[i]) > 20 then
							POSTMSG = POSTMSG.."\n"
						end
					else
						i = i + 1
					end
				end
				
				if string.len(POSTMSG) > 0 then
					COMILLAS =[["]]
					POSTSEND = "username=Comentarios[no_comments] ={title="..COMILLAS..os.getnick ()..COMILLAS..",msg="..COMILLAS..POSTMSG..COMILLAS..",fecha="..COMILLAS..os.getdate ()..COMILLAS.."}\n"
					if os.getlanguage() == "SPANISH" then
						post("devonelua.x10.mx/postform.php",POSTSEND)
					else
						post("devonelua.x10.mx/postformESP.php",POSTSEND)
					end
					break
				else
					system.mensaje(1,ErrorComent,"Msg: "..ErrorComentNil)
				end
			end
		end
Dibujar_Comentario()
screen.flip()
end
text = nil
POSTMSG = nil
POSTSEND = nil
collectgarbage()
system.draw_back()
end