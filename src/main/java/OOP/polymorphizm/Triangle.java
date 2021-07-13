package OOP.polymorphizm;

public class Triangle extends Figure {

    private final double a;
    private final double b;
    private final double c;
    private final double height;

    public Triangle(double a, double b, double c, double height){
        this.a = a;
        this.b = b;
        this.c = c;
        this.height = height;
    }

    @Override
    void draw() {
        System.out.println("Drawing a Triangle");
    }

    @Override
    double getSquare() {
        return (height * height) / 2;
    }

    @Override
    double getPerimeter() {
        return a + b + c;
    }

    @Override
    void remove() {
        System.out.println("Removing a Triangle");
    }
}
