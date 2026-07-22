import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CourseService } from '../../services/course.service';
import { Course } from '../../models/course.model';
import { OnInit } from '@angular/core';
import { EnrollmentService } from '../../services/enrollment.service';
import { ActivatedRoute, Router } from '@angular/router';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-course-list',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './course-list.html',
  styleUrl: './course-list.css'
})

export class CourseList implements OnInit 
{
  today = new Date();
  portalName = 'student course portal';
  courseFee = 15000;
  courseRating = 4.56789;
  noCredits: number | null = null;
  searchTerm = '';

  courses: Course[] = [];

  constructor(
    private courseService: CourseService,
    public enrollmentService: EnrollmentService,
    private router: Router,
    private route: ActivatedRoute
  ) {}

  viewCourse(courseId: number): void {
    this.router.navigate(['courses', courseId]);
  }

  ngOnInit(): void {

    this.courses = this.courseService.getCourses();

    const search = this.route.snapshot.queryParamMap.get('search');

    if (search) 
      {
        this.searchTerm = search;
      }

  }

  updateSearch(): void {

    this.router.navigate(
      ['courses'],
      {
        queryParams: {
          search: this.searchTerm
        }
      }
    );

}

  toggleEnrollment(courseId: number): void 
  {
    if (this.enrollmentService.isEnrolled(courseId)) {
      this.enrollmentService.unenroll(courseId);
    } else {
      this.enrollmentService.enroll(courseId);
    }
  }

}