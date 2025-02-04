{##############################################################}
{--------------------------------------------------------------}
unit XXXX;
{--------------------------------------------------------------}
interface {  ���� ��������  }
uses Crt; {��� ClrScr}
const
	DEF_LINE        = '##############################';
	DEF_LINE_SIZE   = 50;
	DEF_SYMBOL_DM   = '-';
	DEF_MAX_ARRAY   = 100;
	DEF_MAX_NAME    = 45;

{--------------------------------------------------------------}
{
	���ᠭ�� ⨯� � ���� ���ﬨ
}
type xxxt_r_p = record
	age:integer;
	name:string[DEF_MAX_NAME];
end;

{
	���ᠭ�� ⨯���஢������ 䠩��
}
type xxxt_f_p = file of xxxt_r_p;

{
	���ᠭ� ���ᨢ�
}
type xxxt_a_p = array[1..DEF_MAX_ARRAY] of xxxt_r_p;
{
	���ᠭ�� �������� ᮤ�ঠ饩
	���ᨢ � ��� ࠧ���
}
type xxxt_l_p = record
	DATA:xxxt_a_p;
	SIZE:Integer;
end;

{--------------------------------------------------------------}
{
	���ᠭ�� ��楤�� - �㭪権;
}

	{
	 #--- xxDrw
		����� 䨪�஢����� ����� � ⥪�⮬
		buffer 	- ⥪��
		iswrtln - ��७���� �� �� ����� ��ப�

	 #--- xxDrwL
		����� ��ப� � ��।������ ����㯮�
		buffer - ⥪��
		lvl - �஢���
		iswrtln - ��७���� �� �� ����� ��ப�
	}
	procedure xxDrw(buffer:string; iswrtln:boolean);
	procedure xxDrwL(buffer:string; lvl:integer; iswrtln:boolean);

	{
	 #--- xxReadFile
	 ��⠥� 䠩� � �����뢠�� � ���ᨢ
	 f_handle - ᠬ 䠩�, ���ਯ�� 䠩��
	 return: ��������� ����

	 #--- xxWriteFile
	 �����뢠�� ���ᨢ � 䠩�
	}
	procedure xxReadFile(var f_handle:xxxt_f_p; list:xxxt_l_p);
	procedure xxWriteFile(var f_handle:xxxt_f_p; list:xxxt_l_p);
	{

	}
	function xxIsFileExist(var f_handle:xxxt_f_p): boolean;

{--------------------------------------------------------------}
{���� ����������}
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
{������������� ��� ������}
begin
	ClrScr;
end.