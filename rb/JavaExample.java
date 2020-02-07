public class JavaExample {
    public static void main(String[] args) {
      try {
        System.out.println("try 1: parsed " + Integer.parseInt("1000"));
        System.out.println("try 2: parsed " + Integer.parseInt("A grand"));
      } catch (NumberFormatException e) {
        System.out.println("catch: " + e);
      } finally {
        System.out.println("finally: Have a nice day.");
      }
    }
}
