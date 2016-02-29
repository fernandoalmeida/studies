import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class QuickUnionTest {

    QuickUnion qu;

    @Before
    public void initialize() {
	qu = new QuickUnion(7);

	// { 0, 1, 2 }
	qu.union(0, 1);
	qu.union(0, 2);

	// { 3, 4 }
	qu.union(3, 4);

	// { 5, 6 }
	qu.union(5, 6);
    }

    @Test
    public void testConnected() {
	assertEquals(true, qu.connected(0, 1));
	assertEquals(true, qu.connected(0, 2));
	assertEquals(true, qu.connected(1, 2));
	assertEquals(true, qu.connected(3, 4));
	assertEquals(true, qu.connected(5, 6));
    }

    @Test
    public void testNotConnected() {
	assertEquals(false, qu.connected(0, 3));
	assertEquals(false, qu.connected(0, 4));
	assertEquals(false, qu.connected(0, 5));
	assertEquals(false, qu.connected(0, 6));

	assertEquals(false, qu.connected(1, 3));
	assertEquals(false, qu.connected(1, 4));
	assertEquals(false, qu.connected(1, 5));
	assertEquals(false, qu.connected(1, 6));

	assertEquals(false, qu.connected(2, 3));
	assertEquals(false, qu.connected(2, 4));
	assertEquals(false, qu.connected(2, 5));
	assertEquals(false, qu.connected(2, 6));

	assertEquals(false, qu.connected(3, 5));
	assertEquals(false, qu.connected(3, 6));
    }

    @Test
    public void testCount() {
	assertEquals(3, qu.count());
    }
}
