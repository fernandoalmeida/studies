import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class PathCompressedQuickUnionTest {

    PathCompressedQuickUnion pcqu;

    @Before
    public void initialize() {
	pcqu = new PathCompressedQuickUnion(7);

	// { 0, 1, 2 }
	pcqu.union(0, 1);
	pcqu.union(0, 2);

	// { 3, 4 }
	pcqu.union(3, 4);

	// { 5, 6 }
	pcqu.union(5, 6);
    }

    @Test
    public void testConnected() {
	assertEquals(true, pcqu.connected(0, 1));
	assertEquals(true, pcqu.connected(0, 2));
	assertEquals(true, pcqu.connected(1, 2));
	assertEquals(true, pcqu.connected(3, 4));
	assertEquals(true, pcqu.connected(5, 6));
    }

    @Test
    public void testNotConnected() {
	assertEquals(false, pcqu.connected(0, 3));
	assertEquals(false, pcqu.connected(0, 4));
	assertEquals(false, pcqu.connected(0, 5));
	assertEquals(false, pcqu.connected(0, 6));

	assertEquals(false, pcqu.connected(1, 3));
	assertEquals(false, pcqu.connected(1, 4));
	assertEquals(false, pcqu.connected(1, 5));
	assertEquals(false, pcqu.connected(1, 6));

	assertEquals(false, pcqu.connected(2, 3));
	assertEquals(false, pcqu.connected(2, 4));
	assertEquals(false, pcqu.connected(2, 5));
	assertEquals(false, pcqu.connected(2, 6));

	assertEquals(false, pcqu.connected(3, 5));
	assertEquals(false, pcqu.connected(3, 6));
    }

    @Test
    public void testCount() {
	assertEquals(3, pcqu.count());
    }
}
