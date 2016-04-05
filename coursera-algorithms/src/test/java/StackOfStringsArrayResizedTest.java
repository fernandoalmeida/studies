import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.assertEquals;

public class StackOfStringsArrayResizedTest {
    StackOfStringsArrayResized stack;

    @Before
    public void initialize() {
	stack = new StackOfStringsArrayResized();
    }

    @Test
    public void testInilialization() {
	assertEquals(0, stack.size());
	assertEquals(true, stack.isEmpty());
    }

    @Test
    public void testOperations() {
	stack.push("to");
	stack.push("be");
	stack.push("or");
	stack.push("not");
	stack.push("to");
	assertEquals(5, stack.size());
	assertEquals(false, stack.isEmpty());

	assertEquals("to", stack.pop());
	assertEquals("not", stack.pop());
	assertEquals(3, stack.size());

	stack.push("be");
	assertEquals(4, stack.size());

	assertEquals("be", stack.pop());
	assertEquals(3, stack.size());

	assertEquals("or", stack.pop());
	assertEquals("be", stack.pop());
	assertEquals("to", stack.pop());
	assertEquals(true, stack.isEmpty());
    }
}
