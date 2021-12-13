const
	def_x_size = 5;
	def_y_size = 5;
var
	mat: array[1..def_x_size, 1..def_y_size] of integer;
	x,y,e:integer;
	
begin

	{
		...
		заполнили
		...
	}
	
	{
		...
		Вывели
		...
		
		{ 1 , 2 , 3 },
		{ 4 , 5 , 6 },
		{ x , 8 , 9 }	
	}
	
	{
		Читаем число  e
	}
	
	
	{
		4 задание с ебанной формулой 
		
		тут у нас будет несколько условий и от этого 
		будет зависить формула по которой мы вычисляем ячеку  MAT
	}
	
	
	{
		Тут единственное в результате деления будут дроби и все вылетет нахуй ругаясь на несовпадение типов 
		Надо поменять  int на float
	}
	for y:=1 to def_y_size do
	begin
		for x:=1 to def_x_size do
		begin
			if (x < y) then
			begin
				result = sin(x + 2);
			end else 
			begin
				result = y - 2 * x;
			end;
		end;	
	end;
	
	{
		Писал быстро, глянь на расположение x и y, скорее всего неверно
	}
	
	
	{
		...
		Вывели
		...
	}
end.