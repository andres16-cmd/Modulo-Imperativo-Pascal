{Un gimnasio necesita procesar las asistencias de sus clientes.
Cada asistencia tiene día, mes, año, número de cliente 
(entre 1 y 500) y la actividad realizada (valor entre 1 y 5).}
Program Ejercicio_5;
const
	fin = 0;
type
	{Definimos los rangos a utilizar}
	rango_cliente = 1..500;
	rango_dia = 1..31;
	rango_mes = 1..12;
	rango_actv = 1..5; 
	 
	asistencia = record
		num_cliente: rango_cliente;
		dia: rango_dia;
		mes: rango_mes;
		anio: integer;
		actividad: rango_actv;
	end;
	
	Lista =  ^nodo;
	
	nodo = record
		dato: asistencia;
		sig: Lista;
	end;
	
	{a) Implemente un módulo que retorne una lista de asistencias de clientes un
    gimnasio. Las asistencias dentro de la lista deben quedar ordenadas de menor
    a mayor por número de cliente. Generar aleatoriamente los valores hasta
    generar un valor cero para el número de cliente.}
    
    Procedure Insertar_Ordenado(var L: Lista; a: asistencia);
    var
		Nue: Lista;
		Act,Ant: Lista;
    begin
    
		new(Nue);
		Nue^.dato:= a;
		Act:= L;
		Ant:= L;
		
		while ((Act <> nil )and (a.num_cliente > Act^.dato.num_cliente))do
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
    
    Procedure Cargar_Lista(var L:Lista; var a:asistencia);
    var
		aux_cliente: integer;
		aux_dia: integer;
		aux_mes: integer;
		aux_anio: integer;
		aux_actividad: integer;
    begin
		aux_cliente:= random(501);
		
		while (aux_cliente <> fin) do
		begin
				a.num_cliente:= aux_cliente;
				
				{Asignacion Dia}
				aux_dia:= random(31)+1;
				a.dia:= aux_dia;
				
				{Asignacion Mes}
				aux_mes:= random(12)+1;
				a.mes:= aux_mes;
				
				{Asignacion Anio}
				aux_anio:= random(2026-1940+1)+1940;
				a.anio:= aux_anio;
				
				{Asignacion Actividad}
				aux_actividad:= random(5)+1;
				a.actividad:= aux_actividad;
				
				Insertar_Ordenado(L,a);
				aux_cliente:= random(501);
		end;
    end;
    
    {b) Implemente un módulo que reciba la lista generada en a) e imprima todos
	 los valores de la lista en el mismo orden que están almacenados.}
	 Procedure Print(L: Lista);
	 begin
			writeln();
			writeln('Lista de Asistencias');
			writeln();
		while (L <> nil) do
		begin
			writeln('Numero de Cliente [',L^.dato.num_cliente,']');
			writeln('Dia -> ',L^.dato.dia);
			writeln('Mes -> ',L^.dato.mes);
			writeln('Anio -> ',L^.dato.anio);
			writeln('Actividad -> ',L^.dato.actividad);
			writeln();
			L:= L^.sig;
		end;
		readln;
	 end;
	 
	 {c) Implemente un módulo que reciba la lista generada en a) y un número de
	 cliente y retorne la cantidad de asistencias del cliente recibido. 
	 Mostrar el resultado desde el programa principal.}
	 Function Contar(L: Lista; valor: integer): integer;
	 var
		cont: integer;
		ok: boolean;
	 begin
			cont:= 0;
			ok:= false;
			
			while ((L <> nil) and (ok = false)) do
			begin
				if (L^.dato.num_cliente = valor) then
				begin
					cont:= cont+1;
					L:= L^.sig;
				end
				else if (L^.dato.num_cliente <> valor) then
				begin
					
					if (L^.dato.num_cliente > valor) then
					begin
						ok:= true;
					end;
					
					L:= L^.sig;
				end;
			end;
			
			Contar:= cont;
	 end;
	{d) Implemente un módulo que reciba la lista generada en a) 
	 y retorne la actividad con mayor cantidad de asistencias. 
	 Mostrar el resultado desde el programa principal.}
	 Function Mayor(L: Lista): integer;
	 var
		max,aux: integer;
	 begin
		aux:= 0;
		
			while (L <> nil) do
			begin
				if (L^.dato.actividad = 1) then
				begin
					cont
				end
			end;
		
	 end;
	 
var
	L: Lista;
	a: asistencia;
	x: integer;
begin
	L:= nil;
	Randomize;
	
	Cargar_Lista(L,a);
	
	Print(L);
	
	write('Ingrese el numero del cliente a buscar: ');
	read(x);
	
	writeln('La Cantidad de Asistencias del Cliente fueron -> [',Contar(L,x),']');
end.
