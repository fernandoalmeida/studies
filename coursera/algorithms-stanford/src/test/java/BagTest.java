import java.util.Iterator;
import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.assertEquals;

public class BagTest {
    Bag<Integer> bag;

    @Before
    public void initialize() {
	bag = new Bag<Integer>();
    }

    @Test
    public void testInilialization() {
	assertEquals(0, bag.size());
	assertEquals(true, bag.isEmpty());
    }

    @Test
    public void testOperations() {
	bag.add(1);
	bag.add(2);
	assertEquals(2, bag.size());
	assertEquals(false, bag.isEmpty());

	bag.add(3);
	bag.add(4);
	bag.add(5);
	assertEquals(5, bag.size());
	assertEquals(false, bag.isEmpty());
    }

    @Test
    public void testIterator() {
	bag.add(1);
	bag.add(2);
	bag.add(3);
	bag.add(4);
	bag.add(5);

	Iterator<Integer> iterator = bag.iterator();

	assertEquals(true, iterator.hasNext());

	assertEquals(5, iterator.next().intValue());
	assertEquals(4, iterator.next().intValue());
	assertEquals(3, iterator.next().intValue());

	assertEquals(true, iterator.hasNext());

	assertEquals(2, iterator.next().intValue());
	assertEquals(1, iterator.next().intValue());

	assertEquals(false, iterator.hasNext());
    }
}
