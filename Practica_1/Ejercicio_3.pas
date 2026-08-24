Program Ejercicio_3;
const
	dimF = 8;
	fin = -1;
type
	
	rango = 1..8;
	
	pelicula = record
		codigo: integer;
		genero: rango;
		puntaje: real;
	end;
	
	Lista = ^nodo;
	
	nodo = record
		dato: pelicula;
		sig: Lista;
	end;
	
	{Vector donde estara Todo}
	vector_generos = array[1..dimF] of Lista; 
	{Vector donde estara el ultimo de la lista.}
	vector_ult = array[1..dimF] of Lista;
	{Vector donde se guardaran los cod maximos de cada genero.}
	vector_max = array[1..dimF] of integer;
	
	{a. Lea los datos de películas, almacenarlos por orden de llegada 
	 y agrupados por código de género, y retornar en una estructura 
	 de datos adecuada. La lectura finaliza cuando se lee el código 
	 de la película -1.}
	 
	 Procedure Leer_Datos(var p:pelicula);
	 begin
		write('Ingrese el Codigo: ');
		readln(p.codigo);
		write('Ingrese el Genero: ');
		readln(p.genero);
		write('Ingrese el Puntaje: ');
		readln(p.puntaje);
	 end;
	 
	 Procedure Agregar_Atras(var L,Ult: Lista; p:pelicula);
	 var
		Nue: Lista;
	 begin
			new(Nue);
			Nue^.dato:= p;
			Nue^.sig:= nil;
			
			if (L = nil) then
			begin
				L:= Nue;
			end
			else
			begin
				Ult^.sig:= Nue;
			end;
			
			Ult:= Nue;
	 end;
	
	Procedure Inicilizar_vectores(var v1: vector_generos; var v2: vector_ult;  var v3: vector_max);
	var
		i: integer;
	begin
		for i:= 1 to dimF do
		begin
			v1[i]:= nil;
			v2[i]:= nil;
			v3[i]:= 0;
		end;
	end;	
	
	Procedure Cargar_Datos(var v1: vector_generos; var v2: vector_ult; var v3: vector_max);
	var
		p: pelicula;
	begin
	
		Inicilizar_vectores(v1,v2,v3);
		Leer_Datos(p);
		
		while (p.codigo <> fin) do
		begin
			Agregar_Atras(v1[p.genero],v2[p.genero],p);
			Leer_Datos(p);
		end;
	end;
	
	{b. Genere y retorne en un vector, para cada género, el código de
	 película con mayor puntaje obtenido entre todas las críticas, a 
	 partir de la estructura generada en a).}
	 Procedure Recorrido(v1: vector_generos; var v3: vector_max);
	 var
		i,cod_max,cod_act: integer;
		max,act: real;
		L: Lista;
		ok: boolean;
	 begin
			for i:= 1 to dimF do
			begin
			
				max:= -1;
				L:= v1[i];
				ok:= false;
				
				while (L <> nil) do
				begin
				
					ok:= true;
					act:= L^.dato.puntaje;
					cod_act:= L^.dato.codigo;
					
					if (act > max) then
					begin
						max:= act;
						cod_max:= cod_act;
					end;
			
					L:= L^.sig;
				end;
				
				if (ok = false) then
				begin
					v3[i]:= -1;
				end
				else
				begin
					v3[i]:= cod_max;
				end;
			end;
	 end;
	 
	 {c. Ordene los elementos del vector generado en b) por puntaje utilizando 
	 el método visto en la teoría.}
	 Procedure Seleccion(var v3: vector_max);
	 var	
		i,j,pos,item: integer;
	 begin
			for i:= 1 to dimF do
			begin
				pos:= i;
				
				for j:= (i+1) to dimF do
				begin
					
					if (v3[j] < v3[pos]) then
					begin
						pos:= j;
					end;
				end;
				
				item:= v3[pos];
				v3[pos]:= v3[i];
				v3[i]:= item;
			
			end;
	 end;
	 
	 {d. Muestre el código de película con mayor puntaje y el código de 
	 película con menor puntaje, del vector obtenido en el punto c)}
	 Procedure Print(v3: vector_max);
	 begin
			writeln('El Codigo de La Pelicula con Mayor Puntaje es -> [',v3[8],']');
			writeln('El Codigo de La Pelicula con Menor Puntaje es -> [',v3[1],']');
	 end;
var	
	v1: vector_generos;
	v2: vector_ult;
	v3: vector_max;
begin
	Randomize;
	Cargar_Datos(v1,v2,v3);
	Recorrido(v1,v3);
	Seleccion(v3);
	Print(v3);

end.
