---
layout: single
title: \[Rust\] 여러개의 숫자 입력 받기
date : 2023-08-26 01:23:45 +0900
last_modified_at: 2023-08-26 18:45:44 +0900
categories: [rust]
tags: [rust]
comments: true
public : true
use_math : true
---

rust에서 숫자를 입력 받는 동작 하는 몇가지 방법 정리

# 여러개의 숫자 입력 받아 vec로 저장 하는 방법
## 코드
```rust
use std::io;

fn main() {
    println!("input five numbers :");
    let input_val: Vec<i32> = get_numbers(5);
    println!("input values are {:?}", input_val);
}

fn get_numbers<T: std::str::FromStr>(count: usize) -> Vec<T> {
    let mut input_val: Vec<T> = Vec::with_capacity(count);

    'loop1: loop {
        let mut input = String::new();
        match io::stdin().read_line(&mut input) {
            Ok(_n) => (),
            _ => {
                println!("Error");
                continue;
            }
        }
        let mut iter = input.trim().split_whitespace();
        loop {
            let input = iter.next();
            if input != None {
                match input.unwrap().trim().parse::<T>() {
                    Ok(n) => {
                        input_val.push(n);
                        if input_val.len() >= count {
                            break 'loop1;
                        };
                    },
                    _ => {
                        println!("Error");
                        continue;
                    }
                }
            }
            else {
                break;
            }
        }
    }
    input_val
}
```
## 결과
```bash
$ cargo run
input five numbers :
4
3 2 4
3
input values are [4, 3, 2, 4, 3]

$ cargo run
input five numbers :
5
4
3
2
1
input values are [5, 4, 3, 2, 1]
```
<br/>

# 5개의 숫자 한 줄로 입력 받아 vec로 저장 하는 방법
## 코드
아래 코드에서 unwrap()은 잘못된 숫자가 입력되었을 경우 panic이 발생되므로 유의해야 한다.
```rust
use std::io;

fn main() {
    println!("input five numbers in one line :");

    let mut input_val: Vec<i32>;

    loop {
        let mut input = String::new();
        match io::stdin().read_line(&mut input) {
            Ok(_n) => (),
            _ => {
                println!("Error");
                continue;
            }
        }

        input_val = input.trim()
            .split_whitespace()
            .map(|x| x.parse::<i32>().unwrap())
            .collect::<Vec<_>>();

        if input_val.len() >= 5 {
            input_val.truncate(5);
            break;
        }
    }

    println!("input values are {:?}", input_val);
}
```

## 결과
```bash
$ cargo run
input five numbers in one line :
7 6 5 4 3
input values are [7, 6, 5, 4, 3]

$ cargo run
input five numbers in one line :
1 2 3 4 5
input values are [1, 2, 3, 4, 5]
```
