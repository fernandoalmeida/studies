public class StackOfStringsLinkedList {
    private int size = 0;
    private Node first = null;

    // private inner class
    private class Node {
    	String item;
    	Node next;
    }

    // insert a new string onto stack
    public void push(String s) {
    	Node oldfirst = first;

    	first = new Node();
    	first.item = s;
    	first.next = oldfirst;

	size += 1;
    }

    // remove and return the string most recently added
    public String pop() {
    	Node oldfirst = first;
    	first = oldfirst.next;

	size -= 1;

    	return oldfirst.item;
    }

    // number of strings on the stack
    public int size() {
    	return size;
    }

    // is the stack empty?
    public boolean isEmpty() {
    	return size == 0;
    }
}
