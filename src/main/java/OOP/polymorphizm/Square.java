package OOP.polymorphizm;

public class Square extends Figure {

    private final double size;

    public Square(double size){
        this.size = size;
    }

    @Override
    void draw() {
        System.out.println("Drawing a Square");
    }

    @Override
    double getSquare() {
        return size * size;
    }

    @Override
    double getPerimeter() {
        return 4 * size;
    }

    @Override
    void remove() {
        System.out.println("Removing a Square");
    }
}
