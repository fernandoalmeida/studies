import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.assertEquals;

public class QueueOfStringsLinkedListTest {
    QueueOfStringsLinkedList stack;

    @Before
    public void initialize() {
	stack = new QueueOfStringsLinkedList();
    }

    @Test
    public void testInilialization() {
	assertEquals(0, stack.size());
	assertEquals(true, stack.isEmpty());
    }

    @Test
    public void testOperations() {
	stack.enqueue("to");
	stack.enqueue("be");
	stack.enqueue("or");
	stack.enqueue("not");
	stack.enqueue("to");
	assertEquals(5, stack.size());
	assertEquals(false, stack.isEmpty());

	assertEquals("to", stack.dequeue());
	assertEquals("be", stack.dequeue());
	assertEquals(3, stack.size());

	stack.enqueue("be");
	assertEquals(4, stack.size());

	assertEquals("or", stack.dequeue());
	assertEquals(3, stack.size());

	assertEquals("not", stack.dequeue());
	assertEquals("to", stack.dequeue());
	assertEquals("be", stack.dequeue());
	assertEquals(true, stack.isEmpty());
    }
}
