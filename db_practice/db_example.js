import { DatabaseSync } from "node:sqlite";

const db = new DatabaseSync("students.db");

const detailsOfStudents = () => {
  const rows = db.prepare(
    `select * from students
    order by student_id;`,
  ).all();
  for (const { Student_Id, name, age } of rows) {
    console.log({ Student_Id, name, age });
  }
};

const getStudentDetailsWithId = () => {
  const id = prompt("enter student id :: ");
  const details = db.prepare(`select * from students
    where student_id = ?`);
  const { Student_Id, name, age } = details.get(id);
  console.log({ Student_Id, name, age });
};

const OPTIONS = {
  "details_of_students": detailsOfStudents,
  "get_student_details_with_id": getStudentDetailsWithId,
};

const main = () => {
  const displayOptions = {
    1: "details_of_students",
    2: "get_student_details_with_id",
  };
  console.log(displayOptions);
  const choice = prompt("enter your choice :: ");
  return OPTIONS[displayOptions[choice]]();
};

main();
