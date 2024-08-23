{https://es.wikipedia.org/wiki/Visualizador_de_siete_segmentos }
{
     TRectangle = record
         x      : single; // Rectangle top-left corner position x
         y      : single; // Rectangle top-left corner position y
         width  : single; // Rectangle width
         height : single; // Rectangle height
rgba(250, 107, 63, 0.38)
         }
program s7;

uses
  raylib;

const
  alto = 200;
  ancho = 400;
  segV = ancho*0.06;
  segH = alto*0.026;
  nums: array[0..9] of integer =
  (126,6,109,121,51,91,95,112,127,123);
  cx: array [0..1] of integer = (340,660);
  cy: array[0..1] of integer = (413,368);
  
  {0 = x = 340, y = 413
  1 = x 340, y = 368;
  2 = x 660, y 413;
  3 = x 660, y 368;
  }
{
0 = 1111110
1 = 0000110
2 = 1101101
3 = 1111001
4 = 0110011
5 = 1011011
6 = 1011111
7 = 1110000
8 = 1111111
9 = 1111011
}
  
type
  OnOff = array[0..9,0..6] of boolean;
  cronos =array[0..5] of integer;
  Aseg = array[0..5,0..6] of TRectangle;


procedure init_s(var s2:Aseg);
var
  j,i:integer;
  s:TRectangle;
  ax,ay:real;
begin
  s.y:= (alto div 2) - (segH / 2) -  (segV + segH);
  s.x:= ancho/2 -((segH*2)*4+(segV*4)) - segH/2;
  ay:= s.y;
  for j:= 0 to 5 do begin
    ax:= s.x;
  for i:= 0 to 6 do begin
    if(i = 0) or (i = 3) or (i = 6)then begin
      s.width:= segV;
      s.height:= segH;
      end
    else begin
      s.width:= segH;
      s.height:= segV;
    end;
    if i < 1 then
      s.x:= s.x + segH;
    if i = 1 then begin
      s.x:= s.x + segV;
      s.y:= s.y + segH;
    end;
    if i = 2 then
      s.y:= s.y + segH + segV;
    if i = 3 then begin
      s.x:=s.x - segV;
      s.y:= s.y + segV;
    end;
    if i = 4 then begin
      s.y:= s.y  - segV;
      s.x:= ax;
    end;
    if i = 5 then
      s.y:= s.y - segv -segH;
    if i = 6 then begin
      s.x := s.x + segH;
      s.y:= s.y + segV
    end;
    s2[j,i].x:= s.x;
    s2[j,i].y:= s.y;
    s2[j,i].height:= s.height;
    s2[j,i].width:= s.width;
  end;
  s.y:= ay;
  if(j = 1) or (j = 3)then
    s.x:= s.x +segV*2 + segH*2
  else
  s.x := s.x + segV + segH*2;
end;
end;


function potencia(e:integer):integer;
var
  i:integer;
  base:integer;
begin
  base:= 2;
  if e >= 2 then
    begin
    for i:= 2 to e do
      base:= base * 2
  end
    else
      begin
        if e = 0 then
          base:= 1;
      end;
  potencia:= base;
end;

//Transformamos las combinaciones de los 7 segmentos a numero decimal(Interpretamos las convinaciones en BSS)
procedure bb(var vf:OnOff);// Binario a boolean
var
  i,j,acu,exp,pot:integer;
begin
  exp:= 6;
  acu:= 0;
  for i:= 0 to 9 do
  begin
    for j:= 0 to 6 do
    begin
      pot:= potencia(exp);
      if acu + pot <= nums[i] then
      begin
        vf[i,j]:= true;
        acu:= acu + pot;
        exp:= exp - 1;
      end
      else
      begin
        vf[i,j]:= false;
        exp:= exp - 1
      end;
    end;
    exp:= 6;
    acu:= 0

  end;
end;
procedure init_cn(var cn:cronos); // Iniciamos el cronometro en 10 min, esta dispuesto como un array de 0..5
var
  i:integer;
begin
  for i:= 0 to 5 do
    begin
      if i = 2 then
        cn[i]:= 1
      else
        cn[i]:= 0;
    end;
end;

procedure corre(var cn:cronos);
var
  i,j,pos:integer;
 
begin
  
  pos:= 5;
  if cn[pos] = 0 then
  begin
    //cn[pos]:= 9;
    for i:= pos-1 downto 0 do //Buscando el digito mas proximo mayor a cero
begin
  if cn[i] > 0 then //Encuentro el digito mas proximo.
begin

  if cn[i] = 1 then
  begin
    cn[i]:=cn[i] - 1;
    if i + 1 <> pos then
    begin
      for j:= i +1 to pos do
      begin
        //writeln(j);
        if j mod 2 = 0 then
          cn[j]:= 5
        else
          cn[j]:= 9;
      end;
    end
    else
      break;
    end
    else
    begin
      cn[i]:= cn[i] - 1;
      if cn[i + 1] = 0 then
      begin
        if ((i + 1) mod 2 = 0) then
          cn[i + 1]:= 5
        else
          cn[i + 1]:= 9
      end;
      break
    end;
  end;
end;
  end
  else
    cn[pos]:= cn[pos] - 1;

end;
function digito(cn:cronos;pos:integer):integer;
begin
  digito:= cn[pos];
end;


procedure init_c(naranja:TColorB);

var
  i,j:integer;
begin
  for i:= 0 to 1 do
    begin
      for j:= 0 to 1 do
        DrawCircle(cx[i], cy[j], 11.5, naranja)
end;
end;

procedure colorear(cn:cronos;s:Aseg;naranja:TColorB;vf:OnOff);
var
  i,j,dig:integer;
  auxc:TColorB;
begin
  for i:= 0 to 5 do
    for j:= 0 to 6 do
      begin
        dig:=digito(cn,i);
        if vf[dig,j] then
          auxc:=naranja
        else
          auxc:=ColorContrast(black, -0.09);

      DrawRectangleRounded(s[i,j],0.9,6,auxc);
    end;
end;
var
  s:Aseg;
  naranja:TColorB;
  cron:cronos;
  vf:OnOff;
  seg:longint;
  io: boolean;
begin
  naranja.r:=250;
  naranja.g:=0;
  naranja.b:=0;
  naranja.a:=255;
  init_s(s);
  bb(vf);
  init_cn(cron);
  SetTargetFps(60);
  seg:=1;
  io:= true;
  InitWindow(ancho,alto,'Segmentos');

  while not WindowShouldClose() do
    begin
      seg:= seg + 1;
      BeginDrawing();
      ClearBackground(black);
      colorear(cron,s,naranja,vf);
      if seg = 60 then
        begin
        corre(cron);
        if io then
          begin
            init_c(naranja);
            io:= false
          end
          else
            begin
              init_c(ColorContrast(black, -0.09));
              io:= true;
            end;
        seg:= 0;
      end;
      EndDrawing();
    end;
    CloseWindow();
  end.
