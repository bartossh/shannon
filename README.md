# Shannon

Measuring an entropy of provided string, allows to validate password strength.

## Introduction 

This project name is inspired by [Claude Elwood Shannon](https://en.wikipedia.org/wiki/Claude_Shannon) known as a father of information theory.

### The illusion of complexity

Complexity in passwords is a topic often shrouded in misconceptions. Many believe that simply tacking on a capital letter or a number at the end of a password elevates its security. However, this approach is akin to putting a lock on a paper door. At first glance, it presents the illusion of security, but upon closer examination, it offers minimal real-world protection.

Thanks to today's vast password libraries and powerful computers, brute-force attacks are within the reach of any homegrown hacker.
You can check if your password has been pawned here: [Pwned Passwords](https://haveibeenpwned.com/Passwords).
Even if your password hasn't been pawned or is not in the library it can still be vulnerable to attack simply if it contains only known words or some letters are exchanged to numbers or other characters such, for example: s to 5, x to #, e to 3, g to 9.

### The Flawed Logic of Human Created Complexity

When it comes to creating complex passwords, humans often fall into the trap of their own patterns. We are creatures of habit, drawn to sequences and familiar structures that make sense to us. This innate preference for patterns extends to how we create passwords, often leading to choices that are more predictable than we realize.

The best measurement of the complexity comes from the field of physics and is named the entropy.I am recommending to read [Entropy Wiki page](https://en.wikipedia.org/wiki/Entropy). This project focuses on the entropy that is part of information theory. In 1948, Bell Labs scientist Claude Shannon developed similar statistical concepts of measuring microscopic uncertainty and diversity to the problem of random losses of information in telecommunication signals. Upon John von Neumann's suggestion, Shannon named this entity of missing information in an analogous manner to its use in statistical mechanics as entropy and gave birth to the field of information theory. This description has been identified as a universal definition of entropy.

## Technology

This project uses [zig](https://ziglang.org/) programming language as a fresh alternative to C and Go.

## Test 

```sh
make test
```

## Build 

```sh
make build
```

## Usage

```sh
./shannon yourPassword
```

