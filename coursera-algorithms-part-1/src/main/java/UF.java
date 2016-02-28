public interface UF {
    // add connection between p and q
    public void union(int p, int q);

    // commponent identifier for p (0 to N-1)
    public int find(int p);

    // are p and q in the same component?
    public boolean connected(int p, int q);

    // number of components
    public int count();
}