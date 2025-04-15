# PostgreSQL Database Concepts

## 1. What is PostgreSQL?

postgres একটি অ্যাডভান্স ওপেন সোর্স রিলেশনাল ডেটাবেস ম্যানেজমেন্ট সিস্টেম।

## 2. What is the purpose of a database schema in PostgreSQL?

postgreSQL এ database schema হল ডেটাবেসের table, view, index, function ইত্যাদির জন্য একটি লজিকাল কন্টেনার যা ডাটাবেসকে অর্গানাইজ, ম্যানেজ ও মেন্টেন্ট করতে সাহায্য করে.

## 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL

### Primary Key এর কিছু বৈশিষ্ট:

-
- একটি বা একাধিক কলামের সেট যা প্রত্যেক row কে uniquely identify করতে সাহায্য করে।
- NULL value হতে পারবে না
- অটোমেটিকলি ইনডেক্স করে যার ফলে কুয়েরই আরও ফাস্ট হয়।

### Foreign Key এর কিছু বৈশিষ্ট:

- একটি বা একাধিক কলামের সেট জা অন্য একটি টেবিলের প্রাইমারি কি কে রেফার করে
- দুইটি টেবিলের মধ্যে সম্পর্ক তৈরি করে।

## 4. What is the difference between the VARCHAR and CHAR data types?

| VARCHAR                                                              | CHAR                                                              |
| -------------------------------------------------------------------- | ----------------------------------------------------------------- |
| character string এর লেন্থ ভ্যারিয়েবল হয়                              | character string এর লেন্থ ফিক্সড                                  |
| শুধুমাত্র ইউজারের দেয়া ইনপুট স্টোর করে                              | shorter strings কে defined length অনুযায়ী spaces দিয়ে পুর্ন করে |
| variable-length data এর জন্য storage সেভ করে রাখে                    | ফিক্সড লেন্থ কে ব্যবহার করে ফ্যাল                                 |
| Example: VARCHAR(50) for "hello" শুধুমাত্র ৫ টি ক্যারেকটার স্টোর করে | Example: CHAR(50) for "hello" ৫০ টি ক্যারেক্টার ই স্টোর করে       |

## 5. Explain the purpose of the WHERE clause in a SELECT statement

SELECT statement এ WHERE clause কন্ডিশন এর আপের ভিত্তি করে ডাটা ফিল্টার করে । এর মাধ্যমে:

- যে সকল রো কন্ডিশন ফুলফিল করে সেসকল রো এর ডাটা বের করা যায়
- logical operators (AND, OR, NOT) ব্যবহার করা যায়
- comparison operators (<, >, =, !=, etc.) ব্যবহার করা যায়
- NULL values টেস্ট করা যায়

## 6. What are the LIMIT and OFFSET clauses used for?

- **LIMIT**: কোনো কোয়েরি থেকে সর্বোচ্চ কত গুলো রো রিটার্ন করবে তা নির্ধারণ করা যায়
- **OFFSET**: কুয়েরি থেকে রো রিটার্ন করা শুরুর পূর্বে কতগুলো রো স্কিপ করতে হবে তা নির্ধারণ করে

Example: `SELECT * FROM employees LIMIT 10 OFFSET 20;` ২১ তম রো থেকে ১০ টা রো রিটার্ন করবে।

## 7. How can you modify data using UPDATE statements?

```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

Key points:

- SET clause এর মাধ্যমে কোন কলাম আপডেট করতে হবে এবং তাদের ভ্যালু নির্ধারণ করা হয়।
- WHERE clause এর মাধমে কোন র আপডেট করতে হবে তা নির্ধারণ কড়া হয়
- WHERE clause না দিলে সকল রো আপডেট হয়ে যাবে।

## 8. What is the significance of the JOIN operation, and how does it work in PostgreSQL?

JOIN operations রিলেশনাল ডেটাবেসে দুই বা ততোধিক টেবিল কে সংযুক্ত করে তাদের রিলেটেড কলামের মাধ্যমে

বিভিন্ন ধরনের JOIN অপারেশন:

- **INNER JOIN**: শুধুমাত্র ম্যাচিং রো গুলো রিটার্ন করে
- **LEFT JOIN**: বাম টেবিলের সকল রো এবং ডান টেবিলের শুধুমাত্র ম্যাচিং রো গুলো রিটার্ন করে
- **RIGHT JOIN**: ডান টেবিলের সকল রো এবং বাম টেবিলের শুধুমাত্র ম্যাচিং রো গুলো রিটার্ন করে
- **FULL JOIN**: ম্যাচ করলেই সকল কিছু রিটার্ন করে দেয়
- **CROSS JOIN**: দুই table এর Cartesian product রিটার্ন করে

## 9. Explain the GROUP BY clause and its role in aggregation operations

- রেজাল্ট কে স্পেসিফায়েড কলামের উপর ভিত্তি করে গ্রুপ এ বিভক্ত করে
- aggregate functions ব্যবহার করে calculations করার জন্য ব্যবহৃত হয়।

Example: `SELECT department, COUNT(*) FROM employees GROUP BY department;`

## 10. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?

- **COUNT()**: টোটাল রো এর সংখ্যা বের করতে ব্যবহার হয়

  ```sql
  SELECT COUNT(*) FROM orders;
  SELECT COUNT(order_id) FROM orders;
  ```

- **SUM()**: numeric column এর total value ক্যালকুলেট করতে ব্যবহার হয়

  ```sql
  SELECT SUM(amount) FROM payments;
  ```

- **AVG()**: numeric column এর এভারেজ ক্যালকুলেট করতে ব্যবহার হয়
  ```sql
  SELECT AVG(salary) FROM employees;
  ```

ডাটার গ্রুপের (GROUP BY ) উপর ক্যালকুলেশন চালাতে এসকল function ব্যবহার হয়

```sql
SELECT department, AVG(salary) AS avg_salary, SUM(salary) AS total_salary, COUNT(*) AS employee_count
FROM employees
GROUP BY department;
```
