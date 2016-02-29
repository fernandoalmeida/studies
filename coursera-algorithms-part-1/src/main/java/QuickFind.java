public class QuickFind implements UF {
    private int[] id;
    private int count;

    // set id of each object to itself (N array accesses)
    public QuickFind(int N) {
	id = new int[N];
	count = N;

	for (int i = 0; i < N; i++) {
	    id[i] = i;
	}
    }

    // change all entries with id[p] to id[q]
    public void union(int p, int q) {
	int pid = find(p);
	int qid = find(q);

	if (pid == qid) return;

	for (int i = 0; i < id.length; i++) {
	    if (id[i] == pid) {
		id[i] = qid;
	    }
	}

	count--;
    }

    // find the component identifier
    public int find(int p) {
	return id[p];
    }

    // chech whether p and q are in the same component
    public boolean connected(int p, int q) {
	return find(p) == find(q);
    }

    // count the number of components
    public int count() {
	return count;
    }

    public static void main(String[] args) {
	int N = StdIn.readInt();
	QuickFind qf = new QuickFind(N);

	qf.process();
    }
}
