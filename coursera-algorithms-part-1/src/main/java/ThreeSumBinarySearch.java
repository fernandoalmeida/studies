/******************************************************************************
 *
 *  Read in N integers and counts the number of triples that sum to exactly 0.
 *
 *  The array of numbers should be sorted.
 *
 ******************************************************************************/
public class ThreeSumBinarySearch {
    public static int count(int[] a) {
	int N = a.length;
	int count = 0;


	// TODO: command line to sort input data
	for(int i = 0; i < N - 2; i++) {
	    for(int j = i + 1; j < N - 1; j++) {
		int k = BinarySearch.search(a, -(a[i] + a[j]));

		if (k >= 0 && k > j) {
		    count++;
		}
	    }
	}

	return count;
    }

    public static void main(String[] args) {
	int[] a = In.readInts(args[0]);
	Stopwatch stopwatch = new Stopwatch();
	StdOut.println(ThreeSumBinarySearch.count(a));
	double time = stopwatch.elapsedTime();
    }
}
