public class QuickUnion implements UF {
    private int[] id;
    private int count;

    public QuickUnion(int N) {
	id = new int[N];
	count = N;

	for(int i = 0; i < N; i++) {
	    id[i] = i;
	}
    }

    public void union(int p, int q) {
	int i = find(p);
	int j = find(q);

	if (i == j) return;

	id[i] = j;
	count--;
    }

    public int find(int p) {
	return root(p);
    }

    private int root(int i) {
	while (i != id[i]) {
	    i = id[i];
	}

	return i;
    }

    public boolean connected(int p, int q) {
	return find(p) == find(q);
    }

    public int count() {
	return count;
    }

    public static void main(String[] args) {
	int N = StdIn.readInt();
	QuickUnion qu = new QuickUnion(N);

	qu.process();
    }
}
