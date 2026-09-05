Program Ejercicio_1;
const
	fin = 'MMM';
	dimF = 2026;
type
	
	informacion = record
		patente: string;
		anio_fabricacion: integer;
		marca: string;
		color: string;
		modelo: string;
	end;
	
	{Estructura (i)}
	arbol_patente = ^nodoArbol_patente;
	
	nodoArbol_patente = record
		dato: informacion;
		HI: arbol_patente;
		HD: arbol_patente;
	end;
	
	{Estructura (ii)}
	arbol_marca = ^nodoArbol_marca;
	
	nodoArbol_marca = record	
		dato: informacion;
		HI: arbol_marca;
		HD: arbol_marca;
	end;
	
	{Estructura (d)}
	Lista = ^nodoLista;
	
	nodoLista = record
		dato: informacion;
		sig: Lista;
	end;
	
	vector = array[2015..dimF] of Lista;
	
	
	
	Procedure Leer_Datos(var i: informacion);
	begin

		write('Ingrese la Marca: ');
		readln(i.marca);
		
		if (i.marca <> fin) then
		begin
			write('Ingrese la Patente: ');
			readln(i.patente);
			
			write('Ingrese el Anio de Fabricacion: ');
			readln(i.anio_fabricacion);
			
			write('Ingrese el Color: ');
			readln(i.color);
			
			write('Ingrese el Modelo: ');
			readln(i.modelo);
		end;
	end;
	
	Procedure Agregar_Arbol_patente(var a: arbol_patente; i: informacion);
	begin
		
		if (a = nil) then
		begin
			new(a);
			a^.dato:= i;
			a^.HI:= nil;
			a^.HD:= nil;
		end
		else
		begin
			
			if (i.patente < a^.dato.patente) then
			begin
				Agregar_Arbol_patente(a^.HI,i);
			end
			else
			begin
				Agregar_Arbol_patente(a^.HD,i);
			end;
		end;
	end;
	
	Procedure Agregar_Arbol_marca(var a2: arbol_marca; i: informacion);
	begin
		
		if (a2 = nil) then
		begin
			new(a2);
			a2^.dato:= i;
			a2^.HI:= nil;
			a2^.HD:= nil;
		end
		else
		begin
			
			if (i.marca < a2^.dato.marca) then
			begin
				Agregar_Arbol_marca(a2^.HI,i);
			end
			else
			begin
				Agregar_Arbol_marca(a2^.HD,i);
			end;
		end;
	end;
	
	Procedure Cargar_Arboles(var a: arbol_patente; var a2: arbol_marca);
	var
		i: informacion;
	begin
		
		writeln('Informacion de Autos');
		Leer_Datos(i);
		
		while(i.marca <> fin) do
		begin
			Agregar_Arbol_patente(a,i);
			
			Agregar_Arbol_marca(a2,i);
			
			writeln(' ');
			Leer_Datos(i);
		end;
	end;
	
	
	{b) Invoque un módulo que reciba la estructura generada en el 
	inciso a) i) y una marca y retorne la cantidad de autos de dicha 
	marca que posee la agencia.}
	
	Function Cantidad_Marca(a: arbol_patente; m: string): integer;
	begin
		
		if (a = nil) then
		begin
			Cantidad_Marca:= 0;
		end
		else
		begin
		
			if (a^.dato.marca = m) then
			begin
				Cantidad_Marca:= Cantidad_Marca(a^.HI,m) + Cantidad_Marca(a^.HD,m) + 1;
			end
			else
			begin
				Cantidad_Marca:= Cantidad_Marca(a^.HI,m) + Cantidad_Marca(a^.HD,m);
			end;
		end;
	end;	
	
	{c) Invoque a un módulo que reciba la estructura generada en el inciso a) ii) 
	y una marca y retorne la cantidad de autos de dicha marca que posee la agencia.}

	Function Cantidad_Marca2(a2: arbol_marca; n: string): integer;
	begin
	
		if (a2 = nil) then
		begin
			Cantidad_Marca2:= 0;
		end
		else
		begin
			
			if (a2^.dato.marca = n) then
			begin
				Cantidad_Marca2:= Cantidad_Marca2(a2^.HI,n) + Cantidad_Marca2(a2^.HD,n) +1;
			end
			else
			begin
				Cantidad_Marca2:= Cantidad_Marca2(a2^.HI,n) + Cantidad_Marca2(a2^.HD,n);
			end;
		end;
	end;


	{d) Invoque a un módulo que reciba el árbol generado en el inciso a) i) y 
	retorne una estructura con la información de los autos agrupados por año 
	de fabricación.}
	
	Procedure Agregar_Adelante(var L: Lista; i: informacion);
	var
		aux: Lista;
	begin
		new(aux);
		aux^.dato:= i;
		aux^.sig:= L;
		L:= aux;
	end;
	
	Procedure Ini_Vector(var v: vector);
	var
		i: integer;
	begin
		for i:= 2015 to dimF do
		begin
			v[i]:= nil; 
		end;
	end; 
	
	Procedure Cargar_Vector_Listas(a: arbol_patente; var v: vector);
	begin
		
		if (a <> nil) then
		begin
			Cargar_Vector_Listas(a^.HI,v);
			Agregar_Adelante(v[a^.dato.anio_fabricacion],a^.dato);
			Cargar_Vector_Listas(a^.HD,v);
		end;
	end;
	
	
	{e) Invoque a un módulo que reciba el árbol generado en el inciso
	a) i) y una patente y devuelva el modelo del auto con dicha patente.}
	
	Function Modelo_Auto(a: arbol_patente; patente_buscar: string): string;
	begin
		
		if (a = nil) then
		begin
			Modelo_Auto:= 'No se encontro porque la lista esta vacia.';
		end
		else
		begin
			
			if (a^.dato.patente = patente_buscar) then
			begin
				Modelo_Auto:= a^.dato.modelo;
			end
			else
			begin
				
				if (a^.dato.patente < patente_buscar) then
				begin
					Modelo_Auto:= Modelo_Auto(a^.HD,patente_buscar);
				end
				else
				begin
					Modelo_Auto:= Modelo_Auto(a^.HI,patente_buscar);
				end;
			end;
		
		end;
	end;
	
	{f) Invoque a un módulo que reciba el árbol generado en el inciso a) ii) 
	y una patente y devuelva el color del auto con dicha patente.}
	
	Function Color_Auto(a2: arbol_marca; patente_buscar: string): string;
	begin
		
		if (a2 = nil) then
		begin
			Color_Auto:= 'No se encontro';
		end
		else
		begin	
			
			if (a2^.dato.patente = patente_buscar) then
			begin
				Color_Auto:= a2^.dato.color;
			end
			else
			begin
				Color_Auto:= Color_Auto(a2^.HI,patente_buscar);
				
				if (Color_Auto = 'No se encontro') then
				begin
					Color_Auto:= Color_Auto(a2^.HD,patente_buscar);
				end;
				
			end;
		end;
	end;
	
	
	
	
	
	
	
	 
var
	a: arbol_patente;
	a2: arbol_marca;
	
	valor1: string;
	valor2: string;
	
	v: vector;
	
	p: string;
	p2: string;
	
begin
	a:= nil;
	a2:= nil;
	
	{Modulo de Carga de los Arboles}
	Cargar_Arboles(a,a2);

	{Modulo inciso (b)}
	write('Ingresa la Marca a buscar: ');
	readln(valor1);
	
	writeln('La Cantidad de autos de Marca[',valor1,'] en la agencia son [',Cantidad_Marca(a,valor1),'] ');
	
	{Modulo inciso (c)}
	write('Ingresa la Marca a buscar: ');
	readln(valor2);
	
	writeln('La Cantidad de autos de Marca[',valor2,'] en la agencia son [',Cantidad_Marca2(a2,valor2),'] ');

	{Modulo inciso (d)}
	Ini_Vector(v);
	Cargar_Vector_Listas(a,v);
	
	
	{Modulo inciso (e)}
	write('Ingrese la Patente a Buscar la Marca: ');
	readln(p);
	
	writeln('El Modelo del Auto es [',Modelo_Auto(a,p),'] con Patente [',p,']. ');

	{Modulo inciso (f)}
	write('Ingresa la Patente a Buscar el Color: ');
	readln(p2);
	
	writeln('El Color del Auto es [',Color_Auto(a2,p2),'] con Patente [',p2,']');
	
end.

