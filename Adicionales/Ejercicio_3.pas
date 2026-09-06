Program Ejercicio_4;
const
	fin = 0;
	dimF = 7;
type

	{Creamos Los Registros Correspondientes}
	libro = record
		ISBN: integer;
		cod_autor: integer;
		genero: integer;
	end;
	
	datos_autor = record
		codigo_autor: integer;
		cant_libros: integer;
	end;
	
	{Creamos el Arbol Correspondiente}
	arbol = ^nodoArbol;
	
	nodoArbol = record
		dato: datos_autor;
		HI: arbol;
		HD: arbol;
	end;
	
	{Creamos Estructura inciso (a(ii))}
	
	datos_genero = record
		codigo_genero: integer;
		cant_libros: integer;
	end;
	
	vector_generos = array[1..dimF] of datos_genero;
	
	
	
	Function AleatorioEntre(num1,num2: integer): integer;
	begin
		AleatorioEntre:= random(num2-num1+1)+num1;
	end;
	
	Procedure Leer_Datos(var l:libro);
	begin
		l.ISBN:= AleatorioEntre(0,2000);
		
		if (l.ISBN <> fin) then
		begin
			l.cod_autor:= AleatorioEntre(1,2000);
			l.genero:= AleatorioEntre(1,7);
		end;
	end;
	
	Procedure Agregar_Arbol(var a: arbol; l: libro);
	begin
		
		if (a = nil) then
		begin
			new(a);
			a^.dato.codigo_autor:= l.cod_autor;
			a^.dato.cant_libros:= 1;
			a^.HI:= nil;
			a^.HD:= nil;
		end
		else
		begin
		
			if (l.cod_autor = a^.dato.codigo_autor) then
			begin
				a^.dato.cant_libros:= a^.dato.cant_libros + 1;
			end
			else
			begin
			
				if (l.cod_autor < a^.dato.codigo_autor) then
				begin
					Agregar_Arbol(a^.HI,l);
				end
				else
				begin
					Agregar_Arbol(a^.HD,l);
				end;
			end;
		end;
	end;
	
	
	{ii) Un vector que almacena para cada género, el código del género y 
	la cantidad de libros del género.}
	
	Procedure Ini_Vector(var v: vector_generos);
	var
		i: integer;
	begin
		
		for i:= 1 to dimF do
		begin
			v[i].codigo_genero:= i;
			v[i].cant_libros:= 0;
		end;
	end;
	
	Procedure Cargar_Vector(var v: vector_generos; l: libro);
	begin
		v[l.genero].cant_libros:= v[l.genero].cant_libros + 1;
	end;
	
	
	Procedure Cargar_Informacion(var a: arbol; var v: vector_generos);
	var
		l: libro;
	begin
		
		Leer_Datos(l);
		
		while (l.ISBN <> fin) do
		begin
			Agregar_Arbol(a,l);
			Cargar_Vector(v,l);
			Leer_Datos(l);
		end;
	end;

	{b) Implementar un módulo que reciba el vector generado en el inciso 
	a) y lo ordene por cantidad de libros de mayor a menor.}

	Procedure Seleccion(var v: vector_generos; dimL: integer);
	var
		i,j,pos: integer;
		item: datos_genero;
	begin
		
		for i:= 1 to (dimL-1) do
		begin
			
			pos:= i;
			
			for j:= (i+1) to dimL do
			begin
				
				if (v[j].cant_libros > v[pos].cant_libros) then
				begin
					pos:= j;
				end;
			end;
			
			item:= v[pos];
			v[pos]:= v[i];
			v[i]:= item;
		end;
	end;
	
	
	{c) Implementar un módulo que retorne el nombre de 
	género con mayor cantidad cantidad de libros.}
	
	Function Nombre(num: integer): string;
	begin
		
		case num of
			1: Nombre:= 'Literario';
			2: Nombre:= 'Filosofia';
			3: Nombre:= 'Biologia';
			4: Nombre:= 'Arte';
			5: Nombre:= 'Computacion';
			6: Nombre:= 'Medicina';
			7: Nombre:= 'Ingenieria';
		end;
	end;
	
	Function Retorno(v: vector_generos): string;
	begin
		Retorno:= Nombre(v[1].codigo_genero);
	end;
	
	{d) Implementar un módulo que reciba el árbol generado
	en el inciso a) y dos códigos de autores. El módulo 
	debe retornar la cantidad total de libros 
	correspondientes a los códigos de autores entre los 
	dos códigos ingresados (incluidos ambos).}
	
	Function Cant_Total(a: arbol; cod1,cod2: integer): integer;
	begin
		
		if (a = nil) then
		begin
			Cant_Total:= 0;
		end
		else
		begin
		
			if (cod1 < a^.dato.codigo_autor) then
			begin
				Cant_Total:= Cant_Total(a^.HI,cod1,cod2);
			end
			else if (cod2 > a^.dato.codigo_autor) then
			begin	
				Cant_Total:= Cant_Total(a^.HD,cod1,cod2);
			end
			else
			begin
				Cant_Total:= Cant_Total(a^.HI,cod1,cod2) + a^.dato.cant_libros + Cant_Total(a^.HI,cod1,cod2);
			end;
		end;
	end;
	

var
	a: arbol;
	v: vector_generos;
	dimL :integer;
	cod1,cod2: integer;
begin
	a:= nil;
	Randomize;
	
	Ini_Vector(v);
	
	{(Inciso (a(i)) ) and (Inciso (a(ii)))}
	Cargar_Informacion(a,v);
	
	
	{Inciso (b)}
	dimL:= dimF;
	Seleccion(v,dimL);
	
	{Inciso (c)}
	writeln('El Nombre con Mayor Cantidad de Libros es -> ',Retorno(v));

	
	{Iniciso (d)}
	write('Ingrese el Codigo 1: ');
	read(cod1);
	write('Ingrese el Codigo 2: ');
	read(cod2);
	
	writeln('La Cantida Total de libros entre los Codigos ingresados fue de -> [',Cant_Total(a,cod1,cod2),']');
end.
