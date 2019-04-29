public class Evaluate {
    public Integer eval(String expr) {
	int size = expr.length();
	Stack<String> ops = new Stack<String>();
	Stack<Integer> vals = new Stack<Integer>();

	for (int i = 0; i < size; i++) {
	    String s = expr.substring(i, i + 1);

	    switch (s) {
	    case "(" :
	    case " " :
		break;
	    case "+" :
	    case "*" :
		ops.push(s);
	        break;
	    case ")" :
		String op = ops.pop();

		if (op.equals("+")) {
		    vals.push(vals.pop() + vals.pop());
		} else if (op.equals("*")) {
		    vals.push(vals.pop() * vals.pop());
		}
		break;
	    default :
		vals.push(Integer.parseInt(s));
		break;
	    }
	}

	return vals.pop();
    }
}
