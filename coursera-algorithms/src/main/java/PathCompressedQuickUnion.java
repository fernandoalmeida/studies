public class PathCompressedQuickUnion extends WeightedQuickUnion {
    public PathCompressedQuickUnion(int N) {
	super(N);
    }

    private int root(int i) {
	while (i != id[i]) {
	    id[i] = id[id[i]]; // <-- path compression
	    i = id[i];
	}

	return i;
    }

    public static void main(String[] args) {
	int N = StdIn.readInt();
	PathCompressedQuickUnion pcqu = new PathCompressedQuickUnion(N);

	pcqu.process();
    }
}
