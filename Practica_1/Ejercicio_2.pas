Program Ejercicio_2;
const
	dimF = 300;
	fin = -1;
type
	
	oficina = record
		cod: integer;
		dni: integer;
		valor: integer;
	end;

	vector = array[1..dimF] of oficina;
	
	Procedure Cargar_Datos(var v: vector; var dimL: integer);
	var
		aux_cod: integer;
	begin
			dimL:= 0;
			aux_cod:= random(100-(-1)+1)+(-1); {-1 ... 100}
			
			while ((dimL < dimF) and (aux_cod <> fin)) do
			begin 
					dimL:= dimL+1;
					v[dimL].cod:= aux_cod;
					v[dimL].dni:= random(900-1+1)+1; {1...900}
					v[dimL].valor:= random(40000000)+1; {1...40000000}
					aux_cod:= random(100-(-1)+1)+(-1);
			end;
	end;
	
	Procedure Seleccion(var v: vector; dimL: integer);
	var
		i,j,pos,item: integer;
	begin
			for i:= 1 to (dimL-1) do
			begin
					pos:= i;
					
					for j:= (i+1) to dimL do
					begin
							if (v[j].cod < v[pos].cod) then
							begin
								pos:= j;
							end;
							
							item:= v[pos].cod;
							v[pos].cod:= v[i].cod;
							v[i].cod:= item;
					end;
			end;
	end;
	
	{Creamos un proceso para imprimir los datos del vector.}
	Procedure Print(v:vector; dimL: integer);
	var
		i: integer;
	begin
			
			for i:= 1 to dimL do
			begin
				writeln('El Codigo de la Oficina es [',v[i].cod,']');
				writeln('El DNI del propietario es [',v[i].dni,']');
				writeln('El Valor de las Expensas es [',v[i].valor,']');
				writeln('');
			end;
	end;
var
	v: vector;
	dimL: integer;
begin
	Randomize;
	Cargar_Datos(v,dimL);
	
	writeln('    Vector sin Orden');
	writeln('Informacion de Expensas');
	writeln('');
	
	Print(v,dimL);
	

	
	Seleccion(v,dimL);
	
	writeln('    Vector Ordenado');
	writeln('Informacion de Expensas');
	writeln('');
	
	Print(v,dimL);
end.
