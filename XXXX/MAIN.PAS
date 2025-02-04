uses XXXX, Crt;

procedure Trim(Var s:string);
begin
	while(s[1]=' ') or (s[Length(s)]=' ') do
		if s[1] = ' ' then Delete(s, 1, 1)
		else Delete(s, Length(s), 1);
end;

var
	f:xxxt_f_p;
	l:xxxt_l_p;
	c,c1,c2:string;
	fc:boolean;
	itr,itr1:integer;
label
	lbl_start, lbl_end;
const
	def_help 		 = '-help';
	def_f_open   = '-fo';
	def_f_create = '-fc';
	def_add			 = '-a';
	def_list		 = '-l';
	def_save		 = '-s';
	def_exit		 = '-exit';
begin
	fc := false;

	lbl_start:
	xxDrw('��� �맮�� �ࠢ�� ' + def_help, true);
	xxDrwL(' : ', 1, false);
	readln(c);


	{�������}
	itr := POS(def_help, c);
	if (itr <> 0) then
	begin
		ClrScr;
		xxDrw('��ࠢ��', true);
		xxDrwL('-fo value     -- ������ 䠩�',2, true);
		xxDrwL('-fc value     -- ᮧ���� � ������ 䠩�',2, true);
		xxDrwL('-a name age   -- �������� ������ � 䠩�',2, true);
		xxDrwL('-l            -- �⮡ࠧ��� ����� � 䠩��',2, true);
		xxDrwL('-s            -- ��࠭��� 䠩�',2, true);
		xxDrwL('-exit         -- �������/���',2, false);
		readln;
		ClrScr;
		goto lbl_start;
	end;



	{��������}
	itr := POS(def_f_create, c);
	if (itr <> 0) then
	begin
		xxDrwL('�������� 䠩��', 1 ,true);
		Delete(c,itr,Length(def_f_create));
		Trim(c);
		if (Length(c) <= 0) then
		begin
			xxDrwL('�訡�� �����', 2, true);
			fc := false;
			goto lbl_start;
		end;
		xxDrwL('���� ' + c + ' ᮧ���', 2, true);

		if fc then close(f);
		Assign(f,c);
		Rewrite(f);
		fc := true;

		goto lbl_start;
	end;


	{��������}
	itr := POS(def_f_open, c);
	if (itr <> 0) then
	begin
		xxDrwL('����⨥ 䠩��', 1 ,true);
		Delete(c,itr,Length(def_f_open));
		Trim(c);
		if (Length(c) <= 0) then
		begin
			xxDrwL('�訡�� �����', 2, true);
			fc := false;
			goto lbl_start;
		end;

		if fc then close(f);
		Assign(f,c);
		if xxIsFileExist(f) then
		begin
			fc := true;
			xxDrwL('���� ' + c + ' �����', 2, true);
		end else
		begin
			fc := false;
			xxDrwL('���� ' + c + ' �� 㤠���� ������', 2, true);
		end;

		goto lbl_start;
	end;


	{����������}
	itr := POS(def_add, c);
	if (itr <> 0) then
	begin
		if (not fc) then
		begin
			xxDrwL('���� �� �����', 1 ,true);
			goto lbl_start;
		end;
		xxDrwL('���������� �����', 1 ,true);
		Delete(c,itr,Length(def_add));

		Trim(c);
		c1 := copy(c, 1, POS(' ', c));
		c2 := copy(c, POS(' ', c), Length(c));
		Trim(c1);
		Trim(c2);

		if (Length(c1) <= 0) then
		begin
			xxDrwL('�訡�� �����', 2, true);
			fc := false;
			goto lbl_start;
		end;

		INC(l.SIZE);
		val(c2,l.DATA[l.SIZE].age, itr1);
		l.DATA[l.SIZE].name := c1;

		xxDrwL('������ ���������', 2, true);
		goto lbl_start;
	end;


	{������}
	itr := POS(def_list, c);
	if (itr <> 0) then
	begin
		if (not fc) then
		begin
			xxDrwL('���� �� �����', 1 ,true);
			goto lbl_start;
		end;

		xxDrw('-                       -',true);
		xxDrwL('���᮪ ����ᥩ', 1 ,true);
		for itr := 1 to l.SIZE do
		begin
			Str(L.DATA[itr].AGE, c1);
			xxDrw('-                       -',true);
			xxDrwL('���:     '+L.DATA[itr].NAME, 2 ,true);
			xxDrwL('�������: '+c1, 2 ,true);
		end;
		goto lbl_start;
	end;



	{���������}
	itr := POS(def_save, c);
	if (itr <> 0) then
	begin
		if (not fc) then
		begin
			xxDrwL('���� �� �����', 1 ,true);
			goto lbl_start;
		end;

		xxDrwL('��������� ��࠭���', 2, true);
		Rewrite(f);
		for itr := 1 to l.SIZE do
		begin
			write(f,l.DATA[itr]);
		end;
		goto lbl_start;
	end;

	{��室}
	itr := POS(def_exit, c);
	if (itr <> 0) then
		goto lbl_end
	else goto lbl_start;
	lbl_end:
end.