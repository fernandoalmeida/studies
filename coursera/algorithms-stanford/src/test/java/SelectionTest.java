import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class SelectionTest {
    @Test
    public void testSort() {
	String[] sortable = {"S","O","R","T","E","X","A","M","P","L","E"};
	String[] sorted = {"A","E","E","L","M","O","P","R","S","T","X"};
	Selection.sort(sortable);

	assertEquals(sorted, sortable);
    }
}
