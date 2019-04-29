Qual o bug mais foda que você já resolveu?

Qual a feature mais foda que você já desenvolveu?

Resolver todas as "algorithm questions" regulares.

# Preparation grid

"Tell me about a time when you..."

"I implemented X, which was considered one of the most challenging
components because..."

"By examining common user behaviour applying the Rabin-Karp algorithm, I
designed a new algorithm reducing from O(n) to O(log n) in 90% of cases, I can
go into more details if you want."

+--------------------------+------------+-----------+-----------+-----------+
| COMMON QUESTION          | PROJETCT 1 | PROJECT 2 | PROJECT 3 | PROJECT 4 |
+--------------------------+------------+-----------+-----------+-----------+
| Most challenging         |            |           |           |           |
+--------------------------+------------+-----------+-----------+-----------+
| What you learned         |            |           |           |           |
+--------------------------+------------+-----------+-----------+-----------+
| Most interesting         |            |           |           |           |
+--------------------------+------------+-----------+-----------+-----------+
| Hardest bug              |            |           |           |           |
+--------------------------+------------+-----------+-----------+-----------+
| Enjoyed most             |            |           |           |           |
+--------------------------+------------+-----------+-----------+-----------+
| Enjoyed least            |            |           |           |           |
+--------------------------+------------+-----------+-----------+-----------+
| Conflicts with teammates |            |           |           |           |
+--------------------------+------------+-----------+-----------+-----------+

Study this grid before the interview, using keywords is easier to remember.

Use S.A.R technique (Situation, Action, Result).

# Questions to ask the interviewer

Genuine questions:

- How long of my day I will spend coding?
- How many meetings I will have every week?
- There are dedicated testers/PM?
- How does the planning happen on the team?
- How long the company exists? How many devs is there for X years (turnover)?
- What is the percentil of country distribution of the team members?


Insightfull questions:

- I noticed that you use technology X, how do you handle problem Y?
- Why did the product choosen protocol X instead Y? I know the benefits A, B, C
  but there is an issue D.

Passion questions:

- I am very interested in scalability. What opportunities are there about it?
- I am not familiar with technology X, could you tell me about it?

Others

# Technical questions

You need to PRACTICE solving problems, memorizing solutions wont help.

For each problem you might encounter:

1. Try to solve the problem on your own (think about time efficience).
2. Write the code for the algorithm on paper (without editor helps).
3. Test your code on paper.
4. Type your paper code as-is on a computer.

Must-have knowledge (complex algorithms are not asked in interviews):

+-------------------------+-------------------------+-------------------------+
| Data structures         | Algorithms              | Concepts                |
+-------------------------+-------------------------+-------------------------+
| Linked Lists            | Breadth First Search    | Bit Manipulation        |
+-------------------------+-------------------------+-------------------------+
| Binary Trees            | Depth First Search      | Singleton Pattern       |
+-------------------------+-------------------------+-------------------------+
| Tries                   | Binary Search           | Factory Pattern         |
+-------------------------+-------------------------+-------------------------+
| Stacks                  | Merge Sort              | Memory (stack vs heap)  |
+-------------------------+-------------------------+-------------------------+
| Queues                  | Quick Sort              | Recursion               |
+-------------------------+-------------------------+-------------------------+
| Vector / ArrayLists     | Tree Insert, Find, etc  | Big O Time              |
+-------------------------+-------------------------+-------------------------+
| Hash Tables             |                         |                         |
+-------------------------+-------------------------+-------------------------+

For each topic:

- understand how to use and implement it;
- where it is applicable;
- what the space and time complexity is;
- practice implementing from scratch;

* Hash Tables are specialy important, very frequent in interview questions.

## Power of 2 table

+---------------+-------------------+---------------+---------------+
| Power of 2    | Value             | Aprox         | Bytes         |
+---------------+-------------------+---------------+---------------+
| 7             | 128               |               |               |
+---------------+-------------------+---------------+---------------+
| 8             | 256               |               |               |
+---------------+-------------------+---------------+---------------+
| 10            | 1024              | 1 thousand    | 1K            |
+---------------+-------------------+---------------+---------------+
| 16            | 64,536            |               | 64K           |
+---------------+-------------------+---------------+---------------+
| 20            | 1,048,576         | 1 million     | 1MB           |
+---------------+-------------------+---------------+---------------+
| 30            | 1,073,741,824     | 1 billion     | 1GB           |
+---------------+-------------------+---------------+---------------+
| 32            | 4,294,967,296     |               | 4GB           |
+---------------+-------------------+---------------+---------------+
| 40            | 1,099,511,627,766 | 1 trillion    | 1TB           |
+---------------+-------------------+---------------+---------------+

## 5 steps to a technical question

1. Ask your interviewer to resolve ambiguity
   - what are the data types?
   - how much data is there?
   - who is the user?
2. Design an algorithm
   - what are its space and time complexity?
   - what happens if there is a lot of data?
   - does your design cause other issues?
   - which scenarios might the trade-offs be less optimal?
   - if you have specific data, have you leveraged that info?
3. Write pseudocode first
   - make sure to tell your interviewer that you will write the real code.
4. Write your code at a moderate pace
   - go at a nice, slow, methodical pace
   - use data structures generously
   - care about object oriented design
   - start in the left upper corner of the whiteboard
5. Test your code and carefully fix any mistakes
   - general cases
   - extreme cases: 0, negative, null, min, max
   - user errors

## Algorithm approaches

1. Examplify

We write out specific examples of the problem and see if we can derive a general
rule from there.

2. Pattern Matching

We consider what problems the algorithm is similar to and try to modify the
solution to the related problem to develop an algorithm for this problem.

3. Simplify and Generalize

- First, we change a constraint such as the data type or amout of data;
- Then, we solve this new simplified version of the problem;
- Finally, we generalize the problem and try to adapt the earlier soltion for
  the more complex version;

4. Base Case and Build

- We solve the problem for a base case (eg, n = 1);
- Then we try solve the problem for n = 2, assuming the known result for n = 1.
- Next, we try to solve it for n = 3, assuming the known results for n = 1 and 2.
- Eventually, we build a solution that can always compute the result for N if we
  know the result for N-1.

Often lead to natural recursive algorithms.

5. Data Structure Brainsorm

This approach is certainly hacky, but it often works. We can simply run through
a list of data structures and try to apply each one. This is useful because
solving a problem may be trivial once it occurs to us to use, say, a tree.

## What good code looks like

- correct
- efficient
- simple
- readable
- maintainable

* use data structures generously
* reuse code
* modular
* flexible (if possible and simple)
* check errors

## The offer

Recruiters generally don't like to say why a candidate was refused, ask them
what do you need more preparation instead.
