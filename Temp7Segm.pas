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
  raylib,dos,SysUtils;

const
  alto = 600;
  ancho = 800;
  segV = ancho*0.06;
  segH = alto*0.026;
  nums: array[0..9] of integer =
  (126,48,109,121,51,91,95,112,127,123);
  cx: array [0..1] of integer = (340,660);
  cy: array[0..1] of integer = (413,368);
  
  {0 = x = 340, y = 413
  1 = x 340, y = 368;
  2 = x 660, y 413;
  3 = x 660, y 368;
  }
{
0 = 1111110
1 = 0110000
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
  s.x:= ancho/2 -((segH*2)*5.5+(segV*4)) - segH/2;
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
  s.x := s.x + segV + segH*4;
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
var
  aux:integer;
  wh,wm,ws,wms:word;

procedure temp(var s,aoa:longint);
begin
  if ParamCount > 0 then begin
    s:= StrToInt(ParamStr(1));
    aoa:= KEY_T;
  end;
end;

procedure corre(var cn:cronos;var s,aoa:longint);
 
var
  h,m,ps:integer;
begin
    h:= s div 3600;
    m:= s mod 3600 div 60;
    ps:=s mod 3600 mod 60;
    cn[0]:= h div 10;
    cn[1]:= h mod 10;
    cn[2]:= m div 10;
    cn[3]:= m mod 10;
    cn[4]:= ps div 10;
    cn[5]:= ps mod 10;
end;

procedure current_t(var cn:cronos);
begin
  DecodeTime(Time,wh,wm,ws,wms);
  cn[0]:= wh div 10;
  cn[1]:= wh mod 10;
  cn[2]:= wm div 10;
  cn[3]:= wm mod 10;
  cn[4]:= ws div 10;
  cn[5]:= ws mod 10;

end;

procedure ctr(var cn:cronos;var s:longint;var aoa:integer;var seg:longint);
begin
  if IsKeyPressed(KEY_SPACE)then
    aux:= KEY_SPACE;
  if aux = KEY_SPACE then
    seg:= seg + 1;
  if(aoa = KEY_C) then begin
    if seg = 60 then begin
      s:= s + 1;  
      seg:= 0;
  end;
    corre(cn,s,aoa);
  end;
  if aoa = KEY_T then begin
    if seg = 60 then begin
      s:= s - 1;
      seg:= 0;
    end;
    corre(cn,s,aoa)
  end;
  if aoa = KEY_H then 
    current_t(cn);
  if IsKeyPressed(KEY_H) then begin
    aoa:= KEY_H;
    aux:= 0;
  end;
  if IsKeyPressed(KEY_C)then begin
    s:= 0;
    aoa:= KEY_C;
  end;
      
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
          auxc:=ColorContrast(GetColor($181818), -0.7);

      DrawRectangleRounded(s[i,j],0.9,6,auxc);
    end;
end;
var
  s:Aseg;
  naranja,n2:TColorB;
  cron:cronos;
  vf:OnOff;
  seg,ss:longint;
  io: boolean;
  aoa:integer;
begin
  naranja.r:=250;
  naranja.g:=0;
  naranja.b:=0;
  naranja.a:=255;
  n2:= naranja;
  ss:= 0;
  init_s(s);
  bb(vf);
  SetTargetFps(60);
  seg:=0;
  aoa:= KEY_C;
  corre(cron,ss,aoa);
  temp(ss,aoa);
  io:= true;
  InitWindow(ancho,alto,'Segmentos');

  while not WindowShouldClose() do
    begin
      BeginDrawing();
      ClearBackground(GetColor($181818));
      colorear(cron,s,naranja,vf);
      ctr(cron,ss,aoa,seg);
      //init_c(n2);
      if seg >= 59 then
        begin
        if io then
          begin
            n2:= naranja;
            io:= false
          end
          else
            begin
              n2 := ColorContrast(GetColor($181818), -0.7);
              io:= true;
            end;
      end;
      EndDrawing();
    end;
    CloseWindow();
  end.
