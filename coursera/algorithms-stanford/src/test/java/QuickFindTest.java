import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class QuickFindTest {

    QuickFind qf;

    @Before
    public void initialize() {
	qf = new QuickFind(7);

	// { 0, 1, 2 }
	qf.union(0, 1);
	qf.union(0, 2);

	// { 3, 4 }
	qf.union(3, 4);

	// { 5, 6 }
	qf.union(5, 6);
    }

    @Test
    public void testConnected() {
	assertEquals(true, qf.connected(0, 1));
	assertEquals(true, qf.connected(0, 2));
	assertEquals(true, qf.connected(1, 2));
	assertEquals(true, qf.connected(3, 4));
	assertEquals(true, qf.connected(5, 6));
    }

    @Test
    public void testNotConnected() {
	assertEquals(false, qf.connected(0, 3));
	assertEquals(false, qf.connected(0, 4));
	assertEquals(false, qf.connected(0, 5));
	assertEquals(false, qf.connected(0, 6));

	assertEquals(false, qf.connected(1, 3));
	assertEquals(false, qf.connected(1, 4));
	assertEquals(false, qf.connected(1, 5));
	assertEquals(false, qf.connected(1, 6));

	assertEquals(false, qf.connected(2, 3));
	assertEquals(false, qf.connected(2, 4));
	assertEquals(false, qf.connected(2, 5));
	assertEquals(false, qf.connected(2, 6));

	assertEquals(false, qf.connected(3, 5));
	assertEquals(false, qf.connected(3, 6));
    }

    @Test
    public void testCount() {
	assertEquals(3, qf.count());
    }
}
