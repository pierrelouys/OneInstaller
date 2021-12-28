--[[
	OneInstaller 
	
	Descripcion:
	Instalador y Gestor de Contenido App/Game/Plug/Theme/Launch
	
	Version 0.1 Creado: Jueves 27/11/2014 05:24:00 PM
	Inicios de Pruebas de Concepto.
	Version 0.2 Creado: viernes 28/11/2014 12:04:00 PM
	Se añade soporte de actualizacion. 
	Version 0.3 Creado: lunes 1/12/2014 1:02:00 PM
	Se mejora la estrutura del code.
	Version 0.4 Creado: miercoles 3/12/2014 4:12:00 PM
	Se inicia la estrutura Grafica.
	Version 0.5 Creado: viernes 5/12/2014 12:00:00 PM
	Se añade la lib stars y mejoras graficas.
	Version 0.6 Creado: sabado 6/12/2014 12:00:00 AM
	Se añade la funcion blink y la barra superior.
	Version 0.7 Creado: sabado 8/12/2014 10:00:00 AM
	Se añade porcentaje de bateria y señal en la barra superior.
	Version 0.8 Creado: lunes 15/12/2014 9:00:00 PM
	Añadidos los callbacks *Aun pendientes..
	Version 0.8.1 Creado: miercoles 17/12/2014 9:15:00 AM
	Añadidas las separaciones entre la lista, HB/GAME/PLUG/LAUNCH/ETC
	Version 0.8.9 Creado: viernes 19/12/2014 8:16:00 PM
	Mejorada la estrutura de lista, y Mejorados los callbacks ^Aun Betas :( 
	Version 0.9.0 Creado: Sabado 20/12/2014 1:10:00 PM
	Añadido El soporte de envio de comentarios ^Pendiente la lectura de ellos.
	Version 0.9.8 Creado: Domingo 21/12/2014 11:09:00 PM
	Añadido El soporte de lectura de comentarios ^Pendiente perfeccionar XD
	Version 1.0.0 Creado: Martes 23/12/2014 6:59:00 PM
	Se llega a la version estable :)
	Ahora, Tiene sus secciones de contenido,
	Descarga e instala de manera ideal,
	Visor y publicador de comentarios,
	Se auto actualiza,
	Se añadieron soporte a 2 idiomas
	Se descargan de manera automatica los iconos en las noticias
	Muestra info MS, de manera optima,
	Version 1.1.0 Creado: Jueves 25/12/2014 8:59:00 PM
	Se Reescribe totalmente el enviador de comentarios, y se separa segun el lenguaje.
	Version 1.2.0 Creado: Sabado 27/12/2014 10:59:00 PM
	Añadido Funciones de mensajes, y reescritos los callbacks :) A prueba de errores.
	Version 1.3.0 Creado: Lunes 29/12/2014 8:36:00 PM
	Añadidos Mensajes De Actualizacion Disponible, Corregidos Algunos Bugs
	Mejorada la velocidad al actualizar los comentarios.
	Version 1.4.0 Creado: Martes 30/12/2014 10:03:00 PM
	Se mejoran y reparan varios Bugs, (DownIcons,Updates,Comentarios)
	Pendiente:
	Se Arregla Bug que borraba las configuraciones de plugins anteriores al instalar.
	Creada y diseñada por: 
	El Coder:
	David Nuñez A. David.nunezaguilera.131@gmail.com
--]]
--=============================================
os.setcpu(333) -- Set CPU a maximo temporalmente.
color.loadpalette() --Cargamos la paleta de colores.
Black_Mate = color.new(0,0,0,100) -- Tema De superficie
dofile("system/callback.lua")-- Cargamos Las Funciones
dofile("system/functions.lua")-- Cargamos Las Funciones
system.load()--Cargamos Recursos Graficos
system.detect_language()--Cargamos Textos Segun Lenguaje
VersionActual = 140
--Arranca de manera Oficial APP
system.intro()
system.draw_back()
wlan.connect() 
system.update()  -- Lista de APPS
os.setcpu(222)
OnNotice=0
ShowMsgUpdate = false

-- Principal Programa
while true do
buttons.read() -- Leemos los botones

	if OnNotice == 0 then
		show.principal()
	elseif OnNotice == 1  then
		show.notice()
	end
	screen.flip()
	-- Muestra El Mensaje si hay actualizacion 1 vez
	if ShowMsgUpdate == false then
	ShowMsgUpdate = true
		if VersionActual < VersionUltima then
			val = system.mensaje(2,UpdateTitle,UpdateMsgo..VersionActual..UpdateMsgt..VersionUltima)
		end
	end
end