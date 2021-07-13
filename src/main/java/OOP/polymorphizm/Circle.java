package OOP.polymorphizm;

public class Circle extends Figure {

    private final double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    @Override
    void draw() {
        System.out.println("Drawing a Circle");
    }

    @Override
    double getSquare() {
        return Math.PI * (radius * radius);
    }

    @Override
    double getPerimeter() {
        return Math.PI * radius * 2;
    }

    @Override
    void remove() {
        System.out.println("Removing a Circle");
    }
}
