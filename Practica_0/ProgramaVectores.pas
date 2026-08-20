Program Ejercicio_2;
const
	dimF = 50;
type
	
	vector = array[1..dimF] of integer;
	
	{a) Implemente un módulo CargarVector que cree un vector 
	de enteros con a lo sumo 50 valores aleatorios. Los valores, 
	generados aleatoriamente (entre un mínimo y máximo recibidos
	por parámetro),deben ser almacenados en el vector en el mismo 
	orden que se generaron, hasta que se genere el valor máximo.}
	
	Procedure Cargar_Vector(var v:vector; var dimL: integer; min,max: integer);
	var
		aux: integer;
	begin
		dimL:= 0;
		aux:= random(max-min+1)+min;
		
		while ((dimL < dimF)and(aux <> max)) do
		begin
			dimL:= dimL+1;
			v[dimL]:= aux;
			aux:= random(max-min+1)+min;
		end;
		readln;
	end;
	
	
	{b) Implemente un módulo ImprimirVector que reciba el vector generado
	en a) e imprima todos los valores de las posiciones pares del vector en
	el mismo orden que están almacenados. ¿Qué cambiaría para imprimir
	en orden inverso?}
	Procedure Imprimir_Vector(v:vector; dimL: integer);
	var
		i: integer;
	begin
		i:= 2;
		
		while (i <= dimL) do
		begin
			writeln('Posicion[',i,'] -> ',v[i]);
			i:= i+2;
		end;
		readln;
		// Respondiendo a la pregunta,cambiara solo la manera de 
		// empiezar; comienzo con dimL y le resto 2 a i .
	end;
	
	
	
	
var
	V: vector;
	dimL,min,max: integer;
begin
	randomize;
	
	write('Ingrese el valor Maximo: ');
	read(max);
	write('Ingrese el valor Minimo: ');
	read(min);
	
	Cargar_Vector(V,dimL,min,max);
	
	Imprimir_Vector(v,dimL);
end.
