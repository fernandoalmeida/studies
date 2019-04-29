import java.util.Iterator;
import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.assertEquals;

public class StackTest {
    Stack<Integer> stack;

    @Before
    public void initialize() {
	stack = new Stack<Integer>();
    }

    @Test
    public void testInilialization() {
	assertEquals(0, stack.size());
	assertEquals(true, stack.isEmpty());
    }

    @Test
    public void testOperations() {
	stack.push(1);
	stack.push(2);
	stack.push(3);
	stack.push(4);
	stack.push(5);
	assertEquals(5, stack.size());
	assertEquals(false, stack.isEmpty());

	assertEquals(5, stack.pop().intValue());
	assertEquals(4, stack.pop().intValue());
	assertEquals(3, stack.size());

	stack.push(6);
	assertEquals(4, stack.size());

	assertEquals(6, stack.pop().intValue());
	assertEquals(3, stack.size());

	assertEquals(3, stack.pop().intValue());
	assertEquals(2, stack.pop().intValue());
	assertEquals(1, stack.pop().intValue());
	assertEquals(true, stack.isEmpty());
    }

    @Test
    public void testIterator() {
	stack.push(1);
	stack.push(2);
	stack.push(3);
	stack.push(4);
	stack.push(5);

	Iterator<Integer> iterator = stack.iterator();

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
