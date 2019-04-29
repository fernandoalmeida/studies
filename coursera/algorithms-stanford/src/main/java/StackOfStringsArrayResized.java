public class StackOfStringsArrayResized {
    private String[] stack;
    private int size = 0;

    public StackOfStringsArrayResized() {
	stack = new String[1];
    }

    public boolean isEmpty() {
	return size == 0;
    }

    public void push(String s) {
	if (size == stack.length) {
	    resize(2 * size);
	}

	stack[size++] = s;
    }

    public String pop() {
	if (size > 0 && size == stack.length / 4) {
	    resize(stack.length / 2);
	}

	return stack[--size];
    }

    public int size() {
	return size;
    }

    private void resize(int s) {
	String[] copy = new String[s];

	for(int i = 0; i < size; i++) {
	    copy[i] = stack[i];
	}

	stack = copy;
    }
}
