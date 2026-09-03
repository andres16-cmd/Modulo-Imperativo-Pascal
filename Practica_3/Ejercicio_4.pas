Program Ejercicio_4;
const
	fin = 0;
type
	
	tiempo = record
		dia: integer;
		mes: integer;
		anio: integer;
	end;
	
	finales = record	
		legajo: integer;
		cod_materia: integer;
		fecha: tiempo;
		nota: integer;
	end;
	
	Lista = ^nodoLista;
	
	nodoLista = record	
		dato: finales;
		sig: Lista;
	end;
	
	alumno = record	
		numero_legajo: integer;
		L: Lista;
	end;
	
	arbol = ^nodoArbol;
	
	nodoArbol = record	
		dato: alumno;
		HI: arbol;
		HD: arbol;
	end;
	
	{a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de
	Informática y los almacene en una estructura de datos. La información que se lee es legajo
	(1000 a 1050), código de materia (1 a 25), fecha y nota. La lectura de los alumnos finaliza con
	legajo 0. La estructura generada debe ser eficiente para la búsqueda por número de legajo y
	para cada alumno deben guardarse los finales que rindió en una lista. Nota: No repetir
	información!!!}
	
	Function AleatorioEntre(num1,num2: integer): integer;
	begin
		AleatorioEntre:= random(num2-num1+1)+num1;
	end;
	
	Procedure Leer_Datos(var f: finales);
	begin
		
		f.legajo:= AleatorioEntre(0,1050);
		
		if (f.legajo <> fin) then
		begin
			f.cod_materia:= AleatorioEntre(1,25);
			f.fecha.dia:= AleatorioEntre(1,31);
			f.fecha.mes:= AleatorioEntre(1,12);
			f.fecha.anio:= AleatorioEntre(2004,2026);
			f.nota:= AleatorioEntre(0,10);
		end;
	end;
	
	
	Procedure Agregar_Adelante(var L: Lista; f: finales);
	var	
		aux: Lista;
	begin
		new(aux);
		aux^.dato:= f;
		aux^.sig:= L;
		L:= aux;
	end;
	
	Procedure Agregar_Arbol(var a:arbol; f: finales);
	begin
		
		if (a = nil) then
		begin
			new(a);
			a^.dato.numero_legajo:= f.legajo;
			a^.dato.L:= nil;
			Agregar_Adelante(a^.dato.L,f);
			a^.HI:= nil;
			a^.HD:= nil;
		end
		else
		begin
			
			if (a^.dato.numero_legajo = f.legajo) then
			begin
				Agregar_Adelante(a^.dato.L,f);
			end
			else
			begin
			
				if (f.legajo < a^.dato.numero_legajo) then
				begin
					Agregar_Arbol(a^.HI,f);
				end
				else
				begin
					Agregar_Arbol(a^.HD,f);
				end;
			end;
		end;
	end;
	
	Procedure Cargar_Arbol(var a: arbol);
	var
		f: finales;
	begin
		
		Leer_Datos(f);
		
		while (f.legajo <> fin) do
		begin
			Agregar_Arbol(a,f);
			Leer_Datos(f);
		end;
	end;
	
	
	{b. Un módulo que reciba la estructura generada en a. e 
	informe, para cada alumno, su legajo y su cantidad de 
	finales aprobados (nota mayor o igual a 4).}
	
	Function Cumple(L: Lista): integer;
	begin
		
		if (L = nil) then
		begin
			Cumple:= 0;
		end
		else
		begin
			
			if (L^.dato.nota >= 4) then
			begin
				Cumple:= Cumple(L^.sig) + 1;
			end
			else
			begin
				Cumple:= Cumple(L^.sig);
			end;
		end;
	end;
	
	Procedure Informar(a: arbol);
	var
		aux: integer;
	begin
		if (a <> nil) then
		begin
			 aux:= Cumple(a^.dato.L);
			 
			if (aux = 1) then
			begin
				writeln('El Alumno con Legajo [',a^.dato.numero_legajo,'] tuvo [',aux,'] final aprobado');
			end
			else 
			begin
				writeln('El Alumno con Legajo [',a^.dato.numero_legajo,'] tuvo [',aux,'] finales aprobados');
			end;
			
			Informar(a^.HI);
			Informar(a^.HD);
		end;
	end;
	
	{c. Un módulo que reciba la estructura generada en a. y un código de 
	materia. El módulo debe retornar la cantidad de alumnos que aprobó la 
	materia recibida y la cantidad de alumnos que desaprobó la materia recibida.}
	
	Function Aprobo_Materia(L :Lista; x: integer): boolean;
	begin
		if (L = nil) then
		begin
			Aprobo_Materia:= false;
		end
		else
		begin
			
			if ((L^.dato.cod_materia = x)and(L^.dato.nota >= 4)) then
			begin
				Aprobo_Materia:= true;
			end
			else
			begin
				Aprobo_Materia:= Aprobo_Materia(L^.sig,x);
			end;
		end;
	end;
	
	Procedure Cantidad_Alumnos(a: arbol; codigo: integer; var aprobo,desaprobo: integer);
	begin
		if (a <> nil) then
		begin
			
			if (Aprobo_Materia(a^.dato.L,codigo)) then
			begin
				aprobo:= aprobo + 1;
			end
			else
			begin
				desaprobo:= desaprobo +1;
			end;
			
			Cantidad_Alumnos(a^.HI,codigo,aprobo,desaprobo);
			Cantidad_Alumnos(a^.HD,codigo,aprobo,desaprobo);
		end;
	end;
	
	{d. Un módulo que reciba la estructura generada en a. y un valor entero.
	Este módulo debe retornar la cantidad de alumnos con cantidad de finales 
    rendidos igual al valor entero recibido.}
    
    Function Contador(L: Lista): integer;
    begin
		if (L = nil) then
		begin
			Contador:= 0;
		end
		else
		begin
			Contador:= Contador(L^.sig) +1;
		end;
    end;
    
    
    Procedure Cantidad_Alumnos2(a: arbol; valor: integer; var contador_total: integer);
    var
		aux: integer;
    begin
		
		if (a <> nil) then
		begin
			
			aux:= Contador(a^.dato.L);
			
			if (aux = valor) then
			begin
				contador_total:= contador_total+1;
			end;
			
			Cantidad_Alumnos2(a^.HI,valor,contador_total);
			Cantidad_Alumnos2(a^.HD,valor,contador_total);
		end;
    end;
    
    
var
	a: arbol;
	aprobo,desaprobo,h: integer;
	valor,num: integer;
begin

	a:= nil;
	aprobo:= 0;
	desaprobo:= 0;
	num:= 0;
	
	Randomize;
	
	Cargar_Arbol(a);
	
	{Inciso b.}
	Informar(a);
	
	{Inciso c.}
	write('Ingrese el codigo de materia (1..25): ');
	read(h);
	Cantidad_Alumnos(a,h,aprobo,desaprobo);
	
	writeln('La cantida de Alumnos Aprobados fueron [',aprobo,']');
	writeln('La cantida de Alumnos Desaprobados fueron [',desaprobo,']');
	
	
	{Inciso d.}
	write('Ingrese un valor entero: ');
	read(valor);
	Cantidad_Alumnos2(a,valor,num);
	
	writeln('La cantida de Alumnos que cumplieron lo pedido fueron [',num,']');
	
end.
