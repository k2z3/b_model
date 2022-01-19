## Копирование данных куба

Копирование данных внутри куба, в том числе через текстовый файл.

### Что нужно сделать, чтобы перенести функционал копирования в свою модель?

1.  Остановить модель
2.  Скопировать файлы необходимых процессов в основную папку данных модели (/data/):
    - [[}b.cube.data.clear]]
    - [}b.cube.view.create.pro](/wiki/}b.cube.view.create)
    - [}b.hier.sub.create.pro](/wiki/}b.hier.sub.create)
    - [}b.hier.sub.exclude.pro](/wiki/}b.hier.sub.exclude)
    - [}b.hier.sub.create.bymdx.pro](/wiki/}b.hier.sub.create.bymdx)
    - [}b.cube.data.export.pro](/wiki/}b.cube.data.export)
    - [}b.cube.data.copy.pro](/wiki/}b.cube.data.copy)
3.  (необяз.) Отредактировать файл }b.cube.data.copy.pro, раздел «File location for indirect data copy » (если будет использоваться экспорт через файл). Проставить разделитель, кавычки, папку хранения csv файлов.
4.  Запустить модель
5.  Протестировать на тестовых данных:
    - Запустить процесс копирования с версии на версию с использованием фильтра
