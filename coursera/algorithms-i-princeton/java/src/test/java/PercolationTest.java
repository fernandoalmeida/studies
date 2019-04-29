import junit.framework.Assert;
import junit.framework.JUnit4TestAdapter;

import org.junit.Test;
import org.junit.runner.JUnitCore;

public class PercolationTest extends Assert {
    @Test
    public void testTrivialGrid() {
        Percolation p = new Percolation(3);

        assertEquals(false, p.percolates());

        p.open(0, 0);
        assertEquals(true, p.isOpen(0, 0));
        assertEquals(false, p.isOpen(0, 1));
        assertEquals(true, p.isFull(0, 0));
        assertEquals(false, p.isFull(0, 1));
        assertEquals(false, p.percolates());

        p.open(0, 1);
        assertEquals(true, p.isOpen(0, 0));
        assertEquals(true, p.isOpen(0, 1));
        assertEquals(true, p.isFull(0, 0));
        assertEquals(true, p.isFull(0, 1));
        assertEquals(false, p.percolates());

        p.open(1, 1);
        p.open(1, 2);
        assertEquals(true, p.isFull(1, 2));
        assertEquals(false, p.percolates());

        p.open(2, 0);
        assertEquals(false, p.isFull(1, 2));
        assertEquals(false, p.percolates());

        p.open(2, 2);
        assertEquals(true, p.isFull(1, 2));
        assertEquals(true, p.percolates());

        // System.out.println("CALL: OPEN()");
        // p.open(1, 1);
        // System.out.println("END CALL: OPEN()");

        // assertTrue(p.isOpen(1, 1));
        // assertTrue(p.isFull(1, 1));
        // assertTrue(p.percolates());
    }

    public static junit.framework.Test suite() {
        return new JUnit4TestAdapter(PercolationTest.class);
    }

    public static void main(String[] args) {
        new JUnitCore().main("PercolationTest");
    }
}
