import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class WeightedQuickUnionTest {

    WeightedQuickUnion wqu;

    @Before
    public void initialize() {
	wqu = new WeightedQuickUnion(7);

	// { 0, 1, 2 }
	wqu.union(0, 1);
	wqu.union(0, 2);

	// { 3, 4 }
	wqu.union(3, 4);

	// { 5, 6 }
	wqu.union(5, 6);
    }

    @Test
    public void testConnected() {
	assertEquals(true, wqu.connected(0, 1));
	assertEquals(true, wqu.connected(0, 2));
	assertEquals(true, wqu.connected(1, 2));
	assertEquals(true, wqu.connected(3, 4));
	assertEquals(true, wqu.connected(5, 6));
    }

    @Test
    public void testNotConnected() {
	assertEquals(false, wqu.connected(0, 3));
	assertEquals(false, wqu.connected(0, 4));
	assertEquals(false, wqu.connected(0, 5));
	assertEquals(false, wqu.connected(0, 6));

	assertEquals(false, wqu.connected(1, 3));
	assertEquals(false, wqu.connected(1, 4));
	assertEquals(false, wqu.connected(1, 5));
	assertEquals(false, wqu.connected(1, 6));

	assertEquals(false, wqu.connected(2, 3));
	assertEquals(false, wqu.connected(2, 4));
	assertEquals(false, wqu.connected(2, 5));
	assertEquals(false, wqu.connected(2, 6));

	assertEquals(false, wqu.connected(3, 5));
	assertEquals(false, wqu.connected(3, 6));
    }

    @Test
    public void testCount() {
	assertEquals(3, wqu.count());
    }
}
