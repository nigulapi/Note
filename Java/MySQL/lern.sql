/*
SQLyog Enterprise v12.09 (64 bit)
MySQL - 5.5.40 : Database - tylg
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`tylg` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `tylg`;

/*Table structure for table `dept` */

DROP TABLE IF EXISTS `dept`;

CREATE TABLE `dept` (
  `deptno` int(11) NOT NULL AUTO_INCREMENT,
  `dname` varchar(14) DEFAULT NULL,
  `loc` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`deptno`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

/*Data for the table `dept` */

insert  into `dept`(`deptno`,`dname`,`loc`) values (10,'ACCOUNTING','NEW YORK'),(20,'RESEARCH','DALLAS'),(30,'SALES','CHICAGO'),(40,'OPERATIONS','BOSTON');

/*Table structure for table `emp` */

DROP TABLE IF EXISTS `emp`;

CREATE TABLE `emp` (
  `empno` int(11) NOT NULL AUTO_INCREMENT,
  `ename` varchar(10) DEFAULT NULL,
  `job` varchar(9) DEFAULT NULL,
  `mgr` int(11) DEFAULT NULL,
  `hiredate` datetime DEFAULT NULL,
  `sal` int(11) DEFAULT NULL,
  `comm` int(11) DEFAULT NULL,
  `deptno` int(11) DEFAULT NULL,
  PRIMARY KEY (`empno`),
  KEY `fk_emp_dept` (`deptno`),
  CONSTRAINT `fk_emp_dept` FOREIGN KEY (`deptno`) REFERENCES `dept` (`deptno`)
) ENGINE=InnoDB AUTO_INCREMENT=7935 DEFAULT CHARSET=utf8;

/*Data for the table `emp` */

insert  into `emp`(`empno`,`ename`,`job`,`mgr`,`hiredate`,`sal`,`comm`,`deptno`) values (7369,'SMITH','CLERK',7902,'1980-12-17 00:00:00',800,NULL,20),(7499,'ALLEN','SALESMAN',7698,'1981-02-20 00:00:00',1600,300,30),(7521,'WARD','SALESMAN',7698,'1981-02-22 00:00:00',1250,500,30),(7566,'JONES','MANAGER',7839,'1981-04-02 00:00:00',2975,NULL,20),(7654,'MARTIN','SALESMAN',7698,'1981-09-28 00:00:00',1250,1400,30),(7698,'BLAKE','MANAGER',7839,'1981-05-01 00:00:00',2850,NULL,30),(7782,'CLARK','MANAGER',7839,'1981-06-09 00:00:00',2450,NULL,10),(7788,'SCOTT','ANALYST',7566,'1987-04-19 00:00:00',3000,NULL,20),(7839,'KING','PRESIDENT',NULL,'1981-11-17 00:00:00',5000,NULL,10),(7844,'TURNER','SALESMAN',7698,'1981-09-08 00:00:00',1500,0,30),(7876,'ADAMS','CLERK',7788,'1987-05-23 00:00:00',1100,NULL,20),(7900,'JAMES','CLERK',7698,'1981-12-03 00:00:00',950,NULL,30),(7902,'FORD','ANALYST',7566,'1981-12-03 00:00:00',3000,NULL,20),(7934,'MILLER','CLERK',7782,'1982-01-23 00:00:00',1300,NULL,10);

/*Table structure for table `salgrade` */

DROP TABLE IF EXISTS `salgrade`;

CREATE TABLE `salgrade` (
  `grade` int(11) DEFAULT NULL,
  `losal` int(11) DEFAULT NULL,
  `hisal` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `salgrade` */

insert  into `salgrade`(`grade`,`losal`,`hisal`) values (1,700,1200),(2,1201,1400),(3,1401,2000),(4,2001,3000),(5,3001,9999);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
