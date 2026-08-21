Program Ejercicio_4;
type

	Lista = ^nodo;
	
	nodo = record
		dato: integer;
		sig: Lista;
	end;
	
{a) Implemente un módulo CargarListaOrdenada que cree una lista de
enteros y le agregue valores aleatorios entre el 100 y 150, hasta que se
genere el 120. Los valores dentro de la lista deben quedar ordenados
de menor a mayor.}

	Procedure Insertar_Ordenado(var L: Lista; n: integer);
	var
		Nue: Lista;
		Ant,Act: Lista;
	begin
	
		new(Nue);
		Nue^.dato:= n;
		Act:= L;
		Ant:= L;
		
		while ((Act <> nil )and(n > Act^.dato)) do
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
			Ant^.sig:= Act;
		end;
		
		Nue^.sig:= Act;
	end;
	
	Procedure CargarListaOrdenada(var L: Lista);
	var
		aux: integer;
	begin
	
		aux:= random(150-100+1)+100;		
		while (aux <> 120) do
		begin
			Insertar_Ordenado(L,aux);
			aux:= random(150-100+1)+100;
		end;
		readln;
	end;
	
  {b) Reutilice el módulo ImprimirLista que reciba una lista 
   generada en a) e imprima todos los valores de la lista en 
   el mismo orden que están almacenados.}
   Procedure Imprimir_Lista(L: Lista);
   var
	pos: integer;
   begin
		pos:= 1;
		while (L <> nil) do
		begin
			writeln('Posicion[',pos,'] -> ',L^.dato);
			pos:= pos + 1;
			L:= L^.sig;
		end;
		readln;
   end;
   
   {c) Implemente un módulo BuscarElementoOrdenado que reciba la 
   lista generada en a) y un valor entero y retorne true si el 
   valor se encuentra en la lista y false en caso contrario.}
	Function BuscarElementoOrdenado(L: Lista; valor: integer): boolean;
	var
		ok : boolean;
	begin
		ok:= false;
		
		while ((L <> nil)and(ok = false)) do
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
		
		BuscarElementoOrdenado:= ok;
	end;
var
	L: Lista;
	x: integer;
begin
	L:= nil;
	Randomize;
	
	CargarListaOrdenada(L);
	Imprimir_Lista(L);
	
	write('Ingrese el valor a buscar: ');
	read(x);
	
	if (BuscarElementoOrdenado(L,x)) then
	begin
		writeln('El Elmento Si esta en la Lista.');
	end
	else
	begin
		writeln('El Elmento No esta en la Lista.');
	end;
	readln;
end.
