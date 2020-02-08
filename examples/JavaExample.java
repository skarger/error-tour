public class JavaExample {
    public static void main(String[] args) {
      try {
        System.out.println("Parsed " + Integer.parseInt("1000"));

        System.out.println("Parsed " + Integer.parseInt("A grand"));
      } catch (NumberFormatException e) {
        System.out.println("Error: " + e + ".");
      } finally {
        System.out.println("Have a nice day.");
      }
    }
}
