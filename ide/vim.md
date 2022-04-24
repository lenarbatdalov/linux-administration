#	
```
i - вход в режим редактирования слева (esc - выход)
a - редактирование, но перемещает курсор вправо
o - вход в реж.ред. с новой строки ниже текущей
O - вход в реж.ред. с новой строки выше текущей
A - переводит курсор в конец строки

gg - переход в начало файла
G - переход в конец файла
w - переместиться на следующее слово (5w - выполнить w пять раз)
b - на слово назад
e - переместиться в конец слова

f - перейти к символу в данной строке (f3)
/ - найти символ или слово вниз от курсора (enter применить) (555->enter)
? - найти вверх от текущей стоки

h j k l - перемещение курсора
```

#	механизм закладок
```
для этого есть клавиша m (в командном режиме на строке вводим m, а потом x)
далее если в командном набрать 'x то попадаем на маркированную строку
```

#	командный режим
```
dw - удалить слово
D - от текущего положения курсора до конца строки
dd - удалить всю строку (2dd - удалить 2 строки)
u - отменить
cw - заменить слово (С - до конца строки)
V - выделить, регулируется стрелками
```

#	визуальный режим (v)
```
стрелками выделение
x - вырезать (p P - вставить слева и справа от курсора)
d - удалить текст
```

#	макросы
```
в командном режиме q1
далее в разных режимах проделываем необходимые повторяющиеся действия
и заканчивыем запись макроса в командном q

вызов макроса @1  или 50@1 чтобы выполнить 50 раз
```
