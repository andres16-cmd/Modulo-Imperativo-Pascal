Program Ejercicio_2;
const
	fin = 0;
type
	
	rango_mes = 1..12;
	
	datos_compra = record
		cod_cliente: integer;
		mes: rango_mes;
	end;
	
	compra = record
		cod_videojuego: integer;
		datos: datos_compra;
	end;
	
	{Creamos la Lista Correpondiente}
	
	Lista = ^nodoLista;
	
	nodoLista = record
		dato: datos_compra;
		sig: Lista;
	end;
	
	videojuego = record
		codigo_videojuego: integer;
		L: Lista;
	end;
	
	{Creamos el Arbol Correspondiente}
	
	arbol = ^nodoArbol;
	
	nodoArbol = record
		dato: videojuego;
		HI: arbol;
		HD: arbol;
	end;
	
	
	Function AleatorioEntre(num1,num2: integer): integer;
	begin
		AleatorioEntre:= random(num2-num1+1)+num1;
	end;	
	
	Procedure Leer_Compra(var c: compra);
	begin
		
		c.datos.cod_cliente:= AleatorioEntre(0,200);
		
		if (c.datos.cod_cliente <> fin) then
		begin
			c.cod_videojuego:= AleatorioEntre(1,250);
			c.datos.mes:= AleatorioEntre(1,12);
		end;
	end;
	
	
	Procedure Agregar_Adelante(var L:Lista; d: datos_compra);
	var
		aux: Lista;
	begin
		new(aux);
		aux^.dato:= d;
		aux^.sig:= L;
		L:= aux;
	end;
	
	Procedure Agregar_Arbol(var a: arbol; c: compra);
	begin
		
		if (a = nil) then
		begin
			new(a);
			a^.dato.codigo_videojuego:= c.cod_videojuego;
			a^.dato.L:= nil;
			Agregar_Adelante(a^.dato.L,c.datos);
			a^.HI:= nil;
			a^.HD:= nil;
		end
		else
		begin
		
			if (a^.dato.codigo_videojuego = c.cod_videojuego) then
			begin
				Agregar_Adelante(a^.dato.L,c.datos);
			end
			else
			begin
			
				if (c.cod_videojuego < a^.dato.codigo_videojuego) then
				begin
					Agregar_Arbol(a^.HI,c);
				end
				else
				begin
					Agregar_Arbol(a^.HD,c);
				end;
			end;
		end;
	end;
	
	Procedure Cargar_Arbol( var a: arbol);
	var
		c: compra;
	begin
		
		Leer_Compra(c);
		
		while (c.datos.cod_cliente <> fin) do
		begin
			Agregar_Arbol(a,c);
			Leer_Compra(c);
		end;
	end;
	
	{b) Implementar un módulo que reciba el árbol generado en el 
	inciso a) y un código de videojuego. Este módulo debe retornar 
	la lista de las compras de ese videojuego.}
	
	Procedure Buscar_Lista(a: arbol; codigo: integer; var L: Lista);
	begin
		
		if (a = nil) then
		begin
			writeln('No se encontro el Video Juego.');
		end
		else
		begin
			
			if (a^.dato.codigo_videojuego = codigo) then
			begin
				L:= a^.dato.L;
			end
			else
			begin
				
				if (codigo < a^.dato.codigo_videojuego) then
				begin
					Buscar_Lista(a^.HI,codigo,L);
				end
				else
				begin
					Buscar_Lista(a^.HD,codigo,L);
				end;
			end;
		end;
	end;
	
   {c) Implementar un módulo recursivo que reciba la lista generada
   en el inciso b) y un mes. El módulo debe retornar la cantidad 
   de clientes que compraron en el mes ingresado.}
	
	Function Cantidad_Clientes(L:Lista; mes_buscar: integer): integer;
	begin
		
		if (L = nil) then
		begin
			Cantidad_Clientes:= 0;
		end
		else
		begin
			
			if (L^.dato.mes = mes_buscar) then
			begin
				Cantidad_Clientes:= Cantidad_Clientes(L^.sig,mes_buscar) + 1; 
			end
			else
			begin
				Cantidad_Clientes:= Cantidad_Clientes(L^.sig,mes_buscar);
			end;
		end;
	end;
	
var
	a: arbol;
	cod: integer;
	aux: Lista;
	mes_buscar: integer;
begin
	a:= nil;
	aux:= nil;
	
	Randomize;
	
	{Inciso (a)}
	Cargar_Arbol(a);
	
	
	{Inciso (b)}
	write('Ingrese el codigo a Busacar: ');
	read(cod);
	
	Buscar_Lista(a,cod,aux);
	
	{Inciso (c)}
	
	write('Ingrese el Mes: ');
	read(mes_buscar);
	
	writeln('En el Mes [',mes_buscar,'] la Clientes que Compraro fue/ron [',Cantidad_Clientes(aux, mes_buscar),'] ');
	
	
end.
