import java.lang.UnsupportedOperationException;
import java.lang.NullPointerException;
import java.util.NoSuchElementException;
import java.util.Iterator;

public class Deque<Item> implements Iterable<Item> {
    private int size;
    private Node<Item> first;
    private Node<Item> last;

    // construct an empty deque
    public Deque() {
	size = 0;
    }

    // is the deque empty?
    public boolean isEmpty() {
	return size == 0;
    }

    // return the number of items on the deque
    public int size() {
	return size;
    }

    // add the item to the front
    public void addFirst(Item item) {
	validateAdd(item);

	Node<Item> newitem = new Node<Item>();
	newitem.value = item;

	if (isEmpty()) {
	    first = newitem;
	    last = newitem;
	} else {
	    first.previous = newitem;
	    newitem.next = first;
	    first = newitem;
	}

	size += 1;
    }

    // add the item to the end
    public void addLast(Item item) {
	validateAdd(item);

	Node<Item> newitem = new Node<Item>();
	newitem.value = item;

	if (isEmpty()) {
	    first = newitem;
	    last = newitem;
	} else {
	    last.next = newitem;
	    newitem.previous = last;
	    last = newitem;
	}

	size += 1;
    }

    // remove and return the item from the front
    public Item removeFirst() {
	validateRemove();

	Node<Item> oldfirst = first;
	first = oldfirst.next;

	if (!(first == null)) {
	    first.previous = null;
	}

	size -= 1;

	return oldfirst.value;
    }

    // remove and return the item from the end
    public Item removeLast() {
	validateRemove();

	Node<Item> oldlast = last;
	last = oldlast.previous;

	if (!(last == null)) {
	    last.next = null;
	}

	size -= 1;

	return oldlast.value;
    }

    // return an iterator over items in order from front to end
    public Iterator<Item> iterator() {
	return new DequeIterator();
    }

    private void validateAdd(Item item) {
	if (item == null) {
	    throw new NullPointerException();
	}
    }

    private void validateRemove() {
	if (isEmpty()) {
	    throw new NoSuchElementException();
	}
    }

    private class Node<Item> {
	private Item value;
	private Node<Item> next;
	private Node<Item> previous;
    }

    private class DequeIterator implements Iterator<Item> {
	private Node<Item> current;

	public DequeIterator() {
	    if (!isEmpty()) {
		current = first;
	    }
	}

	public boolean hasNext() {
	    return (current.next != null);
	}

	public void remove() {
	    throw new UnsupportedOperationException();
	}

	public Item next() {
	    if (!hasNext()) {
		throw new java.util.NoSuchElementException();
	    }

	    current = current.next;

	    return current.value;
	}
    }

    // unit testing
    public static void main(String[] args) {

    }
}
