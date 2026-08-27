Program Ejercicio_2;
const
	fin = 200;
type
	{a.Implemente un módulo recursivo que genere y retorne una lista de
	números enteros “random” en el rango 200-230. 
	Finalizar con el número 200.}
	
	Lista = ^nodo;
	
	nodo = record
		dato: integer;
		sig: Lista;
	end;
	
	Procedure Agregar_Adelante(var L :Lista; x: integer);
	var
		aux: Lista;
	begin
		new(aux);
		aux^.dato:= x;
		aux^.sig:= L;
		L:= aux;
	end;
	
	Procedure Cargar_Lista(var L :Lista);
	var	
		aux: integer;
	begin
		aux:= random(230-200+1)+200; {random(B-A+1)+A;}
		
		if (aux <> fin) then
		begin
			Agregar_Adelante(L,aux);
			Cargar_Lista(L);
		end;
	end;
	
	{b. Un módulo recursivo que reciba la lista generada en a) 
	e imprima los valores de la lista en el mismo orden que 
	están almacenados.}
	Procedure Print1(L: Lista);
	begin
		if (L <> nil) then
		begin
			writeln('El numero generado en la Lista es -> [',L^.dato,']');
			Print1(L^.sig);
		end;	
	end;
	
	{c. Implemente un módulo recursivo que reciba la lista generada en 
	a) e imprima los valores de la lista en orden inverso al 
	que están almacenados.}
	
	Procedure Print2(L: Lista);
	begin
		if (L <> nil) then
		begin
			Print2(L^.sig);
			writeln('El numero generado en la Lista es -> [',L^.dato,']');
		end;	
	end;
	
	{d. Implemente un módulo recursivo que reciba la lista generada en 
	a) y devuelva el mínimo valor de la lista.}
	
	Function Minimo(L: Lista): integer;
	var
		min,valor: integer;
	begin
		
		if (L = nil) then
		begin
			Minimo:= 999;
		end
		else
		begin
			
			valor:= L^.dato;
			min:= Minimo(L^.sig);
			
			if (valor < min) then
			begin
				Minimo:= valor;
			end
			else
			begin
				Minimo:= min;
			end;
		end;
	end;
	
	{e. Implemente un módulo recursivo que reciba la lista generada en a) y un valor 
	y devuelva verdadero si dicho valor se encuentra en la lista o falso en caso contrario.}
	
	Function Encontrar(L: Lista; valor: integer): boolean;
	begin
		
		if (L = nil) then
		begin
			Encontrar:= false;
		end
		else
		begin
			
			if (valor = L^.dato) then
			begin
				Encontrar:= true;
			end
			else
			begin
				Encontrar:= Encontrar(L^.sig,valor);
			end;
		end;
	end;
	
var
	L: Lista;
	x: integer;
begin
	L:= nil;
	Randomize;
	Cargar_Lista(L);
	
	writeln('Impresion de Lista 1');
	Print1(L);
	writeln('/-------------------------------------/');
	writeln('Impresion de Lista 2');
	Print2(L);
	
	writeln('');
	writeln('El valor minimo encontrado fue -> [',Minimo(L),']');
	writeln('');
	
	
	write('Ingrese el valor a buscar en la Lista: ');
	readln(x);
	
	if (Encontrar(L,x)) then
	begin
		writeln('');
		writeln('El Valor Fue Encontrado En La Lista');
		writeln('');
	end
	else
	begin
		writeln('');
		writeln('El Valor NO Fue Encontrado En La Lista');
		writeln('');
	end;
	
end.	
