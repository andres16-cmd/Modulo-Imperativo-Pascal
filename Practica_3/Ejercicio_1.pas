{Escribir un programa que:
a. Implementar un modulo que almacene informacion de socios de un club participantes de un evento cultural en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio (entre 100 y 150), 
nombre y edad (entre 12 y 90). La carga finaliza con el numero de socio 100 (que no debe agregarse al arbol) y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente.
b. Una vez generado el arbol, realice modulos independientes que reciban el arbol como parametro para: 
    i. Informar los datos de los socios en orden creciente por número de socio.
    ii. Informar los datos de los socios en orden decreciente por número de socio.
    iii. Informar el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.
    iv. Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.
    vi. Leer un nombre e informar si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
    vii. Informar la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha cantidad.
    viii. Informar el promedio de edad de los socios. Debe invocar al módulo recursivo del inciso vii e invocar a un módulo recursivo que retorne la suma de las edades de los socios.
}

Program ImperativoClase3;

type 
	 
	 rangoEdad = 12..100;
     rangoSocio = 100..200;
     cadena15 = string [15];
     
     socio = record
           numero: rangoSocio;
           nombre: cadena15;
           edad: rangoEdad;
     end;
     
     arbol = ^nodoArbol;
     
     nodoArbol = record
            dato: socio;
            HI: arbol;
            HD: arbol;
     end;
     
     conjunto = set of rangoSocio;
     
procedure GenerarArbol (var a: arbol);
{ Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente.}

  Procedure CargarSocio (var s: socio; var conj: conjunto);
  var 
	vNombres:array [0..9] of string= ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola');  
  begin
    s.numero:= random (51) + 100;
    while (s.numero in conj) do
      s.numero:= random (51) + 100;
    If (s.numero <> 100)then 
    begin
         conj:= conj + [s.numero];
         s.nombre:= vNombres[random(10)];
         s.edad:= 12 + random (79);
    end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: socio);
  Begin
    if (a = nil) then begin
           new(a);
           a^.dato:= elem; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.numero < a^.dato.numero) 
         then InsertarElemento(a^.HI, elem)
         else InsertarElemento(a^.HD, elem); 
  End;

var unSocio: socio;  
    conj: conjunto;
Begin
 writeln;
 writeln ('----- Ingreso de socios y armado del arbol ----->');
 writeln;
 a:= nil;
 conj:=[];
 CargarSocio (unSocio, conj);
 while (unSocio.numero <> 100)do
  begin
   writeln ('Numero generado: ', unSocio.numero);
   InsertarElemento (a, unSocio);
   CargarSocio (unSocio, conj);
  end;
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure InformarSociosOrdenCreciente (a: arbol);
{ Informar los datos de los socios en orden creciente. }
  
  procedure InformarDatosSociosOrdenCreciente (a: arbol);
  begin
    if (a <> nil) then begin
        InformarDatosSociosOrdenCreciente (a^.HI);
        writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
        InformarDatosSociosOrdenCreciente (a^.HD);
    end;
  end;

Begin
 writeln;
 writeln ('----- Socios en orden creciente por numero de socio ----->');
 writeln;
 InformarDatosSociosOrdenCreciente (a);
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;


procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

     procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
	begin
	  if (nuevoValor >= maxValor) then
	  begin
		maxValor := nuevoValor;
		maxElem := nuevoElem;
	  end;
	end;
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		  actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad,maxNum);
		  numeroMasEdad(a^.hd, maxEdad,maxNum);
	   end; 
	end;

var maxEdad, maxNum: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio con mas edad: ', maxNum);
         writeln;
       end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure AumentarEdadNumeroImpar (a: arbol);
{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
  
  function AumentarEdad (a: arbol): integer;
  var resto: integer;
  begin
     if (a = nil) 
     then AumentarEdad:= 0
     else begin
            resto:= a^.dato.edad mod 2;
            if (resto = 1) then a^.dato.edad:= a^.dato.edad + 1;
            AumentarEdad:= resto + AumentarEdad (a^.HI) + AumentarEdad (a^.HD);
          end;  
  end;

begin
  writeln;
  writeln ('----- Cantidad de socios con edad aumentada ----->');
  writeln;
  writeln ('Cantidad: ', AumentarEdad (a));
  writeln;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

var a: arbol; 
Begin
  randomize;
  GenerarArbol (a);
  InformarSociosOrdenCreciente (a);
  {InformarSociosOrdenDecreciente (a); COMPLETAR}
  InformarNumeroSocioConMasEdad (a);
  AumentarEdadNumeroImpar (a);
  InformarSociosOrdenCreciente (a);
  { InformarExistenciaNombreSocio (a); COMPLETAR
    InformarCantidadSocios (a); COMPLETAR
    InformarPromedioDeEdad (a); COMPLETAR
  }   
end.
