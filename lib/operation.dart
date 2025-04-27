enum Operation {
  addition,
  negation,
  and,
  or,
  leftShift,
  subtraction,
  rightShift,
  increment,
  decrement,
  xor,
}

Map<Operation, int> operationMap = {
  Operation.addition: 0,
  Operation.increment: 0,
  Operation.and: 1,
  Operation.or: 2,
  Operation.xor: 3,
  Operation.negation: 4,
  Operation.leftShift: 5,
  Operation.rightShift: 6,
  Operation.subtraction: 8,
  Operation.decrement: 8,
};
