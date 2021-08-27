# String Table

## String的基本特性

```java
String s1 = new "fengqiang"; //字面量的定义方式
String s2 = new String("Hello");
```

1. String 声明为final的，不可被继承

2. String实现了Serializable接口：表示字符串支持序列化

3. 实现了Comparable接口：表示String可以比较大小

4. String在JDK8之前内部定义了final char[] value 用于存储字符串数据，JDK9时改为byte[]

- String：代表不可变的字符序列，不可变性
  1. 当对字符串重新赋值时，需要重写指定的内存区域，不会使用原有的value赋值
  2. 当对现有的字符串进行连接操作时，也需要重新指定内存区域赋值，不会使用原有的value进行赋值
  3. 当调用String的replace()方法时，也需要重新指定内存区域赋值，不会对原有的value进行赋值
- **字符串常量池中是不会存储内容相同的字符串的**
- Stringd String Pool 是一个固定大小的Hashtable，默认大小是1009，如果放进pool的String非常多，就会造成Hash冲突严重，从而导致链表很长，性能下降
  - -XX:StringTbaleSIze=?：设置StringTable的大小
  - JDK 6 之前默认是1009；JDK 7 默认是60013；JDK 8:1009是默认可设置的最小值

```java
String s1 = "abc";
String s2 = "abc";
System.out.println(s1 == s2);//true

String s1 = "abc";
String s2 = "abc";
s1 = "hello"
System.out.println(s1 == s2);//false

String s1 = "abc";
String s2 = "abc";
s2 += "def"
System.out.println(s1);//abc
System.out.println(s2);//abcdef


String s1 = "abc";
String s2 = s1.replace('a','b');
System.out.println(s1);//abc
System.out.println(s2);//mbc

public class StringExer {
    String str = new String("good");
    char[] ch = {'t', 'e', 's', 't'};
    
    public void change(String str, char[] ch) {
        str = "test ok";
        ch[0] = 'b';
    }
    
    public static void main(String[] args) {
        StringExer ex = new StringExer();
        ex.change(ex.str, ex.ch);
        System.out.println(ex.str);//good
        System.out.println(ex.ch);//best
    }
}
```

## String的内存分配

常量池就类似一个Java系统级别提供的缓存。

除了常用的`String info = "xxx";`可以生产String对象。

还可以用String提供的**intern()**方法

JDK 6 的时候方法区（永久代）还在运行时数据区中，

JDK 7 的时候方法区的静态变量和StringTable存放到了堆空间中

JDK 8 的时候方法区变为元空间，在本地内存存放

**StringTable为什么要调整？**

1. permSize比较小

2. 永久代回收的频率低

## 字符串拼接操作

1. 常量与常量的拼接结果在常量池，原理是编译期优化

   `String s1 = "a" + "b" +"c"; //编译期就拼接为abc`

2. 常量池中不会存在相同的常量

3. 只要有一个是变量，结果就在堆（不是指堆中的字符串常量池）中，拼接原理是StringBuilder

   ```java
   String s1 = "javaEE";
   String s2 = "hadoop";
   String s3 = "javaEEhadoop";
   String s4 = s1 + "hadoop";
   String s5 = "javaEE" + s2;
   s3 == s4 //false
   s3 == s5 //false
   s4 == s5 //flase
   String s6 = s5.intern();
   //intern():判断字符串常量池中是否存在javaEEhadoop值，如果存在，则返回常量池中javaEEhadoop的地址
   //如果字符串常量池中不存在javaEEhadoop，则在常量池中加载在一份javaEEhadoop，并返回次对象的地址
   s3 == s6 //true
   ```

   ```java
   String s1 = "a";
   String s2 = "b";
   String s3 = "ab";
   String s4 = s1 + s2;
   /**
   *	s1 + s2 的执行细节
   *   ① StringBuilder s = new StringBuilder();
   *   ② s.append("a");
   *	③ s.append("b");
   * 	④ s.toString();  -->  约等于 new String("ab")
   *	
   *	补充：在JDK5.0之后使用的是StringBuilder，在JDK5.0
   *		之前使用的是StringBuffer
   */
   
   s3 == s4 // false
   ```

   ```java
   /**
   * 	1. 字符串拼接操作不一定使用的是StringBuilder，
   *	如果拼接符号左右两边都是字符串常量或常量引用，则仍然使用编译器优化。
   * 	2. 针对final修饰类、方法、基本数据类型、引用数据类型的量*  的结构时，能使用上final的时候建议使用上
   */
   final String s1 = "a";
   final String s2 = "b";
   String s3 = "ab";
   String s4 = s1 + s2;
   s3 == s4 // true
   ```

4. 如果拼接结果调用intern()方法，则主动将常量池中还没有字符串对象放入池中，并返回此对象的地址

5. 在实际开发中，如果基本确定要前前后后添加的字符串不高于某个限定值highLevel的情况下，建议使用构造器实例化：

   这样不会频繁的扩容，降低性能开销

   `StringBuilder s = new StringBuilder(highLevel);`

## inter()的使用

intern方法会从字符串常量池中查询当前字符串是否存在，若不存在就会将当前字符串放入常量池中，返回指向这个字符串的引用。

**如何保证变量s指向的是字符串常量池中的数据呢？**

1. `String s= "hello";//字面量的方式`

2. 调用intern方法

   ```java
   String s = new String("hello").itern();
   
   String s = new StringBuilder("hello").toString().intern();
   ```

**对于程序中大量存在的字符串，尤其其中存在很多重复字符串时，使用intern() 可以节省内存空间**

## 题

**new String("ab")会创建几个对象？两个**

一个对象是，new关键字在堆空间创建的

另一个对象是：字符串常量池中的对象， 字节码指令：ldc

**new String("a") + new String("b") 创建了几个对象？**

对象1：new StringBuilder

对象2：new String("a")

对象3：常量池中的 "a"

对象4：new String("b")

对象5：常量池中的 "b"

深入：

对象6：StringBuilder的toString()：

​			new String("ab")  注意在字符串常量池中没有创建ab 

```java
String s3 = new String("1") + new String("1");
//s3变量记录的地址为：new String("11")
s3.intern();
//在字符串常量池中生成"11",
//如何理解：JDK 6：创建了一个新对象11，也就有新的地址
//JDK 7：此时常量中并没有创建"11",而是在字符串常量池中创建一个指向堆空间中new String("11")的地址
String s4 = "11";//使用在常量池中生成的"11"的地址。
System.out.println(s3 == s4);
//JDK6:false   JDK 7:true
```



总结String的intern()方法：

- JDK1.6中：将这个字符串对象尝试放入串池
  1. 如果串池中有，则并不会放入。返回已有的串池中的对象的地址
  2. 如果没有，会把**此对象复制一份**，放入串池，并返回串池中的对象地址
- JDK1.7 / 1.8中：将这个字符串对象尝试放入串池
  1. 如果串池中有，则并不会放入。返回已有的串池中的对象的地址
  2. 如果没有，则会把**对象的地址引用复制一份**，放入串池，并返回串池中的引用地址。

```java
String s3 = new String("1") + new String("1");
String s4 = "11";
String s5 = s3.intern();
System.out.println(s3 == s4);//false
System.out.println(s5 == s4);//true
```

## 练习

```java
String s1 = new String("a") + new String("b");
String s2 = s.intern();

System.out.prntln(s2 == "ab");
System.out.prntln(s1 == "ab");
//JDK 6 中一个是ture，一个是false
//JDK 7 / 8 中一个是true，一个是ture
```



```java
String x = "ab";
String s1 = new String("a") + new String("b");
String s2 = s.intern();

System.out.prntln(s2 == "ab");
System.out.prntln(s1 == "ab"); 
//JDK 6 / 7 / 8 都是，一个是ture，一个是false
```



```java
String s1 = new String("a") + new String("b");
//执行完后不会在字符串常量池中生成 "ab"
s1.intern();
String s2 = "ab";
System.out.println(s1 == s2);
//JDK7:true
```



```java
String s1 = new String("ab");
//执行完后会在字符串常量池中生成 "ab"
s1.intern();
String s2 = "ab";
System.out.println(s1 == s2);
//JDK7:false
```

## G1中的String去重操作



![image-20210826192013716](.\img\006.png)

UseStringDeduplication(bool)：开启去重，默认是不开启的，需要手动开启

PrintStringDeduplicationStatistics(booll)：打印详细的去重统计信息

StringDedeplicationAgeThreshold(uintx)：达到这个年龄的String对象被认为是去重的候选对象
