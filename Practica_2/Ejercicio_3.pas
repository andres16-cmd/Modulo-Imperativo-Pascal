Program Ejercicio_3;
const
	dimF = 20;
	fin = '.';
type
	{a. Un módulo recursivo que retorne un vector de a lo 
	sumo 20 caracteres que conformen una palabra. 
	La lectura de los caracteres termina en ‘.’}
	
	vector = array[1..dimF] of char;
	
	Procedure Cargar_Vector(var v: vector; var dimL : integer);
	var
		aux: char;
	begin
		if (dimL < dimF) then
		begin
			write('Ingrese la Letra: ');
			readln(aux);
			
			if (aux <> fin) then
			begin
				dimL:= dimL+1;
				v[dimL]:= aux;
				Cargar_Vector(v,dimL);
			end;
		end;
	end;
	
	Procedure Print_Vector(v:vector; dimL: integer);
	begin
		if (dimL > 0) then
		begin
			Print_Vector(v,dimL-1);
			write('| ',v[dimL],'|');
		end;
	end;
	
	
	{b. Un módulo recursivo que reciba la “palabra” generada en a)
	y determine si dicha palabra es un palíndromo, es decir, si 
	puede leerse de la misma manera de izquierda a derecha que de
    derecha a izquierda. 
    Este módulo debe retornar el valor booleano correspondiente.}
    
    Function Palindromo(v:vector; pri,dimL: integer): boolean;
    begin

		if (pri >= dimL) then
		begin
				Palindromo:= true;
		end
		else
		begin
			if (v[pri] <> v[dimL])then
			begin
				Palindromo:= false;
			end
			else
			begin
				Palindromo:= Palindromo(v,pri+1,dimL-1);
			end;
		end;
    end;
var
	v: vector;
	pri,dimL: integer;
begin
	
	dimL:= 0;
	pri:= 1;
	
	Cargar_Vector(v,dimL);
	writeln('');
	writeln('Vector de Caracteres');
	writeln('');
	Print_Vector(v,dimL);
	writeln('');
	
	if (Palindromo(v,pri,dimL)) then
	begin
		writeln('');
		writeln('La Palabra del Vector es Palindromo.');
		writeln('');
	end
	else
	begin
		writeln('');
		writeln('La Palabra del Vector NO es Palindromo.');
		writeln('');
	end;
end.
