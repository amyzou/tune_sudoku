int factorial(int x) {
  int i, fact = 1;
  for (i = 1; i <= x; i++)
    fact = fact * i;
  return fact;
}
