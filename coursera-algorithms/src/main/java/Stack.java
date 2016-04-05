import java.util.Iterator;

public class Stack<Item> implements Iterable<Item> {
    private int size = 0;
    private Node<Item> first = null;

    // private inner class
    private class Node<Item> {
    	Item item;
    	Node<Item> next;
    }

    // insert a new string onto stack
    public void push(Item item) {
    	Node<Item> oldfirst = first;

    	first = new Node<Item>();
    	first.item = item;
    	first.next = oldfirst;

	size += 1;
    }

    // remove and return the string most recently added
    public Item pop() {
    	Node<Item> oldfirst = first;
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

    // Iterable interface
    public Iterator<Item> iterator() {
	return new StackIterator<Item>(first);
    }

    // private Iterator inner class
    private class StackIterator<Item> implements Iterator<Item> {
	private Node<Item> current;

	public StackIterator(Node<Item> first) {
	    current = first;
	}

	public boolean hasNext() {
	    return current != null;
	}

	public Item next() {
	    Item item = current.item;
	    current = current.next;

	    return item;
	}
    }
}
