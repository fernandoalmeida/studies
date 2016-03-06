import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class ThreeSumTest {
    static int[] numbers = {30, -40, -20, -10, 40, 0, 10, 5};

    @Test
    public void testCount() {
	assertEquals(4, ThreeSum.count(numbers));
    }
}
