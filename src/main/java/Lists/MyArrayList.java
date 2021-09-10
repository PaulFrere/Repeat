package Lists;

import java.util.Comparator;

public class MyArrayList<T extends Comparable<T>> {
    private T[] list;
    private int size;
    private final int CAPACITY = 100;
    private int capacity = 20;
    public int countLength;

    public MyArrayList(int capacity){
        if (capacity <= 0) {
            throw new IllegalArgumentException("capacity: " + capacity);
        }
        this.capacity = capacity;
        list = (T[]) new Comparable[capacity];
    }

    public void add(T item){
        list[size] = item;
        size++;
        if(Math.round((list.length) * 0.75) < size){
            addLength((int) Math.round((list.length)*1.25));
        }
    }
    public void addLength(int newLength){
        T[] tempArray = (T[]) new Comparable[newLength];
        for (int i = 0; i <= size; i++){
            tempArray[i] = list[i];
        }
        list = tempArray;
        countLength++;
    }
    private void chekIndex(int index){
        if(index < 0 && index >= size){
            throw new IllegalArgumentException("index: " + index);
        }
    }

    public void add(int index, T item){
        if (index < 0 && index > size){
            throw new IllegalArgumentException("index: " + index);
        }
        for(int i = size; i > index; i--){
            list[i] = list[i -  1];
        }
        list[index] = item;
        size++;
    }

    public final int indexOf(T item){
        for (int i = 0; i < size; i++){
            if(list[i].equals(item)){
                return i;
            }
        }
        return -1;
    }

    public void remove (int index){
        chekIndex(index);
        for(int i = index; i < size; i++){
            list[i] = list[i + 1];
        }
        size--;
        list[size] = null;
    }

    public boolean remove(T item){
        int k = indexOf(item);
        if(k == -1){
            return false;
        }
        remove(k);
        return true;
    }

    public T get(int index){
        chekIndex(index);
        return list[index];
    }

    public void set(int index, T item){
        chekIndex(index);
        list[index] = item;
    }
    public int size(){
        return size;
    }

    private boolean less(T item1, T item2){
        return item1.compareTo(item2) < 0;
    }

    private void swap(int index1, int index2){
        T temp = list[index1];
        list[index1] = list[index2];
        list[index2] = temp;
    }

    public void selectionSort() {
        int min;
        for(int i = 0; i < size - 1; i++){
            min = i;
            for(int j = i + 1; j < size; j++){
            if (less(list[j], list[min])){
                min = j;
            }

            }
            swap(i, min);
        }
    }
    public void selectionSort(Comparator<T> comparator){
        int min;
        double countPass = 0;
        double countMoving = 0;
        for (int i = 0; i < size - 1; i++){
            min = i;
            countPass++;
            for (int j = i + 1; j < size; j++){
                countPass++;
                if(comparator.compare(list[j], list[min]) < 0){
                    min = j;
                }
            }
            swap(i, min);
            countMoving++;
        }
        System.out.println("selectionSort countPass " + countPass);
        System.out.println("selectionSort countMoving " + countMoving);
    }

    public void insertionSort(){
        T key;
        double countPass = 0;
        double countMoving = 0;
        for(int i = 1; i < size; i++){
            int j = i;
            key = list[i];
            countPass++;
            while (j > 0 && less(key, list[j - 1])){
                list[j] = list[j - 1];
                j--;
                countPass++;
            }
            list[j] = key;
            countMoving++;
        }
        System.out.println("insertionSort countPass " + countPass);
        System.out.println("insertionSort countMoving " + countMoving);
    }

    public void bubbleSort() {
        boolean isSwap;
        double countPass = 0;
        double countMoving = 0;
        for (int i = size - 1; i > 0; i--){
            isSwap = false;
            countPass++;
            for(int j = 0; j < i; j++){
                countPass++;
                if(less(list[j + 1], list[j])){
                    swap(j, j + 1);
                    countMoving++;
                    isSwap = true;
                }
            }
            if(!isSwap){
                System.out.println("break " + i);
                System.out.println("bubbleSort countPass " + countPass);
                System.out.println("bubbleSort countMoving " + countMoving);
                break;
            }
        }
    }
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < size; i++) {
            sb.append(list[i]).append(", ");
        }
        if (size > 0) {
            sb.setLength(sb.length() - 2);
        }
        sb.append("]");
        return sb.toString();
    }
}
