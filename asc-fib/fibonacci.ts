import "wasi";
import { Console } from "as-wasi";

function fib(n: i32): i32 {
  if (n <= 1) return n;
	return fib(n - 1) + fib(n - 2);
}

let inputStr = Console.readAll();
if (inputStr != null){
  let n: i32 = parseInt(inputStr as string, 10) as i32;
  let result: i32 = fib(n);
  Console.log(`${result}`);
}
