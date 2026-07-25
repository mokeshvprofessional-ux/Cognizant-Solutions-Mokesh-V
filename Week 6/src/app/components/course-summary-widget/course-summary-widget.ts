import { Component } from '@angular/core';
import { CourseService } from '../../services/course.service';
import { Course } from '../../models/course.model';

@Component({
  selector: 'app-course-summary-widget',
  imports: [],
  templateUrl: './course-summary-widget.html',
  styleUrl: './course-summary-widget.css',
})

export class CourseSummaryWidget {

  courses: Course[] = [];

  constructor(private courseService: CourseService) {

    this.courses = this.courseService.getCourses();

  }

  addDemoCourse(): void 
  {

    this.courseService.addCourse({
      id: 6,
      name: 'Docker',
      code: 'DOC601',
      credits: 3,
      gradeStatus: 'pending'
    });

    this.courses = this.courseService.getCourses();

  }

}
