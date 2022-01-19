**Аннотация**

Данный набор «Копирование данных куба» содержит описание минимального протестированного функционала по копированию данных внутри куба, в том числе через текстовый файл.

### Шаги по переносу функционала в модель

1.  Остановить модель
2.  (необяз.) Создать папку main там же, где папка data. Добавить ее пусть в файл tm1s.cfg, изменив строчку DataBaseDirectory (DataBaseDirectory=data;main). На следующем шаге все процессы копировать в нее.
3.  Скопировать следующие файлы в папку данных модели:
    1.  [}b.cube.data.clear.pro](}b.cube.data.clear.pro)
    2.  [}b.cube.view.create.pro](}b.cube.view.create.pro)
    3.  [}b.hier.sub.create.pro](}b.hier.sub.create.pro)
    4.  [}b.hier.sub.exclude.pro](}b.hier.sub.exclude.pro)
    5.  [}b.hier.sub.create.bymdx.pro](}b.hier.sub.create.bymdx.pro)
    6.  [}b.cube.data.export.pro](}b.cube.data.export.pro)
    7.  [}b.cube.data.copy.pro](}b.cube.data.copy.pro)
4.  (необяз.) Отредактировать файл }b.cube.data.copy.pro, раздел «File location for indirect data copy » (если будет использоваться экспорт через файл). Проставить разделитель, кавычки, папку хранения csv файлов.
5.  Запустить модель
6.  Протестировать на тестовых данных:
    1.  Запустить процесс копирования с версии на версию с использованием фильтра
    2.  (необяз.) Запустить аналогичный процесс с параметром pFile = 2 и pFile = 1, проверить корректность переносимых данных
