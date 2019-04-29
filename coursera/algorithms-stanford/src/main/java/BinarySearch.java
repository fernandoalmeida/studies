public class BinarySearch {
    public static int search(int[] numbers, int n) {
	int min = 0;
	int max = numbers.length - 1;

	while (min <= max) {
	    int mid = min + (max - min) / 2;

	    if (n < numbers[mid]) {
		max = mid - 1;
	    } else if (n > numbers[mid]) {
		min = mid + 1;
	    } else {
		return mid;
	    }
	}

	return -1;
    }
}
