public class QueueOfStringsLinkedList {
    private int size = 0;
    private Node first = null;
    private Node last = null;

    // private inner class
    private class Node {
    	String item;
    	Node next;
    }

    // insert a new string onto stack
    public void enqueue(String s) {
    	Node oldlast = last;
	last = new Node();
	last.item = s;

	if (isEmpty()) {
	    first = last;
	} else {
	    oldlast.next = last;
	}

	size += 1;
    }

    // remove and return the string most recently added
    public String dequeue() {
    	Node oldfirst = first;
    	first = oldfirst.next;

	size -= 1;

	if (isEmpty()) {
	    last = null;
	}

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
