import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class BinarySearchTest {
    BinarySearch bs;

    static int[] sorted_numbers = {0, 5, 10, 20, 30, 40};

    @Test
    public void testSearchFound() {
	assertEquals(3, bs.search(sorted_numbers, 20));
    }

    @Test
    public void testSearchNotFound() {
	assertEquals(-1, bs.search(sorted_numbers, 25));
    }
}
