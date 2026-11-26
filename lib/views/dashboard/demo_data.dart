/// Sample teachers and classes copied from the Figma design.
/// There is no backend yet. Replace these lists with real data later.
class DemoTeacher {
  const DemoTeacher({
    required this.name,
    required this.qualification,
    required this.subject,
    required this.detail,
  });

  final String name;
  final String qualification;
  final String subject;
  final String detail;
}

class DemoClass {
  const DemoClass({
    required this.subject,
    required this.title,
    required this.detail,
  });

  final String subject;
  final String title;
  final String detail;
}

const demoTeachers = [
  DemoTeacher(
    name: 'Tanka Prasad',
    qualification: 'M.Sc.Ed. (Master of Science in Education) in Chemistry',
    subject: 'Chemistry',
    detail: '★ 4.8 · Weekdays after 4pm',
  ),
  DemoTeacher(
    name: 'Raj Shah',
    qualification: 'M.Ed English Literature',
    subject: 'English',
    detail: '★ 4.8 · 7pm sharp',
  ),
  DemoTeacher(
    name: 'Sita',
    qualification: 'Experienced subject mentor',
    subject: 'Mathematics',
    detail: '★ 4.8 · Contact for availability',
  ),
];

const demoClasses = [
  DemoClass(
    subject: 'Mathematics',
    title: 'A-Level Mathematics Masterclass',
    detail: 'Mentora teacher · Rs. 1500',
  ),
];