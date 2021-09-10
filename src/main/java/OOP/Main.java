package OOP;

public class Main {
    public static void main(String[] args) {
        Person person = toString.builder()
                .firstName("Sergey")
                .lastName("Zherebtsov")
                .middleName("Alexsandrovich")
                .country("Russia")
                .address("Novosibirsk")
                .phone("+79999999999")
                .age(34)
                .gender("male")
                .build();
        System.out.println(person);
    }
}
