Program Ejercicio_5;
const
	fin = 0;
type
	
	
	artesania = record
		cod_artesania: integer;
		DNI: integer;
		nombre_base: string;
	end;
	
	datos_artesano = record
		DNI_artesano: integer;
		cant_artesanias: integer;
	end;
	
	{Estructura inciso (a(i))}
	arbol = ^nodoArbol;
	
	nodoArbol = record	
		dato: datos_artesano;
		HI: arbol;
		HD: arbol;
	end;
	
	{Estructura inciso (a(ii))}
	
	datos_lista = record
		material_base: string;
		cant_total: integer;
	end;
	
	Lista = ^nodoLista;
	
	nodoLista = record
		dato: datos_lista;
		sig: Lista;
	end;
	
	
	
	
	Procedure Leer_Datos(var art: artesania);
	begin
	
		write('Ingrese el DNI: ');
		read(art.DNI);
		
		if (art.DNI <> fin) then
		begin
			write('Ingrese el Codigo de la Artesania: ');
			read(art.cod_artesania);
			write('Ingrese el Nombre del Material base: ');
			read(art.nombre_base);
		end;
	end;
	
	
	Procedure Agregar_Arbol(var a: arbol; art: artesania);
	begin
	
		if (a = nil) then
		begin
			new(a);
			a^.dato.DNI_artesano:= art.DNI;
			a^.dato.cant_artesanias:= 1;
			a^.HI:= nil;
			a^.HD:= nil;
		end
		else
		begin
		
			if (art.DNI = a^.dato.DNI_artesano) then
			begin
				a^.dato.cant_artesanias:= a^.dato.cant_artesanias + 1;
			end
			else
			begin
			
				if (art.DNI < a^.dato.DNI_artesano) then
				begin
					Agregar_Arbol(a^.HI,art);
				end
				else
				begin
					Agregar_Arbol(a^.HD,art);
				end;
			end;
		end;
	end;
	
	
	
	Procedure Agregar_Adelante(var L: Lista; d: datos_lista);
	var
		aux: Lista;
	begin
		new(aux);
		aux^.dato:= d;
		aux^.sig:= L;
		L:= aux;
	end;
	
	Procedure Cargar_Lista(var L: Lista; d: datos_lista);
	begin
		
		if  (L = nil) then
		begin
			d.cant_total:= 1;
			Agregar_Adelante(L,d);
		end
		else
		begin
			
			if (d.material_base = L^.dato.material_base) then
			begin
				L^.dato.cant_total:= L^.dato.cant_total + 1;
			end
			else
			begin
				Cargar_Lista(L^.sig,d);
			end;
		end;
	end;
	
	Procedure Cargar_Informacion(var a: arbol; var L:Lista);
	var
		art: artesania;
		d: datos_lista;
	begin
		
		Leer_Datos(art);
		
		while (art.DNI <> fin) do
		begin
			Agregar_Arbol(a,art);
			d.material_base:= art.nombre_base;
			Cargar_Lista(L,d);
			Leer_Datos(art);
		end;
	end;
	
	{b) Implementar un módulo que reciba el árbol generado
	en el inciso a)i), y un DNI. El módulo debe retornar 
	la cantidad de artesanos con DNI menor al DNI 
	ingresado.}
	
	
	Function Cantidad(a: arbol; num_dni: integer): integer;
	begin
		
		if (a = nil) then
		begin
			Cantidad:= 0;
		end
		else
		begin
			
			if (a^.dato.DNI_artesano < num_dni) then
			begin
				Cantidad:= Cantidad(a^.HI,num_dni) + Cantidad(a^.HD,num_dni) + 1;
			end
			else
			begin
				Cantidad:= Cantidad(a^.HI,num_dni);
			end;
		end;
	end;
	
	
	{c) Implementar un módulo recursivo que reciba la lista 
	generada en el inciso a)ii) y retorne el nombre de 
	material base con mayor cantidad de artesanías.}
	
	Function Nombre(L: Lista; max: integer; d: string): string;
	begin
		
		if (L = nil) then
		begin
			Nombre:= d;
		end
		else
		begin
			
			if (L^.dato.cant_total > max) then
			begin
				max:= L^.dato.cant_total;
				d:= L^.dato.material_base;
				Nombre:= Nombre(L^.sig,max,d);
			end
			else
			begin
				Nombre:= Nombre(L^.sig,max,d);
			end;
		end;
	end;
	
	
	
	
var
	a: arbol;
	L: Lista;
	x: integer;
	max: integer;
	d: string;
begin
	a:= nil;
	L:= nil;
	max:= 0;
	d:= '';
	
	
	{Inciso (a(i)) y Inciso (a(ii))}
	Cargar_Informacion(a,L);
	
	{Inciso (b)}
	write('Ingrese el DNI para el inciso (b): ');
	read(x);
	
	Cantidad(a,x);
	
	
	{Inciso (c)}
	writeln('El Material de la base con mayor cantida de artesanias fue -> [',Nombre(L,max,d),'] ');
end.
