package OOP.polymorphizm;

import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Figure> figures = new ArrayList<>();

        figures.add(new Circle(7));
        figures.add(new Triangle(3, 4, 5, 4));
        figures.add(new Square(6));

        for (Figure figure : figures) {
            drawFigures(figure);
            System.out.println("P=" + figure.getPerimeter());
            System.out.println("S=" + figure.getSquare());
            removeFigures(figure);
        }
    }
    public static void drawFigures(Figure figures){
        figures.draw();
    }
    public static void removeFigures(Figure figures){
        figures.remove();
    }
}
