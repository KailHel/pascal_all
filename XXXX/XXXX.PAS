{##############################################################}
{--------------------------------------------------------------}
unit XXXX;
{--------------------------------------------------------------}
interface {  БЛОК ОПИСАНИЯ  }
uses Crt; {Для ClrScr}
const
	DEF_LINE        = '##############################';
	DEF_LINE_SIZE   = 50;
	DEF_SYMBOL_DM   = '-';
	DEF_MAX_ARRAY   = 100;
	DEF_MAX_NAME    = 45;

{--------------------------------------------------------------}
{
	Описания типа с двумя полями
}
type xxxt_r_p = record
	age:integer;
	name:string[DEF_MAX_NAME];
end;

{
	Описание типизированного файла
}
type xxxt_f_p = file of xxxt_r_p;

{
	Описани массива
}
type xxxt_a_p = array[1..DEF_MAX_ARRAY] of xxxt_r_p;
{
	Описание структуры содержащей
	массив и его размер
}
type xxxt_l_p = record
	DATA:xxxt_a_p;
	SIZE:Integer;
end;

{--------------------------------------------------------------}
{
	Описание процедур - функций;
}

	{
	 #--- xxDrw
		Рисует фиксированную линий с текстом
		buffer 	- текст
		iswrtln - переносить ли на новую строку

	 #--- xxDrwL
		Рисует строку с определенным отступом
		buffer - текст
		lvl - уровень
		iswrtln - переносить ли на новую строку
	}
	procedure xxDrw(buffer:string; iswrtln:boolean);
	procedure xxDrwL(buffer:string; lvl:integer; iswrtln:boolean);

	{
	 #--- xxReadFile
	 Читает файл и записывает в массив
	 f_handle - сам файл, дискриптор файла
	 return: заполненый лист

	 #--- xxWriteFile
	 Записывает массив в файл
	}
	procedure xxReadFile(var f_handle:xxxt_f_p; list:xxxt_l_p);
	procedure xxWriteFile(var f_handle:xxxt_f_p; list:xxxt_l_p);
	{

	}
	function xxIsFileExist(var f_handle:xxxt_f_p): boolean;

{--------------------------------------------------------------}
{БЛОК РЕАЛИЗАЦИИ}
implementation
{--------------------------------------------------------------}
procedure xxDrw(buffer:string; iswrtln:boolean);
var {iterator , part size}
	 i, d_size:integer;
begin
	 {calculate delimiter size}
	 d_size := DEF_LINE_SIZE - Length(buffer);

	 {get first part size}
	 i := ROUND(d_size / 2);
	 while (i > 0) do {draw first line part}
	 begin
			write('#');
			dec(i);
	 end;

	 {draw string}
	 write(' '+buffer+' ');

	 {get first part size}
	 i := ROUND(d_size / 2);
	 while (i > 0) do {draw last line part}
	 begin
			write('#');
			dec(i);
	 end;

	 if iswrtln then writeln;
end;


{--------------------------------------------------------------}
procedure xxDrwL(buffer:string; lvl:integer; iswrtln:boolean);
var
	 i:integer;
begin
	 write('###');
	 i := lvl;
	 while (i > 0) do {draw first line part}
	 begin
			write('-');
			dec(i);
	 end;

	 if iswrtln then writeln(' ' + buffer)
	 else write(' ' + buffer);
end;


{--------------------------------------------------------------}
procedure xxReadFile(var f_handle:xxxt_f_p; list:xxxt_l_p);
begin
	reset(f_handle);
	list.SIZE := 0;
	while(not eof(f_handle)) do
	begin
		INC(list.SIZE);
		read(f_handle, list.DATA[list.SIZE])
	end;
end;


{--------------------------------------------------------------}
procedure xxWriteFile(var f_handle:xxxt_f_p; list:xxxt_l_p);
var
	i:integer;
begin
	rewrite(f_handle);
	for i:=1 to list.SIZE do
	begin
		write(f_handle, list.DATA[i]);
	end;
end;


{--------------------------------------------------------------}
function xxIsFileExist(var f_handle:xxxt_f_p): boolean;
 begin
	{$I-}
	reset(f_handle);
	{$I+}

	if IOResult = 0 then xxIsFileExist := true
	else xxIsFileExist := false;
end;
{--------------------------------------------------------------}
{ИНИЦИАЛИЗАЦИЯ ПРИ СТАРТЕ}
begin
	ClrScr;
end.