import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class EvaluateTest {
    Evaluate e = new Evaluate();

    @Test
    public void testEval() {
	assertEquals(2, e.eval("(1+1)").intValue());
	assertEquals(2, e.eval("(1 + 1)").intValue());
	assertEquals(4, e.eval("((1 + 1) * 2)").intValue());
	assertEquals(8, e.eval("((1 + 1) * (2 + 2))").intValue());
	assertEquals(12, e.eval("((2 * 3) + (2 * 3))").intValue());
    }
}
