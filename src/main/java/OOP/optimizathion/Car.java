package OOP.optimizathion;
// отстутсвует имя пакета
// интерфейсы и классы необходимо разнести по разным файлам

interface Moveable {
    void move();
}

interface Stopable {
    void stop();
}

abstract class Car {
    public Engine engine;
    private String color;
    private String name;


    protected void start() {
        System.out.println("Car starting");
    }

    abstract void open();

    //Engine нужно реализовать как класс
    public Engine getEngine() {
        return engine;
    }

    public void setEngine(Engine engine) {
        this.engine = engine;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}

class LightWeightCar extends Car implements Moveable{

    @Override
    void open() {
        System.out.println("Car is open");
    }

    @Override
    public void move() {
        System.out.println("Car is moving");
    }

}
// Лишний 0
0
//Moveable, Stopable являются интерфейсами, реализация осуществляется ключевым словом implements
class Lorry extends Car, Moveable, Stopable{

    public void move(){
        System.out.println("Car is moving");
    }

    public void stop(){
        System.out.println("Car is stop");
    }
}


