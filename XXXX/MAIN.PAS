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
	xxDrw('Для вызова справки ' + def_help, true);
	xxDrwL(' : ', 1, false);
	readln(c);


	{СПРАВКА}
	itr := POS(def_help, c);
	if (itr <> 0) then
	begin
		ClrScr;
		xxDrw('Справка', true);
		xxDrwL('-fo value     -- открыть файл',2, true);
		xxDrwL('-fc value     -- создать и открыть файл',2, true);
		xxDrwL('-a name age   -- добавить запись в файл',2, true);
		xxDrwL('-l            -- отобразить записи в файле',2, true);
		xxDrwL('-s            -- сохранить файл',2, true);
		xxDrwL('-exit         -- закрыть/выйти',2, false);
		readln;
		ClrScr;
		goto lbl_start;
	end;



	{СОЗДАНИЕ}
	itr := POS(def_f_create, c);
	if (itr <> 0) then
	begin
		xxDrwL('Создание файла', 1 ,true);
		Delete(c,itr,Length(def_f_create));
		Trim(c);
		if (Length(c) <= 0) then
		begin
			xxDrwL('Ошибка ввода', 2, true);
			fc := false;
			goto lbl_start;
		end;
		xxDrwL('Файл ' + c + ' создан', 2, true);

		if fc then close(f);
		Assign(f,c);
		Rewrite(f);
		fc := true;

		goto lbl_start;
	end;


	{ОТКРЫТИЕ}
	itr := POS(def_f_open, c);
	if (itr <> 0) then
	begin
		xxDrwL('Открытие файла', 1 ,true);
		Delete(c,itr,Length(def_f_open));
		Trim(c);
		if (Length(c) <= 0) then
		begin
			xxDrwL('Ошибка ввода', 2, true);
			fc := false;
			goto lbl_start;
		end;

		if fc then close(f);
		Assign(f,c);
		if xxIsFileExist(f) then
		begin
			fc := true;
			xxDrwL('Файл ' + c + ' открыт', 2, true);
		end else
		begin
			fc := false;
			xxDrwL('Файл ' + c + ' не удалось открыть', 2, true);
		end;

		goto lbl_start;
	end;


	{ДОБАВЛЕНИЕ}
	itr := POS(def_add, c);
	if (itr <> 0) then
	begin
		if (not fc) then
		begin
			xxDrwL('ФАЙЛ Не открыт', 1 ,true);
			goto lbl_start;
		end;
		xxDrwL('Добавление записи', 1 ,true);
		Delete(c,itr,Length(def_add));

		Trim(c);
		c1 := copy(c, 1, POS(' ', c));
		c2 := copy(c, POS(' ', c), Length(c));
		Trim(c1);
		Trim(c2);

		if (Length(c1) <= 0) then
		begin
			xxDrwL('Ошибка ввода', 2, true);
			fc := false;
			goto lbl_start;
		end;

		INC(l.SIZE);
		val(c2,l.DATA[l.SIZE].age, itr1);
		l.DATA[l.SIZE].name := c1;

		xxDrwL('Запись добавлена', 2, true);
		goto lbl_start;
	end;


	{СПИСОК}
	itr := POS(def_list, c);
	if (itr <> 0) then
	begin
		if (not fc) then
		begin
			xxDrwL('ФАЙЛ Не открыт', 1 ,true);
			goto lbl_start;
		end;

		xxDrw('-                       -',true);
		xxDrwL('Список записей', 1 ,true);
		for itr := 1 to l.SIZE do
		begin
			Str(L.DATA[itr].AGE, c1);
			xxDrw('-                       -',true);
			xxDrwL('ИМЯ:     '+L.DATA[itr].NAME, 2 ,true);
			xxDrwL('ВОЗРАСТ: '+c1, 2 ,true);
		end;
		goto lbl_start;
	end;



	{СОХРАНИТЬ}
	itr := POS(def_save, c);
	if (itr <> 0) then
	begin
		if (not fc) then
		begin
			xxDrwL('ФАЙЛ Не открыт', 1 ,true);
			goto lbl_start;
		end;

		xxDrwL('Изменения сохранены', 2, true);
		Rewrite(f);
		for itr := 1 to l.SIZE do
		begin
			write(f,l.DATA[itr]);
		end;
		goto lbl_start;
	end;

	{Выход}
	itr := POS(def_exit, c);
	if (itr <> 0) then
		goto lbl_end
	else goto lbl_start;
	lbl_end:
end.