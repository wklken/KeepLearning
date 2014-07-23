

go两个保留函数 无参数无返回值

init函数, 能够应用于所有package
main函数, 只能用于package main

一个package里允许任意多个init, 最佳实践是一个package中一个文件只写一个init

程序会自动调用init/main


    main

    import pkg1  ->    pkg1

                    import pkg2    ->   pkg2

                                        .....


                        ...          <-    init()

    ...          <-     init()

    init()
    main()
