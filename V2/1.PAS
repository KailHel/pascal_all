const
	def_x_size = 3;
	def_y_size = 4;
var
	mat: array[1..def_x_size, 1..def_y_size] of integer;
	x,sum:integer;
	
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
	}
	{
		Примерно так выглядит массив
		{ 1 , 2 , 3 },
		{ 4 , 5 , 6 },
		{ x , 8 , 9 }	
		
		Чтобы достать x надо обратиться к эллементу MAT[3, 1] -  MAT[y, x] - из этого видно, что  x и y перепутанны при печати двумя for 
		Порядок прохождения по матрице
	
		01 02 03  (i:1 j:1) (i:1 j:2) (i:1 j:3)
		04 05 06  (i:2 j:1) ... и тд
		07 08 09 
		10 11 12
	
	}
	
	sum := 0;
	for x:=1 to def_x_size do
	begin
		if(MAT[3, x] < 0) then sum := sum - MAT[3, x]
	end;
	
	
	
	
	{
		...
		Вывели
		...
	}
end.