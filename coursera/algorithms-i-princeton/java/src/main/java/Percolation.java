import edu.princeton.cs.algs4.WeightedQuickUnionUF;

import java.util.Arrays;

public class Percolation {
    private int gridColumns, totalCells, virtualTop, virtualBottom;
    private boolean[] openedCells;
    private WeightedQuickUnionUF unionFind;

    public Percolation(int n) {
        gridColumns = n;
        totalCells = n * n;
        virtualTop = totalCells;
        virtualBottom = totalCells + 1;
        openedCells = new boolean[n];
        Arrays.fill(openedCells, false);
        unionFind = new WeightedQuickUnionUF(totalCells + 2);
    }

    public void open(int row, int col) {
        int current = index(row, col);
        int up = current - gridColumns;
        int down = current + gridColumns;
        int left = current - 1;
        int right = current + 1;

        openedCells[current] = true;

        if(up >= 0 && openedCells[up]) {
            unionFind.union(current, up);
        }

        System.out.println(down);
        if((down <= (totalCells - 1)) && openedCells[down]) {
            unionFind.union(current, down);
        }

        if(left >= 0 && line(left) == line(current) && openedCells[left]) {
            unionFind.union(current, left);
        }

        if(line(right) == line(current) && openedCells[right]) {
            unionFind.union(current, right);
        }

        if(line(current) == 0) {
            unionFind.union(current, virtualTop);
        }

        if(line(current) == line(totalCells - 1)) {
            unionFind.union(current, virtualBottom);
        }
    }

    private int index(int row, int col) {
        return (gridColumns * row) + col;
    }

    private int line(int i) {
        return (i / gridColumns);
    }

    public boolean isOpen(int row, int col) {
        return openedCells[index(row, col)];
    }

    public boolean isFull(int row, int col) {
        return unionFind.connected(index(row, col), virtualTop);
    }

    public int numberOfOpenSites() {
        // FIXME: not implemented
        return totalCells - unionFind.count() + 1;
    }

    public boolean percolates() {
        return unionFind.connected(virtualTop, virtualBottom);
    }

    public static void main(String[] args) {
        Percolation p = new Percolation(3);
        p.open(0, 0);
    }
}
