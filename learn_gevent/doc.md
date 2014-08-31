文档
=============

搞明白monkey patch的作用?

    gevent能够 修改标准库里面大部分的阻塞式系统调用，包括socket、ssl、threading和 select等模块，而变为协作式运行

异步执行

    threads = [gevent.spawn(task, i) for i in xrange(10)]
    gevent.joinall(threads)

创建和执行一个greenlet

    # Initialize a new Greenlet instance running the named function
    # foo
    thread1 = Greenlet.spawn(foo, "Hello", 1)

    # Wrapper for creating and running a new Greenlet from the named
    # function foo, with the passed arguments
    thread2 = gevent.spawn(foo, "I live!", 2)

    # Lambda expressions
    thread3 = gevent.spawn(lambda x: (x+1), 2)

    threads = [thread1, thread2, thread3]

    gevent.joinall(threads)

greenlet状态

        started -- Boolean, 指示此Greenlet是否已经启动
        ready() -- Boolean, 指示此Greenlet是否已经停止
        successful() -- Boolean, 指示此Greenlet是否已经停止而且没抛异常
        value -- 任意值, 此Greenlet代码返回的值
        exception -- 异常, 此Greenlet内抛出的未捕获异常

    print(winner.started) # True

    gevent.joinall([winner, ])

    print(winner.value) # 'You win!'

    print(winner.ready()) # True

    print(winner.successful()) # True

    print(loser.exception)

## gevent

### gevent.sleep(seconds=0, ref=True)

Put the current greenlet to sleep for at least seconds.

seconds may be specified as an integer, or a float if fractional seconds are desired.

If ref is false, the greenlet running sleep() will not prevent gevent.wait() from exiting.

    gevent.sleep(0)

---------------

### gevent.spawn(function, *args, **kwargs)

Create a new Greenlet object and schedule it to run function(*args, **kwargs). This is an alias for Greenlet.spawn().

    >>> g = Greenlet.spawn(myfunction, 'arg1', 'arg2', kwarg1=1)

    def foo(): pass

    gevent.spawn(foo),

-----------

### gevent.joinall(greenlets, timeout=None, raise_error=False, count=None)

作用?

    gevent.joinall([
        gevent.spawn(foo),
        gevent.spawn(bar),
    ])


----------------------------

# gevent.select

### gevent.select.select(rlist, wlist, xlist, timeout=None)

An implementation of select.select() that blocks only the current greenlet.

Note: xlist is ignored.


--------------------------

# gevent.monkey

Make the standard library cooperative
最赞的是提供了一个monkey类，可以将现有基于Python线程直接转化为greenlet，相当于proxy了一下

在这种情况下，gevent能够 修改标准库里面大部分的阻塞式系统调用，包括socket、ssl、threading和 select等模块，而变为协作式运行

阻塞 -> 非阻塞?

    from gevent import monkey

    monkey.patch_socket()

    monkey.patch_select()

    gevent.monkey.patch_all()

### gevent.monkey.patch_socket(dns=True, aggressive=True)

Replace the standard socket object with gevent’s cooperative sockets.

If dns is true, also patch dns functions in socket.

 纯粹副作用命令是用来改变标准socket库的



--------------------------

# gevent.pool

Managing greenlets in a group

# class gevent.pool.Pool(size=None, greenlet_class=None)

        wait_available()¶
        full()
        free_count()
        add(greenlet)

The Pool which a subclass of Group provides a way to limit concurrency:

its spawn method blocks if the number of greenlets in the pool has already reached the limit, until there is a free slot.

    e.g.

    from gevent.pool import Pool

    p = Pool(10)

    run1 = [a for a in p.imap_unordered(echo, xrange(10))]

    from gevent.pool import Pool
    pool = Pool(1000)

    pool.full()
    pool.spawn(self.listen, socket)
    pool.kill()



----------------------------


# gevent.timeout

Raise exception in the current greenlet after given time period

    from gevent import Timeout

    seconds = 10

    timeout = Timeout(seconds)
    timeout.start()

    def wait():
        gevent.sleep(10)

    try:
        gevent.spawn(wait).join()
    except Timeout:
        print('Could not complete')
    finally:
        timeout.cancel()

还可以用with处理timeout

    time_to_wait = 5 # seconds

    class TooLong(Exception):
        pass

    with Timeout(time_to_wait, TooLong):
        gevent.sleep(10)

相关其他方法

    timer = Timeout(1).start()
    thread1 = gevent.spawn(wait)

    try:
        thread1.join(timeout=timer)
    except Timeout:
        print('Thread 1 timed out')

    # --

    timer = Timeout.start_new(1)
    thread2 = gevent.spawn(wait)

    try:
        thread2.get(timeout=timer)
    except Timeout:
        print('Thread 2 timed out')

    # --

    try:
        gevent.with_timeout(1, wait)
    except Timeout:
        print('Thread 3 timed out')


---------------------------

# gevent.event

Notifications of multiple listeners


### Event

    from gevent.event import Event

    wait阻塞等待, 接到set信号后继续执行

    def setter():
    '''After 3 seconds, wake all threads waiting on the value of evt'''
        print('A: Hey wait for me, I have to do something')
        gevent.sleep(3)
        print("Ok, I'm done")
        evt.set()

    def waiter():
        '''After 3 seconds the get call will unblock'''
        print("I'll wait for you")
        # 阻塞
        evt.wait()  # blocking
        print("It's about time")

    def main():
        gevent.joinall([
            gevent.spawn(setter),
            gevent.spawn(waiter),
            gevent.spawn(waiter),
            gevent.spawn(waiter),
            gevent.spawn(waiter),
            gevent.spawn(waiter)
        ])



### gevent.event.AsyncResult

A one-time event that stores a value or an exception.

Like Event it wakes up all the waiters when set() or set_exception() method is called. Waiters may receive the passed value or exception by calling get() method instead of wait(). An AsyncResult instance cannot be reset.

To pass a value call set(). Calls to get() (those that currently blocking as well as those made in the future) will return the value:


    set/get
    get阻塞等待, set后激活get不等待

    a = AsyncResult()

    def setter():
        """
        After 3 seconds set the result of a.
        """
        gevent.sleep(3)
        a.set('Hello!')

    def waiter():
        """
        After 3 seconds the get call will unblock after the setter
        puts a value into the AsyncResult.
        """
        print(a.get())

    gevent.joinall([
        gevent.spawn(setter),
        gevent.spawn(waiter),
        gevent.spawn(waiter),
    ])

    // 注意, 只有一个信号量

-----------------------

# queue

    import gevent
    from gevent.queue import Queue

    tasks = Queue()

    def worker(n):
        while not tasks.empty(): //是否空
            task = tasks.get() //获取
            print('Worker %s got task %s' % (n, task))
            gevent.sleep(0)

        print('Quitting time!')

    def boss():
        for i in xrange(1,25):
            print "Boss put ", i
            tasks.put_nowait(i) //放入

    gevent.spawn(boss).join() //先启用生产者

    // 消费者
    gevent.joinall([
        gevent.spawn(worker, 'steve'),
        gevent.spawn(worker, 'john'),
        gevent.spawn(worker, 'nancy'),
    ])


阻塞队列

    tasks = Queue(maxsize=3)

    生产者消费者一起运行

    put和get操作都有非阻塞的版本，put_nowait和get_nowait不会阻塞

    put/get会因为队列空满而阻塞



-------------------

BoundedSemaphore


信号量

BoundedSemaphore

范围为1的信号量也称为锁(lock)。它向单个greenlet提供了互斥访问

    sem = BoundedSemaphore(2)
    sem.acquire()
    sem.release()

    or

    with sem:
        xxxx

------------------

# gevent.local


作用是什么? 意味着什么?

    from gevent.local import local

    stash = local()


--------------

# from gevent.subprocess import Popen, PIPE

gevent.subprocess，一个Python subprocess模块 的修补版本已经添加。它支持协作式的等待子进程



