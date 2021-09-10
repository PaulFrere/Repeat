package multithreading;

import java.util.concurrent.locks.ReentrantLock;

public class Counter {
    private volatile int i;
    private final ReentrantLock lock;

    public Counter() {
        this.lock = new ReentrantLock();
    }

    public void increase() {
        lock.lock();
        i++;
        lock.unlock();
    }

    public int getCounter() {
        return i;
    }
}
