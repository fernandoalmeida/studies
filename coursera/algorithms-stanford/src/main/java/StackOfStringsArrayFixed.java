public class StackOfStringsArrayFixed {
    private String[] stack;
    private int size = 0;

    public StackOfStringsArrayFixed(int N) {
	stack = new String[N];
    }

    public boolean isEmpty() {
	return size == 0;
    }

    public void push(String s) {
	stack[size++] = s;
    }

    public String pop() {
	return stack[--size];
    }

    public int size() {
	return size;
    }
}
