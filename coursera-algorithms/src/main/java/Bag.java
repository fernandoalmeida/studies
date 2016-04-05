import java.util.Iterator;

public class Bag<Item> implements Iterable<Item> {
    private int size = 0;
    private Node<Item> first = null;

    public void add(Item item) {
	Node<Item> oldfirst = first;
	first = new Node<Item>();
	first.item = item;
	first.next = oldfirst;
	size++;
    }

    public int size() {
	return size;
    }

    public boolean isEmpty() {
	return size == 0;
    }

    public Iterator<Item> iterator() {
	return new BagIterator<Item>(first);
    }

    private class Node<Item> {
	public Item item;
	public Node<Item> next;
    }

    private class BagIterator<Item> implements Iterator<Item> {
	private Node<Item> current;

	public BagIterator(Node<Item> first) {
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
