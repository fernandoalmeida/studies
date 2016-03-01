public class WeightedQuickUnion extends QuickUnion {
    private int[] size;

    public WeightedQuickUnion(int N) {
        super(N);

        size = new int[N];

        for (int i = 0; i < N; i++) {
            size[i] = 1;
        }
    }

    public void union(int p, int q) {
	int i = find(p);
	int j = find(q);

	if (i == j) return;

	if (size[i] < size[j]) {
	    id[i] = j;
	    size[j] += size[i];
	} else {
	    id[j] = i;
	    size[i] += size[j];
	}

	count--;
    }

    public static void main(String[] args) {
	int N = StdIn.readInt();
	WeightedQuickUnion wqu = new WeightedQuickUnion(N);

	wqu.process();
    }
}
