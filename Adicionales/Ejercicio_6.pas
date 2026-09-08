Program Ejercicio_7;
const
	fin = 0;
	dimF = 31;
type
	
	datos_pasaje = record
		cod_vuelo: integer;
		dia: integer;
		DNI: integer;
		monto: real;
	end;
	
	pasaje = record
		codigo_ciudad: integer;
		datos: datos_pasaje;
	end;
	
	Lista = ^nodoLista;
	
	nodoLista = record
		dato: datos_pasaje;
		sig: Lista;
	end;
	
	informacion_pasajeros = record
		codigo_ciudad_destino: integer;
		L: Lista;
	end;
	
	arbol = ^nodoArbol;
	
	nodoArbol = record
		dato: informacion_pasajeros;
		HI: arbol;
		HD: arbol;
	end;
	
	
	{Estructura Inciso (c)}
	
	vector_montos = array[1..dimF] of real;
	
	
	
	Procedure Leer_Datos(var p: pasaje);
	begin
		
		write('Ingrese el DNI: ');
		read(p.datos.DNI);
		
		if (p.datos.DNI <> fin) then
		begin
			write('Ingrese el Codigo de Vuelo: ');
			read(p.datos.cod_vuelo);
			write('Ingrese el Dia del Mes de (Enero): ');
			read(p.datos.dia);
			write('Ingrese el Codigo de Ciudad de Destino: ');
			read(p.codigo_ciudad);
			write('Ingrese el Monto del Pasaje: ');
			read(p.datos.monto);
		end;
	end;
	
	Procedure Agregar_Adelante(var L : Lista; d:datos_pasaje);
	var
		aux: Lista;
	begin
		new(aux);
		aux^.dato:= d;
		aux^.sig:= L;
		L:= aux;
	end;
	
	
	Procedure Agregar_Arbol(var a: arbol; p: pasaje);
	begin
		
		if (a = nil) then
		begin
			new(a);
			a^.dato.codigo_ciudad_destino:= p.codigo_ciudad;
			a^.dato.L:= nil;
			Agregar_Adelante(a^.dato.L,p.datos);
			a^.HI:= nil;
			a^.HD:= nil;
		end
		else
		begin
		
			if (p.codigo_ciudad = a^.dato.codigo_ciudad_destino) then
			begin
				Agregar_Adelante(a^.dato.L,p.datos);
			end
			else
			begin
				
				if (p.codigo_ciudad < a^.dato.codigo_ciudad_destino) then
				begin
					Agregar_Arbol(a^.HI,p);
				end
				else
				begin
					Agregar_Arbol(a^.HD,p);
				end;
			end;
		end;
	end;
	
	
	Procedure Cargar_Arbol(var a: arbol);
	var
		p: pasaje;
	begin
	
		Leer_Datos(p);
		
		while (p.datos.DNI <> fin) do
		begin
			Agregar_Arbol(a,p);
			Leer_Datos(p);
		end;
	end;
	
	
	{b) Implementar un módulo que reciba la estructura 
	generada en el inciso a), dos códigos de destino y un
	DNI. El módulo debe retornar la cantidad de vuelos que
	realizó el pasajero con el DNI recibido cuyo código de
	destino está entre los dos códigos de destino 
	recibidos (no incluirlos).}
	
	Function Cont(L: Lista; valor: integer): integer;
	begin
		
		if (L = nil) then
		begin
			Cont:= 0;
		end
		else
		begin
			
			if (L^.dato.DNI = valor) then
			begin
				Cont:= Cont(L^.sig,valor) + 1;
			end
			else
			begin
				Cont:= Cont(L^.sig,valor);
			end;
		end;
	end;
	
	
	Function Cantidad_Vuelos(a: arbol; cod1,cod2,dni: integer): integer;
	begin
		
		if (a = nil) then
		begin
			Cantidad_Vuelos:= 0;
		end
		else
		begin
			
			if ((cod1 < a^.dato.codigo_ciudad_destino) and (cod2 > a^.dato.codigo_ciudad_destino)) then
			begin
			
				Cantidad_Vuelos:= Cantidad_Vuelos(a^.HI,cod1,cod2,dni) + Cantidad_Vuelos(a^.HD,cod1,cod2,dni) + Cont(a^.dato.L,dni); 
			end
			else
			begin
				
				if (cod1 < a^.dato.codigo_ciudad_destino) then
				begin
					Cantidad_Vuelos:= Cantidad_Vuelos(a^.HI,cod1,cod2,dni);
				end
				else
				begin
					Cantidad_Vuelos:= Cantidad_Vuelos(a^.HD,cod1,cod2,dni);
				end;
			end;
		end;
	end;
	
	
	{c) Implementar un módulo que reciba la estructura 
	generada en el inciso a) y retornar el monto total 
	acumulado en cada día del mes.}
	
	Procedure Ini_Vector(var v: vector_montos);
	var
		i: integer;
	begin
		for i:= 1 to dimF do
		begin
			v[i]:= 0;
		end;
	end;
	
	Procedure Cargar_Vector(L: Lista; var v: vector_montos);
	begin
		
		while (L <> nil) do
		begin
			v[L^.dato.dia]:= v[L^.dato.dia] + L^.dato.monto;
			L:= L^.sig;
		end;
	end;
	
	
	Procedure Montos(a: arbol; var v: vector_montos);
	begin
		
		if (a <> nil) then
			
			Cargar_Vector(a^.dato.L,v);
			Montos(a^.HI,v);
			Montos(a^.HD,v);
		end;
	end;
	
	
var
	a: arbol;
	c1,c2,numero: integer;
	v: vector_montos;
begin
	a:= nil;
	
	{Inciso (a)}
	Cargar_Arbol(a);
	
	
	{Inciso (b)}
	
	write('Ingrese el Codigo 1: ');
	read(c1);
	write('Ingrese el Codigo 2: ');
	read(c2);
	write('Ingrese el DNI: ');
	read(numero);
	
	writeln('La Cantidad de Vuelos del Pasajero con DNI [',numero,'] fueron -> [',Cantidad_Vuelos(a,c1,c2,numero),']. ');
	
	
	{Inciso (c)}
	Ini_Vector(v);
	
	Montos(a,v);
	
end.
