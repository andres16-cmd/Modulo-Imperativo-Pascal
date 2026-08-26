Program Ejercicio_4;
const
	fin = -1;
	dimF = 6;
	dimF2 = 20;
	rubro_IncisoC= 3;
type

	{Definicion de Rangos}
	rango = 1..6;
	
	producto = record
		cod_producto: integer;
		cod_rubro: rango;
		precio: real;
	end;
	
	Lista = ^nodo;
	
	nodo = record 
		dato: producto;
		sig: Lista;
	end;
	
	vector_rubros = array[1..dimF] of Lista;
	
	{Creamos el Vector del Inciso 3}
	vector_nuevo = array[1..dimF2] of producto;
	
	
	{a. Lea los datos de los productos y los almacene ordenados por 
	código de producto y agrupados por rubro, en una estructura de 
	datos adecuada. El ingreso de los productos finaliza cuando 
	se lee el precio -1.}
	
	Procedure Leer_Datos(var p: producto);
	begin
		
		writeln(' ');
		write('Ingrese el Precio del Producto: ');
		readln(p.precio);
		
		if (p.precio <> fin) then
		begin
			write('Ingrese el Codigo de Producto: ');
			readln(p.cod_producto);
			write('Ingrese el Codigo del Rubro(entre 1 y 6): ');
			readln(p.cod_rubro);
			writeln('-------------------------------------');
		end;
	end;
	
	Procedure Insertar_Ordenado(var L: Lista; p:producto);
	var
		Nue: Lista;
		Act,Ant: Lista;
	begin
		
		new(Nue);
		Nue^.dato:= p;
		Act:= L;
		Ant:= L;
		
		while ((Act <> nil)and(p.cod_rubro < Act^.dato.cod_rubro)) do
		begin
			Ant:= Act;
			Act:= Act^.sig;
		end;
		
		if (Act = Ant) then
		begin
			L:= Nue;
		end	
		else
		begin
			Ant^.sig:= Nue;
		end;
			
			Nue^.sig:= Act;
	end;
	Procedure Ini_Vector(var v: vector_rubros);
	var
		i: integer;
	begin
		for i:= 1 to dimF do
		begin
			v[i]:= nil;
		end;
	end;
	
	Procedure Cargar_Datos(var v: vector_rubros);
	var
		p: producto;
	begin
			Leer_Datos(p);
			
			while (p.precio <> fin) do
			begin
				Insertar_Ordenado(v[p.cod_rubro],p);
				Leer_Datos(p);
			end;
	end;	
	
	{b. Una vez almacenados, muestre los códigos de los 
	 productos pertenecientes a cada rubro.}
	 Procedure Print(v: vector_rubros);
	 var
		i: integer;
		L: Lista;
	 begin
			for i:= 1 to dimF do
			begin
				
					L:= v[i];{Asignamos el Puntero de la Lista}
				
					writeln('| Rubro [',i,'] |');
				
					while (L <> nil) do
					begin
						writeln('| Codigo -> ',L^.dato.cod_producto,'|');
						L:= L^.sig;
					end;
					
					writeln('|_________________________|');
			end;
	 end;
	 
	 {c. Genere un vector (de a lo sumo 20 elementos) con los productos del rubro 3.
	  Considerar que puede haber más o menos de 20 productos del rubro 3. Si la
	  cantidad de productos del rubro 3 es mayor a 20, se debe almacenar los
	  primeros 20 que están en la lista e ignore el resto.}
	  
	  
	  Procedure Cargar_DatosV3(v: vector_rubros; var v3: vector_nuevo; var dimL: integer);
	  var
		L: Lista;
	  begin
			L:= v[rubro_IncisoC];
			
			while ((L <> nil) and (dimL < 20)) do
			begin
				 dimL:= dimL+1;
				 v3[dimL]:= L^.dato;
				 L:= L^.sig;
			end;
	  end;
	  
	  {d. Ordenar, por precio, los elementos del vector generado en c) 
	   utilizando el método visto en la teoría.}
	   
	   Procedure Seleccion(var v3: vector_nuevo; dimL: integer);
	   var
		i,j,pos: integer;
		item: producto;
	   begin
			for i:= 1 to (dimL-1) do
			begin
				pos:= i;
				
				for j:= (i+1) to dimL do
				begin
						if (v3[j].precio < v3[pos].precio) then
						begin
							pos:= j;
						end;
				end;
				
				item:= v3[pos];
				v3[pos]:= v3[i];
				v3[i]:= item;
			end;
	   end;
	   
	   {e. Muestre los precios del vector resultante del punto d).}
	   Procedure Print2(v3: vector_nuevo; dimL: integer);
	   var
			i: integer;
	   begin
			for i:= 1 to dimL do 
			begin
				writeln('El Codigo del producto es -> ',v3[i].cod_producto);
				writeln('El Rubro del producto es -> ',v3[i].cod_rubro);
				writeln('El Precio del producto es -> ',v3[i].precio);
			end;
	   end;
	   
	   {f. Calcule el promedio de los precios del vector resultante del punto d)}
	   Function Promedio(): real;
	   var
	   
	   begin
	   
	   
	   end;
var
	v: vector_rubros;
	v3: vector_nuevo;
	dimL: integer;
begin
	Ini_Vector(v);
	
	Cargar_Datos(v);
	
	Print(v);
	
	Cargar_DatosV3(v,v3,dimL);
	
	Seleccion(v3,dimL);
	Print2(v3,dimL);
	
end.
