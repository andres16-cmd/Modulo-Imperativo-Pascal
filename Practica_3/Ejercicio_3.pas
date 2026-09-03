Program Ejercicio_3;
const
	fin = 0;
type

	tiempo = record	
		dia: integer;
		mes: integer;
		anio: integer;
	end;
	
	prestamo = record	
		numero_socio: integer;
		codigo_libro: integer;
		fecha_prestamo: tiempo;
		cant_dias: integer;
	end;
	
	{Creamos la Lista}
	
	Lista = ^nodoLista;
	
	nodoLista = record
		dato: prestamo;
		sig: Lista;
	end;
	
	socio = record
		num_socio: integer;
		L: Lista;
	end;
	
	{Creamos el Arbol}
	
	arbol = ^nodoArbol;
	
	nodoArbol = record	
		dato: socio;
		HI: arbol;
		HD: arbol;
	end;
	
	Function AleatorioEntre(num1,num2: integer): integer;
	begin
		AleatorioEntre:= random(num2-num1+1)+num1;
	end;
	
	{Modulo que lee la informacion}
	Procedure Leer_Datos(var p: prestamo);
	begin
		p.numero_socio:= AleatorioEntre(0,60);
		
		if (p.numero_socio <> fin) then
		begin
			
			p.codigo_libro:= AleatorioEntre(200,230);
			
			p.fecha_prestamo.dia:= AleatorioEntre(1,31);
			p.fecha_prestamo.mes:= AleatorioEntre(1,12);
			p.fecha_prestamo.anio:= AleatorioEntre(2004,2026);
			
			p.cant_dias:= AleatorioEntre(1,365);
		end;
	end;
	
	Procedure Agregar_Adelante(var L :Lista; p: prestamo);
	var
		aux: Lista;
	begin
		new(aux);
		aux^.dato:= p;
		aux^.sig:= L;
		L:= aux;
	end;
	
	Procedure Agregar_Arbol(var a: arbol; p: prestamo);
	begin
		if (a = nil) then
		begin
			new(a);
			a^.dato.num_socio:= p.numero_socio; 
			a^.dato.L:= nil;
			Agregar_Adelante(a^.dato.L,p);
			a^.HI:= nil;
			a^.HD:= nil;
		end
		else
		begin
			
			if (p.numero_socio = a^.dato.num_socio) then
			begin
				Agregar_Adelante(a^.dato.L,p);
			end
			else
			begin
				if (p.numero_socio < a^.dato.num_socio) then
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
		p: prestamo;
	begin
		Leer_Datos(p);
		
		while (p.numero_socio <> fin) do
		begin
			Agregar_Arbol(a,p);
			Leer_Datos(p);
		end;
	end;
	
	{b. Un módulo que reciba la estructura generada en el inciso a) y 
	retorne la cantidad de socios cuyo número de socio es múltiplo de 5.}
	
	Function Cumple(num: integer): boolean;
	begin
		if ((num MOD 5) = 0) then
		begin
			Cumple:= true;
		end
		else
		begin
			Cumple:= false;
		end;
	end;
	
	Function Cantidad(a: arbol): integer;
	begin
		
		if (a = nil) then
		begin
			Cantidad:= 0;
		end
		else
		begin
			
			if (Cumple(a^.dato.num_socio)) then
			begin
				Cantidad:= Cantidad(a^.HI) + Cantidad(a^.HD) + 1;
			end
			else
			begin
				Cantidad:= Cantidad(a^.HI) + Cantidad(a^.HD) + 0;
			end;
		end;
	end;
	
	
	Function Contar(L: Lista): integer;
	begin
		
		if (L = nil) then
		begin
			Contar:= 0;
		end
		else
		begin
			if (L^.dato.cant_dias <= 7) then
			begin
				Contar:= Contar(L^.sig)+1;
			end
			else
			begin
				Contar:= Contar(L^.sig);
			end;
		end;
	end;
	
	Procedure Informar(a: arbol);
	begin
		if (a <> nil) then
		begin
			writeln('El socio [',a^.dato.num_socio,'] tuvo [',Contar(a^.dato.L),'] prestamos de libros menores o iguales a 7 dias. ');
			Informar(a^.HI);
			Informar(a^.HD);
		end;
	end;
	
	{d. Un módulo que reciba la estructura generada en el inciso a) y un 
	valor real que representa una cantidad promedio de días. El módulo
    debe retornar los números de socio y el promedio de días de préstamo 
    de aquellos socios cuyo promedio supere el valor ingresado.}
    
    
    Function Suma_dias(L: Lista): real;
    begin
		
		if (L = nil) then
		begin
			Suma_dias:= 0;
		end
		else
		begin
			Suma_dias:= Suma_dias(L^.sig) + L^.dato.cant_dias;	
		end;
    end;
    
    Function Longitud(L: Lista): integer;
    begin
		
		if (L = nil) then
		begin
			Longitud:= 0;
		end
		else
		begin
			Longitud:= Longitud(L^.sig) + 1;
		end;
    end;
    
    Procedure Recorrido(a:arbol; prom:real);
    var
		valor: real;
    begin
		if (a <> nil) then
		begin
			valor:= (Suma_dias(a^.dato.L)/Longitud(a^.dato.L));
			
			if (valor > prom) then
			begin
				writeln('El Socio [',a^.dato.num_socio,'] tuvo un promedio de [',valor,'] dias');
			end;
			
			Recorrido(a^.HI,prom);
			Recorrido(a^.HD,prom);
		end;
    end;
    
var
	a: arbol;
	x: real;
begin
	a:= nil;
	Randomize;
	
	{Solucion inciso a.}
	Cargar_Arbol(a);
	
	{Solucion inciso b.}
	writeln('La Cantidad de Socios cuyo numero de socio es multiplo de 5 fueron -> [',Cantidad(a),']');
	
	{Solucion inciso c.}
	Informar(a);
	
	{Solucion inciso d.}
	write('Ingrese el Promedio a compara: ');
	read(x);
	Recorrido(a,x);
end.
