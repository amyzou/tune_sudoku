def factorial(x)
  (1..x).reduce(&:*) || 1
end
