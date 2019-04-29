import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class ThreeSumBinarySearchTest {
    static int[] numbers = {-40, -20, -10, 0, 5, 10, 30,  40};

    @Test
    public void testCount() {
	assertEquals(4, ThreeSumBinarySearch.count(numbers));
    }
}
