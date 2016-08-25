# String Class

The String class allows you to use and manipulate strings of text in more complex ways than character arrays do. You can concatenate Strings, append to them, search for and replace substrings, and more. It takes more memory than a simple character array, but it is also more useful.

For reference, character arrays are referred to as strings with a small s, and instances of the String class are referred to as Strings with a capital S. Note that constant strings, specified in "double quotes" are treated as char arrays, not instances of the String class.

## String()

Constructs an instance of the String class. There are multiple versions that construct Strings from different data types (i.e. format them as sequences of characters), including:

  * a constant string of characters, in double quotes (i.e. a char array)
  * a single constant character, in single quotes
  * another instance of the String object
  * a constant integer or long integer
  * a constant integer or long integer, using a specified base
  * an integer or long integer variable
  * an integer or long integer variable, using a specified base

```C++
// SYNTAX
String(val)
String(val, base)
```

```cpp
// EXAMPLES

String stringOne = "Hello String";                     // using a constant String
String stringOne =  String('a');                       // converting a constant char into a String
String stringTwo =  String("This is a string");        // converting a constant string into a String object
String stringOne =  String(stringTwo + " with more");  // concatenating two strings
String stringOne =  String(13);                        // using a constant integer
String stringOne =  String(analogRead(0), DEC);        // using an int and a base
String stringOne =  String(45, HEX);                   // using an int and a base (hexadecimal)
String stringOne =  String(255, BIN);                  // using an int and a base (binary)
String stringOne =  String(millis(), DEC);             // using a long and a base
```
Constructing a String from a number results in a string that contains the ASCII representation of that number. The default is base ten, so

`String thisString = String(13)`
gives you the String "13". You can use other bases, however. For example,
`String thisString = String(13, HEX)`
gives you the String "D", which is the hexadecimal representation of the decimal value 13. Or if you prefer binary,
`String thisString = String(13, BIN)`
gives you the String "1101", which is the binary representation of 13.



Parameters:

  * val: a variable to format as a String - string, char, byte, int, long, unsigned int, unsigned long
  * base (optional) - the base in which to format an integral value

Returns: an instance of the String class



## charAt()

Access a particular character of the String.

```C++
// SYNTAX
string.charAt(n)
```
Parameters:

  * `string`: a variable of type String
  * `n`: the character to access

Returns: the n'th character of the String


## compareTo()

Compares two Strings, testing whether one comes before or after the other, or whether they're equal. The strings are compared character by character, using the ASCII values of the characters. That means, for example, that 'a' comes before 'b' but after 'A'. Numbers come before letters.


```C++
// SYNTAX
string.compareTo(string2)
```

Parameters:

  * string: a variable of type String
  * string2: another variable of type String

Returns:

  * a negative number: if string comes before string2
  * 0: if string equals string2
  * a positive number: if string comes after string2

## concat()

Combines, or *concatenates* two strings into one string. The second string is appended to the first, and the result is placed in the original string.

```C++
// SYNTAX
string.concat(string2)
```

Parameters:

  * string, string2: variables of type String

Returns: None

## endsWith()

Tests whether or not a String ends with the characters of another String.

```C++
// SYNTAX
string.endsWith(string2)
```

Parameters:

  * string: a variable of type String
  * string2: another variable of type String

Returns:

  * true: if string ends with the characters of string2
  * false: otherwise


## equals()

Compares two strings for equality. The comparison is case-sensitive, meaning the String "hello" is not equal to the String "HELLO".

```C++
// SYNTAX
string.equals(string2)
```
Parameters:

  * string, string2: variables of type String

Returns:

  * true: if string equals string2
  * false: otherwise

## equalsIgnoreCase()

Compares two strings for equality. The comparison is not case-sensitive, meaning the String("hello") is equal to the String("HELLO").

```C++
// SYNTAX
string.equalsIgnoreCase(string2)
```
Parameters:

  * string, string2: variables of type String

Returns:

  * true: if string equals string2 (ignoring case)
  * false: otherwise

## format()

*Since 0.4.6.*

Provides printf-style formatting for strings.

```C++

Particle.publish("startup", String::format("frobnicator started at %s", Time.timeStr().c_str()));

```


## getBytes()

Copies the string's characters to the supplied buffer.

```C++
// SYNTAX
string.getBytes(buf, len)
```
Parameters:

  * string: a variable of type String
  * buf: the buffer to copy the characters into (byte [])
  * len: the size of the buffer (unsigned int)

Returns: None

## indexOf()

Locates a character or String within another String. By default, searches from the beginning of the String, but can also start from a given index, allowing for the locating of all instances of the character or String.

```C++
// SYNTAX
string.indexOf(val)
string.indexOf(val, from)
```

Parameters:

  * string: a variable of type String
  * val: the value to search for - char or String
  * from: the index to start the search from

Returns: The index of val within the String, or -1 if not found.

## lastIndexOf()

Locates a character or String within another String. By default, searches from the end of the String, but can also work backwards from a given index, allowing for the locating of all instances of the character or String.

```C++
// SYNTAX
string.lastIndexOf(val)
string.lastIndexOf(val, from)
```

Parameters:

  * string: a variable of type String
  * val: the value to search for - char or String
  * from: the index to work backwards from

Returns: The index of val within the String, or -1 if not found.

## length()

Returns the length of the String, in characters. (Note that this doesn't include a trailing null character.)

```C++
// SYNTAX
string.length()
```

Parameters:

  * string: a variable of type String

Returns: The length of the String in characters.

## remove()

The String `remove()` function modifies a string, in place, removing chars from the provided index to the end of the string or from the provided index to index plus count.

```C++
// SYNTAX
string.remove(index)
string.remove(index,count)
```

Parameters:

  * string: the string which will be modified - a variable of type String
  * index: a variable of type unsigned int
  * count: a variable of type unsigned int

Returns: None

## replace()

The String `replace()` function allows you to replace all instances of a given character with another character. You can also use replace to replace substrings of a string with a different substring.

```C++
// SYNTAX
string.replace(substring1, substring2)
```

Parameters:

  * string: the string which will be modified - a variable of type String
  * substring1: searched for - another variable of type String (single or multi-character), char or const char (single character only)
  * substring2: replaced with - another variable of type String (signle or multi-character), char or const char (single character only)

Returns: None

## reserve()

The String reserve() function allows you to allocate a buffer in memory for manipulating strings.

```C++
// SYNTAX
string.reserve(size)
```
Parameters:

  * size: unsigned int declaring the number of bytes in memory to save for string manipulation

Returns: None

```cpp
//EXAMPLE

String myString;

void setup() {
  // initialize serial and wait for port to open:
  Serial1.begin(9600);

  myString.reserve(26);
  myString = "i=";
  myString += "1234";
  myString += ", is that ok?";

  // print the String:
  Serial1.println(myString);
}

void loop() {
 // nothing to do here
}
```

## setCharAt()

Sets a character of the String. Has no effect on indices outside the existing length of the String.

```C++
// SYNTAX
string.setCharAt(index, c)
```
Parameters:

  * string: a variable of type String
  * index: the index to set the character at
  * c: the character to store to the given location

Returns: None

## startsWith()

Tests whether or not a String starts with the characters of another String.

```C++
// SYNTAX
string.startsWith(string2)
```

Parameters:

  * string, string2: variable2 of type String

Returns:

  * true: if string starts with the characters of string2
  * false: otherwise


## substring()

Get a substring of a String. The starting index is inclusive (the corresponding character is included in the substring), but the optional ending index is exclusive (the corresponding character is not included in the substring). If the ending index is omitted, the substring continues to the end of the String.

```C++
// SYNTAX
string.substring(from)
string.substring(from, to)
```

Parameters:

  * string: a variable of type String
  * from: the index to start the substring at
  * to (optional): the index to end the substring before

Returns: the substring

## toCharArray()

Copies the string's characters to the supplied buffer.

```C++
// SYNTAX
string.toCharArray(buf, len)
```
Parameters:

  * string: a variable of type String
  * buf: the buffer to copy the characters into (char [])
  * len: the size of the buffer (unsigned int)

Returns: None

## toFloat()

Converts a valid String to a float. The input string should start with a digit. If the string contains non-digit characters, the function will stop performing the conversion. For example, the strings "123.45", "123", and "123fish" are converted to 123.45, 123.00, and 123.00 respectively. Note that "123.456" is approximated with 123.46. Note too that floats have only 6-7 decimal digits of precision and that longer strings might be truncated.

```C++
// SYNTAX
string.toFloat()
```

Parameters:

  * string: a variable of type String

Returns: float (If no valid conversion could be performed because the string doesn't start with a digit, a zero is returned.)

## toInt()

Converts a valid String to an integer. The input string should start with an integral number. If the string contains non-integral numbers, the function will stop performing the conversion.

```C++
// SYNTAX
string.toInt()
```

Parameters:

  * string: a variable of type String

Returns: long (If no valid conversion could be performed because the string doesn't start with a integral number, a zero is returned.)

## toLowerCase()

Get a lower-case version of a String. `toLowerCase()` modifies the string in place.

```C++
// SYNTAX
string.toLowerCase()
```

Parameters:

  * string: a variable of type String

Returns: None

## toUpperCase()

Get an upper-case version of a String. `toUpperCase()` modifies the string in place.

```C++
// SYNTAX
string.toUpperCase()
```

Parameters:

  * string: a variable of type String

Returns: None

## trim()

Get a version of the String with any leading and trailing whitespace removed.

```C++
// SYNTAX
string.trim()
```

Parameters:

  * string: a variable of type String

Returns: None