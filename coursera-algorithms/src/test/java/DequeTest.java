import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.assertEquals;

public class DequeTest {
    Deque<Integer> deque;

    @Before
    public void initialize() {
	deque = new Deque<Integer>();
    }

    @Test
    public void testAddFirst() {
	assertEquals(true, deque.isEmpty());
	assertEquals(0, deque.size());

	deque.addFirst(1);
	assertEquals(false, deque.isEmpty());
	assertEquals(1, deque.size());

	deque.addFirst(2);
	deque.addLast(3);
	assertEquals(3, deque.size());

	assertEquals(2, (int) deque.removeFirst());
	assertEquals(2, deque.size());

	assertEquals(3, (int) deque.removeLast());
	assertEquals(1, deque.size());
    }
}
