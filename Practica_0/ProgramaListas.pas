Program Ejercicio_3;
type
	
	Lista = ^nodo;
	
	nodo = record 
		dato: integer;
		sig: Lista;
	end;
	
{a) Implemente un módulo CargarLista que cree una lista de enteros y le
agregue valores aleatorios entre el 100 y 150, hasta que se genere el
120.}
	Procedure Agregar_Adelante(var L: Lista; n:integer);
	var
		aux: Lista;
	begin
		new(aux);
		aux^.dato:= n;
		aux^.sig:= L;
		L:= aux;
	end;
	
	Procedure Cargar_Lista(var L: Lista);
	var
		aux: integer;
	begin
		aux:= random(150-100+1)+100;
		
		while (aux <> 120) do
		begin
			Agregar_Adelante(L,aux);
			aux:= random(150-100+1)+100;
		end;
		readln;
	end;
	
  {b) Implemente un módulo ImprimirLista que reciba una lista generada en
  "a" e imprima todos los valores de las posiciones impares de la lista 
   en el mismo orden que están almacenados.}
	Procedure Imprimir_Lista(L: Lista);
	var
		pos: integer;
	begin
		pos:= 1;
		while (L <> nil) do
		begin
			writeln('Posicion [',pos,'] -> ',L^.dato);
			L:= L^.sig;
			
			if (L <> nil) then
			begin
				L:= L^.sig;
				pos:= pos + 2;
			end;
		end;
		readln;
	end;
	
	{c) Implemente un módulo BuscarElemento que reciba la lista generada en
	 "a" y un valor entero y retorne true si el valor se encuentra en la 
	 lista y false en caso contrario.}
	 Function Buscar_Elemento(L: Lista; valor: integer): boolean;
	 var
		ok: boolean;
	 begin
		ok:= false;
		
		while (L <> nil) and (ok = false) do
		begin
			if (L^.dato = valor) then
			begin
				ok:= true;
			end
			else
			begin
				L:= L^.sig;
			end;
		end;
		
			Buscar_Elemento:= ok;
	 end;
var
	L:Lista;
	numero: integer;
begin
	L:= nil;
	
	Cargar_Lista(L);
	Imprimir_Lista(L);
	
	write('Ingrese el numero a buscar en la Lista: ');
	read(numero);
	
	if (Buscar_Elemento(L,numero)) then
	begin
		writeln('El numero Si se Encontro en la Lista');
	end
	else
	begin
		writeln('El numero NO se Encontro en la Lista');
	end;
	readln;
end.
