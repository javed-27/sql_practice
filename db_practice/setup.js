import { DatabaseSync } from "node:sqlite";
const db = new DatabaseSync("students.db");

db.exec(`
  CREATE TABLE  IF NOT EXISTS students (
Student_Id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT,
age INTEGER
);
`);

const insert = db.prepare(`
  INSERT INTO students (name,age)
VALUES (?,?);
  `);

insert.run("ram", 27);

const rows = db.prepare(` SELECT * FROM students`).all();

for (const { Student_Id, name, age } of rows) {
  console.log(Student_Id, name, age);
}
