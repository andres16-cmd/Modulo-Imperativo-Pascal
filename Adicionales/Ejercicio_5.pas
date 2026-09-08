
Program Ejercicio_6;
const
	fin = 0;
	dimF = 12;
type
	
	envio = record
		cod_cliente: integer;
		dia: integer;
		mes: integer;
		cod_postal: integer;
		peso_paquete: integer;
	end;
	
	vector_meses = array[1..dimF] of integer;
	
	datos_envio = record
		codigo_postal: integer;
		cant_paquetes: vector_meses;
	end;
	
	arbol = ^nodoArbol;
	
	nodoArbol = record
		dato: datos_envio;
		HI: arbol;
		HD: arbol;
	end;
	
	
	{Estructura Inciso(c)}
	Lista = ^nodoLista;
	
	nodoLista = record
		dato: integer;
		sig: Lista;
	end;
	
	
	Procedure Leer_Datos(var e: envio);
	begin
		
		write('Ingrese el codigo de cliente: ');
		read(e.cod_cliente);
		
		if (e.cod_cliente <> fin) then
		begin
			write('Ingrese el Dia: ');
			read(e.dia);
			write('Ingrese el Mes: ');
			read(e.mes);
			write('Ingrese el Codigo Postal: ');
			read(e.cod_postal);
			write('Ingrese el Peso del Paquete: ');
			read(e.peso_paquete);
		end;
	end;
	
	Procedure Ini_Vector(var v: vector_meses);
	var
		i: integer;
	begin
		
		for i:= 1 to dimF do
		begin
			v[i]:= 0;
		end;
	end;
	
	Procedure Agregar_Arbol(var a: arbol; e: envio);
	begin
		
		if (a = nil) then
		begin
			new(a);
			a^.dato.codigo_postal:= e.cod_postal;
			Ini_Vector(a^.dato.cant_paquetes);
			a^.dato.cant_paquetes[e.mes]:= a^.dato.cant_paquetes[e.mes] + 1;
			a^.HI:= nil;
			a^.HD:= nil;
		end
		else
		begin
		
			if (a^.dato.codigo_postal = e.cod_postal) then
			begin
				a^.dato.cant_paquetes[e.mes]:= a^.dato.cant_paquetes[e.mes] + 1;
			end
			else
			begin
				
				if (e.cod_postal < a^.dato.codigo_postal) then
				begin
					Agregar_Arbol(a^.HI,e);
				end
				else
				begin
					Agregar_Arbol(a^.HD,e);
				end;
			end;
		end;
	end;
	
	
	Procedure Cargar_Arbol(var a: arbol);
	var
		e: envio;
	begin
		
		Leer_Datos(e);
		
		while (e.cod_cliente <> fin) do
		begin
			Agregar_Arbol(a,e);
			Leer_Datos(e);
		end;
	end;
	
	{b) Implementar un módulo que reciba la estructura 
	generada en el inciso a), un código postal y un valor
	entero. El módulo debe retornar la cantidad de meses 
	cuya cantidad supere al valor entero recibido para el
	código postal recibido.}
	
	
	Function Cumple(v: vector_meses; x: integer): integer;
	var
		aux,i: integer;
	begin
		aux:= 0;
	
		for i:= 1 to dimF do
		begin
			
			if (v[i] > x) then
			begin
				aux:= aux + 1;
			end;
		end;
		
		Cumple:= aux;
	end;
	
	Function Cantidad_Meses(a: arbol; cod,valor: integer): integer;
	begin
		
		if (a = nil) then
		begin
			Cantidad_Meses:= 0;
		end
		else
		begin
			
			if (a^.dato.codigo_postal = cod)  then
			begin
				Cantidad_Meses:= Cumple(a^.dato.cant_paquetes,valor); 
			end
			else
			begin
				
				if (cod < a^.dato.codigo_postal) then
				begin
					Cantidad_Meses:= Cantidad_Meses(a^.HI,cod,valor);
				end
				else
				begin
					Cantidad_Meses:= Cantidad_Meses(a^.HD,cod,valor);
				end;
			end;
		end;
	end;
	
	
	{c) Implementar un módulo que reciba la estructura 
	generada en el inciso a), dos códigos postales y 
	retorne los códigos postales dentro de los dos 
	códigos recibidos (incluirlos),que tuvieron al menos 
	un mes sin envíos.}
	
	Procedure Agregar_Adelante(var L: Lista; x: integer);
	var
		aux: Lista;
	begin
		new(aux);
		aux^.dato:= x;
		aux^.sig:= L;
		L:= aux;
	end;
	
	Function Cumple2(v: vector_meses): boolean;
	var
		i: integer;
		ok: boolean;
	begin
		ok:= false;
		i:= 1;
		
		while (ok = false) and (i <= dimF) do
		begin
		
			if (v[i] = 0) then
			begin
				ok:= true;
			end
			else
			begin
				i:= i+1;			
			end;
		end;
		
		Cumple2:= ok;
	end;
	
	
	Procedure Dos_Codigos(a: arbol; cod1,cod2: integer; var L: Lista);
	begin
		
		if (a = nil) then
		begin
			writeln('El Arbol esta vacio.');
		end
		else
		begin
			
			if ((cod1 <= a^.dato.codigo_postal) and (cod2 <= a^.dato.codigo_postal)) then
			begin
				
				if (Cumple2(a^.dato.cant_paquetes)) then
				begin
					Agregar_Adelante(L,a^.dato.codigo_postal);
				end;
			end
			else
			begin
				
				if (cod1 < a^.dato.codigo_postal) then
				begin
					Dos_Codigos(a^.HI,cod1,cod2,L);
				end
				else
				begin
					Dos_Codigos(a^.HD,cod1,cod2,L);
				end;
			end;
		end;
	end;
	
	
	Procedure Print_Lista(L: Lista);
	begin
		
		writeln('Codigos que Cumplen');
		
		while (L <> nil) do
		begin
			writeln('Codigo -> [',L^.dato,']');
			L:= L^.sig;
		end;
	end;
	
	
	
var
	a: arbol;
	z,y: integer;
	L: Lista;
	c1,c2: integer;
begin
	a:= nil;
	L:= nil;
	
	{Inciso (a)}
	Cargar_Arbol(a);
	
	{Inciso (b)}
	
	write('Ingrese el Codigo Postal: ');
	read(z);
	write('Ingrese el Valor Entero: ');
	read(y);
	
	writeln('La Cantida de Meses que Superaron el Valor Recibido Fueron -> [',Cantidad_Meses(a,z,y),'] ');
	
	
	{Inciso (c)}
	
	write('Ingrese el Codigo 1: ');
	read(c1);
	write('Ingrese el Codigo 2: ');
	read(c2);
	
	Dos_Codigos(a,c1,c2,L);
	
	{Impresion de los Codigos que Cumplen el Inciso (c)}
	Print_Lista(L);
	
end.
