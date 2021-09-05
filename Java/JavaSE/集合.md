# Collection

## 概述

Collection接口：单列集合，用来存储一个一个的对象

- List接口：存储有序、可重复的数据
  - ArrayList、LInkedList、Vector
- Set接口：存储无序、不可重复的数据
  - HashSet、LinkedHashSet、TreeSet

### Collection接口继承树

![image-20210828091447939](.\img\image-20210828091447939.png)

### 方法

向Collection接口的实现类的对象中添加数据obj时，要求obj所在类重写equals()

1. contains(Object obj)：判断当前集合中是否包含obj，判断时会调用obj对象所在类的equals()

2. containsAll(Collection coll1)：判断形参coll1中的所有元素是否都存在于当前集合中

3. remove(Object obj)：从当前集合中移除obj对象。

4. removeAll(Collection coll1)：（差集）移除coll1与该集合的交集中所有的元素。（会修改调用的集合）

5. retainAll(Collection coll1)：（交集）...（会修改调用的集合）

6. equals(Object obj)：判断集合和形参是否相等。如果是List，还要看顺序，如果是Set，则不用看顺序。

7. toArray()：集合----->数组

   - 补充：Arrays.asList()：数组---->List(集合)

   - ```java
     List arr1 = Arrays.asList(new[] int{123,45});
     //直接打印arr1，会出现[arr1的地址]
     List arr2 = Arrays.asList(new[] Integer{123,45});
     //直接打印arr2，才会出现[123,45]
     ```

8. iterator()：获得迭代器，指向第一个元素之前。集合每次调用iterator()方法都会得到一个全新的迭代器对象。
   - iterator内部定义了romove(),能够在遍历的时候，删除集合中的元素。此方法不同于集合直接调用remove。
   
9. add：增加

## List

### ArrayList、LinkedList、Vector 的异同？

同：三个类都实现了List接口、都存储有序、可重复的数据

不同：

- ArrayList：作为List接口的主要实现类，线程不安全，效率高；底层使用Object[] 存储

- LinkedList：对于频繁的插入和删除，使用此类效率比ArrayList效率高。底层使用的是双向链表
- Vector：作为List接口的古老实现类，线程安全，效率低；底层使用Object[] 存储

### 	ArrayList

当数组大小不满足时需要增加存储能力，就要将已经有数 组的数据复制到新的存储空间中。当从 ArrayList 的中间位置插入或者删除元素时，需要对数组进 行复制、移动、代价比较高。因此，**它适合随机查找和遍历，不适合插入和删除**。

JDK7，new 完ArrayList，底层创建长度是10的Object[]数组，

当此次添加导致底层数组容量不够，会扩容1.5倍，就要将已经有数组的数据复制到新的存储空间中。

JDK8之后，刚new完初始长度为0，**只有当第一次添加的时候才扩容为10**。

**一次扩容：1.5倍**

> 在开发中，建议使用带参的构造器
>
> `ArrayList list = new ArrayList(int capacity)`

### LinkedList

内部声明了Node类型的first和last属性，默认值为null。

Node有next和prev指针。

LinkedList 是用链表结构存储数据的，很适合数据的动态插入和删除。可以当作堆 栈、队列和双向队列使用。

### Vector

​	通过数组实现的，**它支持线程的同步**，即某一时刻只有一 个线程能够写 Vector，避免多线程同时写而引起的不一致性，但实现同步需要很高的花费，因此， 访问它比访问 ArrayList 慢。

​	JDK7和JDK8中通过Vector()构造器创建对象时，底层都创建了长度为10的数组。在扩容方面，**默认扩容为原来的2倍**。

## Set

Set接口中没有额外定义新的方法

无序性：不等于随机性，而是根据数据的哈希值决定的。

不可重复性：保证添加的元素，按照equals方法（）判断时，不能返回true。即相同的元素，只能添加一个。

> - 向Set添加数据，其所在类一定要重写hashCode()和equals()方法
> - 重写的hashCode和equals要保值一致性。（相同的对象要有相等的哈希值）

### HashSet 

底层是HashMap

作为Set接口的主要实现类：线程不安全，可以存储null

链表结构：七上八下，JDK7，红4，JDK8，蓝4（4是新元素）

![](.\img\image-20210828144731503.png)

向HashSet中添加元素a，首先调用元素a所在类的hashCode（）方法，计算a的哈希值，此哈希值通过某种算法计算出在HashSet底层数组中的存放位置，判断此位置是否有元素，

如果此位置上没有其他元素，则a添加成功  **--->情况1**

如果此位置上有其他元素（或以链表形式存在的多个元素），则首先比较元素a的哈希值

​	如果哈希值不相同，则添加成功 **--->情况2** 

​	如果哈希值相同，进而需要调用元素a所在类的equals方法。

​			如果equals方法返回true，就表明元素a添加失败

​			如果equals方法返回false，则元素a添加成功  **--->情况3**

对情况2和3，元素a 与 已经存在指定索引上的数据 以链表的形式存在

#### LinkedHashSet

父类是HashSet，遍历其内部数据时，可以按照添加的顺序去遍历

其内部的每个数据还维护了两个引用，记录此数据的前数据和后一个数据

优点：对于频繁的遍历，LinkedHashSet效率高于HashSet

### TreeSet

底层使用红黑树，可以按照添加对象的指定属性，进行排序

向TreeSet中添加的数据，要求是相同类的对象。

有两种排序方式：自然排序（实现Comparable接口）和定制排序（实现Comparator接口）。

- 自然排序中，比较两个对象是否相同的标准为：compareTo（）返回0，不再是equals方法。
- 定制排序中，比较两个对象是否相同的标准为：compare（）返回0，不再是equals方法。

## 题

1. 集合Collection中存储的如果是自定义类，需要重写哪个方法？为什么？

   equals()方法。

   List：equlas()，

   Set：(HashSet、LinkedHashSet)：equals()、hashCode()

   ​			(TreeSet)：Comparable:compareTo(Object obj)

   ​									Comparator:compare(Object o1,Object o2)

# Map

## 概述

Map：双列数据，存储key-value对的数据

- **Hashtable**：作为古老的实现类，线程安全，效率低；不可以存储null的key和value

  - ​	**Properties**：常用来处理配置文件，key和value都是String类型

- **HashMap**：作为Map的主要实现类，线程不安全，效率高；可以存储null的key和value

  - ​	**LinkedHashMap**：HashMap的子类，保证在遍历元素时按照添加的顺序遍历（原因：在HashMap底层结构的基础上，添加了一堆指针，指向前一个和后一个元素）对于频繁的遍历操作，**此类执行效率高于HashMap**

- **TreeMap**：保证按照添加的key-value对进行排序，实现排序遍历。此时考虑key的自然排序和定制排序。

  - 底层使用红黑树

    HashMap的底层：数组 + 链表（JDK7之前）

    ​										数组 + 链表 + 红黑树 （JDK8）

  

  

### Map结构

Map中的Key：无序的、不可重复的，使用Set存储所有key------>key要重写equals和hashCode方法（针对HashMap）

Map中的Value：无序的、可重复的，使用Collection存储所有的value------>value所在类需要存储equals

一个键值对：构成了一个Entry对象

Map中的Entry：无序的、不可重复的，使用Set存储所有的entry

### Map接口继承树



![image-20210828173019410](.\img\image-20210828173019410.png)

### 方法



## HashMap

```java
Map<Integer,String> map = new HashMap<>();

map.put(1,"admin1");
map.put(2,"admin2");
map.put(3,"admin3");
map.put(1,"test");//会覆盖

System.out.println(map.containsKey(1));//true
System.out.println(map.containsValue("admin2"));//true
System.out.println(map.isEmpty());//false
map.remove(2);//删除2
map.remove(2,"admin2");//删除同时满足2，admin2
System.out.println(map.get(1)); //test


Set set1 = map.keySet();//返回所有key构成的Set集合
Iterator iterator = set.iterator();
while(iterator.hasNext()){
    System.out.println(iterator.next());
}
Collection values = map.values();//返回所有values构成的Collection集合
for(Object obj : values){
    System.out.println(obj);
}

Set entrySet = map.entrySet();//返回所有key-value对构成的Set集合
Iterator iterator1 = entrySet.iterator();
while(iterator.hasNext()){
    Object obj = iterator.next();
    Map.Entry entry = (Map.Entry) obj;
    System.out.println(entry.getKey()+"  "+entry.getValues());
}

map.clear();//与map = null操作不同
System.out.println(map.size());//0


```



### HashMap的实现原理（JDK7）

HashMap map = new HashMap();

在实例化以后，底层创建了长度是16的一维数组，Entry[] table

...已经执行过多次put...

map.put(key1,value1);

首先，调用key1所在类的hashCode()计算key1哈希值，次哈希值经过某种计算后，得到在Entry数组中的存放位置。

如果此位置上的数据为空，此时的key1-value1添加成功。**---情况1**

如果此位置上的数据不为空（意味此位置上存在一个或多个数据（以链表形式存在）），比较当前的key1和已经存在的一个或多个数据的哈希值：

​				如果key1的哈希值与已经存在的数据的哈希值都不相同，此时key1-value1添加成功。    **---情况2**  

​				如果key1的哈希值与已经存在的某一个数据的哈希值都相同，继续比较：调用key1所在类的equals()方法，比较：

​						如果equals()返回false：此时key1-value1添加成功。**---情况3**

​						如果equals()返回true：使用value1替换value2。

情况2和情况3：此时的key1-value1和原来的数据以链表的形式存储

### JDK8相较于JDK7在底层实现方面的不同：

1. new HashMap()：底层没有创建一个长度为16的数组

2. JDK 8 底层的数组是：Node[]，而非Entry[]

3. 首次调用put()方法时，底层创建长度为16的数组

4. JDK 7 底层结构只有数组+链表，在JDK 8 中底层结构：数组+链表+红黑树

当数组的某一个索引位置上的元素以链表形式存在的数据个数 > 8 且 当前数组的长度 > 64时，此时索引位置上的所有数据改为使用红黑树存储。

## LinkedHashMap

其中Entry<K,V>继承了HashMap中的Node<K,V>，并且新增了Entry<K,V> before,after  能够记录添加元素的先后顺序。





## 题

1. HashMap的底层实现原理？
2. HashMap和Hashtable的异同？
3. CurrentHashMap  与  Hashtable的异同？（暂时不，涉及 ）

4. HashMap什么时候扩容？扩容方式？

   临界值threshold：min(capacity * 散列因子，MAXIMUM_CAPACITY+1)

   当超出临界值并且要存放的位置非空，扩容为原来容量的2倍

   首先将容量扩展为原来的2倍，然后需要重新计算所有数据的hash值，将数据复制到新扩展的数组里。

   >  散列因子（loadFactor）是干什么的（扩容）？初始值为多少（0.75）？

5. HashMap什么时候会出现链表？

   当两个key-value索要存放的位置位于同一个地方，并且key不相同，就会出现链表

   

