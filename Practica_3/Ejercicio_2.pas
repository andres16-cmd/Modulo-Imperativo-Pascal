Program Ejercici2;
const
	fin = 0;
type

	{Registro de Fecha individual}
	tiempo = record	
		dia: integer;
		mes: integer;
		anio: integer;
	end;
	
	{Registro de venta individual}
	venta = record	
		codigo: integer;
		fecha: tiempo;
		cantidad: integer;
	end;
	
	{Creacio del Arbol 1}
	arbol_1 = ^nodoArbol_1;
	
	nodoArbol_1 = record
		dato: venta;
		HI: arbol_1;
		HD: arbol_1;
	end;
	
	{Creacio del Arbol 2}
	venta2 = record	
		codigo: integer;
		cant_total: integer;
	end;
	
	arbol_2 = ^nodoArbol_2;
	
	nodoArbol_2 = record
		dato: venta2;
		HI: arbol_2;
		HD: arbol_2;
	end;
	
	{Creacion del Arbol 3}
	{Registro de una venta individual}
	venta3 = record	
		fecha: tiempo;
		cant_total: integer;
	end;
	
	{Lista de la ventas}
	Lista = ^nodoLista;
	
	nodoLista = record
		dato: venta3;
		sig: Lista;
	end;
	
	{Dato que vive en cada nodo del árbol}
	venta_arbol = record
		codigo: integer;
		L: Lista;
	end;
	
	arbol_3 = ^nodoArbol_3;
	
	nodoArbol_3 = record
		dato: venta_arbol;
		HI: arbol_3;
		HD: arbol_3;
	end;
	
	{Generar Numeros Aleatorios}
	Function AleatorioEntre(num1,num2: integer): integer;
	begin
		AleatorioEntre:= random(num2-num1+1)+num1;
	end;
	
	Procedure Leer_Datos(var v: venta);
	begin
		v.codigo:= AleatorioEntre(0,100);
		
		if (v.codigo <> fin) then
		begin
			v.fecha.dia:= AleatorioEntre(1,31);
			v.fecha.mes:= AleatorioEntre(1,12);
			v.fecha.anio:= AleatorioEntre(2000,2026);
			v.cantidad:= AleatorioEntre(1,200);
		end;
	end;
	
	{Modulo Arbol 1}
	Procedure Agregar_Arbol1(var a1: arbol_1; v1: venta);
	begin
		
		if (a1 = nil) then
		begin
			new(a1);
			a1^.dato:= v1;
			a1^.HI:= nil;
			a1^.HD:= nil
		end
		else
		begin
			
			if (v1.codigo < a1^.dato.codigo) then
			begin
				Agregar_Arbol1(a1^.HI,v1);
			end
			else
			begin
				Agregar_Arbol1(a1^.HD,v1);
			end;
		end;
	end;
	
	
	{Modulo Arbol 2}
	Procedure Agregar_Arbol2(var a2: arbol_2; v2: venta2);
	begin
		
		if (a2 = nil) then
		begin
			new(a2);
			a2^.dato:= v2;
			a2^.HI:= nil;
			a2^.HD:= nil;
		end
		else
		begin
			
			if (v2.codigo = a2^.dato.codigo) then
			begin
				
				a2^.dato.cant_total:= a2^.dato.cant_total + v2.cant_total;
			end
			else
			begin
				
				if (v2.codigo < a2^.dato.codigo) then
				begin
					Agregar_Arbol2(a2^.HI,v2);
				end
				else
				begin
					Agregar_Arbol2(a2^.HD,v2);
				end;
			end;
		end;
	end;
	
	procedure agregar_adelante (var l:lista; v3: venta3);
	var
	 aux: lista;
	begin
	   new(aux);
	   aux^.dato:= v3;
	   aux^.sig:= l;
	   l:= aux;
	 end;
	 
	procedure Agregar_arbol3(var a3: arbol_3; v: venta);
	var
	 v3: venta3;
	begin
		if (a3 = nil) then 
		begin
			new(a3);
			a3^.dato.codigo:= v.codigo;
			v3.fecha:= v.fecha;
			v3.cant_total:= v.cantidad;
			a3^.dato.L:= nil;
			agregar_adelante(a3^.dato.L,v3);
			a3^.HI:= nil;
			a3^.HD:= nil;
		end
		else
		begin
			
			if (v.codigo = a3^.dato.codigo) then
			begin
				v3.fecha:= v.fecha;
				v3.cant_total:= v.cantidad;
				agregar_adelante(a3^.dato.L,v3);
			end
			else
			begin
				if (v.codigo < a3^.dato.codigo) then
				begin
					Agregar_arbol3(a3^.HI,v);
				end
				else
				begin
					Agregar_arbol3(a3^.HD,v);
				end;
			end;
		end;
	 end;
	
	
	Procedure Cargar_Arboles(var a1: arbol_1; var a2: arbol_2; var a3: arbol_3);
	var
		v : venta;
		v2: venta2;
	begin
		Leer_Datos(v);
		
		while (v.codigo <> fin) do
		begin
			Agregar_Arbol1(a1,v);
			
			v2.codigo:= v.codigo;
			v2.cant_total:= v.cantidad;
			
			Agregar_Arbol2(a2,v2);
			Agregar_arbol3(a3,v);
			
			Leer_Datos(v);
		end;
	end;
	
	
 function cmpfecha(f1,f2 : fecha) : integer
 
 	
 function cant_fecha(a1:arbol_1; f: fecha):integer;
 begin
  if(a1 = nil ) then 
   begin
		cant_fecha:= 0;
   end
   else
   begin
		if (a1^.dato.fecha.dia = f.dia) and... then
		begin
			cant_fecha:= cant_fecha + a^.dato.cantida;
			cant_fecha(a1^.HI,f);
			cant_fecha(a1^.HD,f);
			
		end;
   end;
 end;	
	

Procedure Max(a2: arbol_2; var cant_max: integer; var cod_max: integer);
begin
	if (a2 <> nil) then
	begin
		
		if (a2^.dato.cant_total > cant_max) then
		begin
			cant_max:= a2^.dato.cant_total;
			cod_max:= a2^.dato.codigo;
		end;
		Max(a2^.HI,cant_max,cod_max);
		Max(a2^.HD,cant_max,cod_max);
	end;
end;


var
	a1: arbol_1;
	a2: arbol_2;
	a3: arbol_3;
	v: venta;
begin
	a1:= nil;
	a2:= nil;
	a3:= nil;
	
	Randomize;
	
	Cargar_Arboles(a1,a2,a3);
	writeln('Ingrese dia: ');
	read(dia);
	writeln('Ingrese mes: ');
	read(mes);
	writeln('Ingrese anio: ');
	read(anio);
	
	cant_fecha(a1,);
	
	
end.
