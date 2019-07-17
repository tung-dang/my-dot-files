
Operator	Description	Syntax	Usage
+	Addition	a=$((b+c))	Adds the value of b and c and stores it to variable a
-	Subtraction	a=$((b-c))	Subtracts the value of c from b and stores it to variable a
*	Multiplication	a=$((b*c))	Multiplies the value of b and c and stores it to variable a
/	Division	a=$((b/c))	Divides the value of b by c and stores it to the variable a
%	Modulus	a=$((b%c))	Performs modulo division of b and c and stores it to variable a
++	Pre-increment	$((++aa))	Increments the value of variable a immediately
++	Post-increment	$((a++))	Increments the value of variable a and reflect changes to the next line
--	Pre-decrement	$((--a))	Decrements the value of variable a immediately
--	Post-decrement	$((a--))	Decrements the value of variable a and reflect changes to the next line
**	Exponentiation	$((a**2))	Raise the value of a to the exponent of 2
+=	Plus equal	$((a+=b))	Adds the value of a and b and stores it to the variable a
-=	Minus equal	$((a-=b))	Subtracts the value of b from a and stores it to the variable a
*=	Times equal	$((a*=b))	Multiplies the value of a and b and stores it to variable a
/=	Slash equal	$((a/=b))	Divides the value of a by b and stores it to the variable a
%=	Mod-equal	$((a%=b))	Perform modulo division between a and b and stores it to variable a

# Basic arithmetic using let

Using `let`
```shell
let a=5+4
echo $a # 9
let "a = 5 + 4"
echo $a # 9
let a++
echo $a # 10
let "a = 4 * 5"
echo $a # 20
let "a = $1 + 30"
echo $a # 30 + first command line argument
```

Basic arithmetic using expr
```
#!/usr/bin/env bash
expr 5 + 4
expr "5 + 4"
expr 5+4
expr 5 \* $1
expr 11 % 2
a=$( expr 10 - 3 )
echo $a # 7
```

Basic arithmetic using double parentheses
```
a=$(( 4 + 5 ))
echo $a # 9
a=$((3+5))
echo $a # 8
b=$(( a + 3 ))
echo $b # 11
b=$(( $a + 4 ))
echo $b # 12
(( b++ ))
echo $b # 13
(( b += 3 ))
echo $b # 16
a=$(( 4 * 5 ))
echo $a # 20
```

`${#variable}`: length of variable.
