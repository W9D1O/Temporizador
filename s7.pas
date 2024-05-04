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
  crt,raylib;

const
  pixel = 20;
  cont = 40;
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

procedure init_s(var s:Aseg); // Esto es un desastre!!!

begin
// Init A
  s[0,0].x:=60;
  s[0,0].y:=pixel*cont div 2 - 140;
  s[0,0].width:=80;
  s[0,0].height:=20;
  // [0]It B
  s[0,1].x:= 140;
  s[0,1].y:=440 -160;
  s[0,1].width:=20;
  s[0,1].height:=100;
  // [0]Init C
  s[0,2].x:= 140;
  s[0,2].y:=560 - 160;
  s[0,2].width:=20;
  s[0,2].height:=100;
// [0]It D        
  s[0,3].x:=60;
  s[0,3].y:=660 - 160;
  s[0,3].width:=80;
  s[0,3].height:=20;
  //I[0]n E
  s[0,4].x:= 40;
  s[0,4].y:=560 -160;
  s[0,4].width:=20;
  s[0,4].height:=100;
  //I[0]n F
  s[0,5].x:= 40;
  s[0,5].y:=440 -160;
  s[0,5].width:=20;
  s[0,5].height:=100;
// [0]It G
  s[0,6].x:=60;
  s[0,6].y:=540 - 160;
  s[0,6].width:=80;
  s[0,6].height:=20;
// Init A
  s[1,0].x:=60 + 160;
  s[1,0].y:=pixel*cont div 2 - 140;
  s[1,0].width:=80;
  s[1,0].height:=20;
// [1]t D        
  s[1,3].x:=60 + 160;
  s[1,3].y:=660 - 160;
  s[1,3].width:=80;
  s[1,3].height:=20;
// [1]t G
  s[1,6].x:=60 + 160;
  s[1,6].y:=540 - 160;
  s[1,6].width:=80;
  s[1,6].height:=20;
// [1]t B
  s[1,1].x:= 140 + 160;
  s[1,1].y:=440 -160;
  s[1,1].width:=20;
  s[1,1].height:=100;
// [1]nit C
  
  s[1,2].x:= 140 + 160;
  s[1,2].y:=560 - 160;
  s[1,2].width:=20;
  s[1,2].height:=100;
//I[1] E
  s[1,4].x:= 40 +160;
  s[1,4].y:=560 -160;
  s[1,4].width:=20;
  s[1,4].height:=100;
//I[1] F
  s[1,5].x:= 40 +160;
  s[1,5].y:=440 -160;
  s[1,5].width:=20;
  s[1,5].height:=100;
// It A
  s[2,0].x:=60 + 320;
  s[2,0].y:=pixel*cont div 2 - 140;
  s[2,0].width:=80;
  s[2,0].height:=20;
// [2]t D        
  s[2,3].x:=60 + 320;
  s[2,3].y:=660 - 160;
  s[2,3].width:=80;
  s[2,3].height:=20;
// [2]t G
  s[2,6].x:=60 + 320;
  s[2,6].y:=540 - 160;
  s[2,6].width:=80;
  s[2,6].height:=20;
// [2]t B
  s[2,1].x:= 140 + 320;
  s[2,1].y:=440 -160;
  s[2,1].width:=20;
  s[2,1].height:=100;
// [2]t C
  
  s[2,2].x:= 140 + 320;
  s[2,2].y:=560 - 160;
  s[2,2].width:=20;
  s[2,2].height:=100;
//I[2] E
  s[2,4].x:= 40 + 320;
  s[2,4].y:=560 -160;
  s[2,4].width:=20;
  s[2,4].height:=100;
//I[2] F
  s[2,5].x:= 40 + 320;
  s[2,5].y:=440 -160;
  s[2,5].width:=20;
  s[2,5].height:=100;

// It A
  s[3,0].x:=60 + 480;
  s[3,0].y:=pixel*cont div 2 - 140;
  s[3,0].width:=80;
  s[3,0].height:=20;
// [3]t D        
  s[3,3].x:=60 + 480;
  s[3,3].y:=660 - 160;
  s[3,3].width:=80;
  s[3,3].height:=20;
// [3]t G
  s[3,6].x:=60 + 480;
  s[3,6].y:=540 - 160;
  s[3,6].width:=80;
  s[3,6].height:=20;
// [3]t B
  s[3,1].x:= 140 + 480;
  s[3,1].y:=440 -160;
  s[3,1].width:=20;
  s[3,1].height:=100;
// [3]t C
  
  s[3,2].x:= 140 + 480;
  s[3,2].y:=560 - 160;
  s[3,2].width:=20;
  s[3,2].height:=100;
//I[3] E
  s[3,4].x:= 40 + 480;
  s[3,4].y:=560 -160;
  s[3,4].width:=20;
  s[3,4].height:=100;
//I[3] F
  s[3,5].x:= 40 + 480;
  s[3,5].y:=440 -160;
  s[3,5].width:=20;
  s[3,5].height:=100;
// It A
  s[4,0].x:=60 + 640;
  s[4,0].y:=pixel*cont div 2 - 140;
  s[4,0].width:=80;
  s[4,0].height:=20;
// [4]t D        
  s[4,3].x:=60 + 640;
  s[4,3].y:=660 - 160;
  s[4,3].width:=80;
  s[4,3].height:=20;
// [4]t G
  s[4,6].x:=60 + 640;
  s[4,6].y:=540 - 160;
  s[4,6].width:=80;
  s[4,6].height:=20;
// [4]t B
  s[4,1].x:= 140 + 640;
  s[4,1].y:=440 -160;
  s[4,1].width:=20;
  s[4,1].height:=100;
// [4]t C
  
  s[4,2].x:= 140 + 640;
  s[4,2].y:=560 - 160;
  s[4,2].width:=20;
  s[4,2].height:=100;
//I[4] E
  s[4,4].x:= 40 + 640;
  s[4,4].y:=560 -160;
  s[4,4].width:=20;
  s[4,4].height:=100;
//I[4] F
  s[4,5].x:= 40 + 640;
  s[4,5].y:=440 -160;
  s[4,5].width:=20;
  s[4,5].height:=100;
// It A
  s[5,0].x:=60 + 800;
  s[5,0].y:=pixel*cont div 2 - 140;
  s[5,0].width:=80;
  s[5,0].height:=20;
// [5]t D        
  s[5,3].x:=60 + 800;
  s[5,3].y:=660 - 160;
  s[5,3].width:=80;
  s[5,3].height:=20;
// [5]t G
  s[5,6].x:=60 + 800;
  s[5,6].y:=540 - 160;
  s[5,6].width:=80;
  s[5,6].height:=20;
// [5]t B
  s[5,1].x:= 140 + 800;
  s[5,1].y:=440 -160;
  s[5,1].width:=20;
  s[5,1].height:=100;
// [5]t C
  
  s[5,2].x:= 140 + 800;
  s[5,2].y:=560 - 160;
  s[5,2].width:=20;
  s[5,2].height:=100;
//I[5] E
  s[5,4].x:= 40 + 800;
  s[5,4].y:=560 -160;
  s[5,4].width:=20;
  s[5,4].height:=100;
//I[5] F
  s[5,5].x:= 40 + 800;
  s[5,5].y:=440 -160;
  s[5,5].width:=20;
  s[5,5].height:=100;
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
  seg:real;
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
  InitWindow(pixel*cont + 200,pixel * cont,'Segmentos');

  while not WindowShouldClose() do
    begin
      seg:= seg + GetFrameTime();
      BeginDrawing();
      if seg >= 1 then
        begin
        corre(cron);
        colorear(cron,s,naranja,vf);
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
        seg:= 0.0;
      end;
      EndDrawing();
    end;
    CloseWindow();
  end.
