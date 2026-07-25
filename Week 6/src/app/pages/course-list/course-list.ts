import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CourseService } from '../../services/course.service';
import { Course } from '../../models/course.model';
import { OnInit } from '@angular/core';
import { EnrollmentService } from '../../services/enrollment.service';
import { ActivatedRoute, Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { CourseApiService } from '../../services/course-api.service';
import { Store } from '@ngrx/store';
import { Observable } from 'rxjs';
import { loadCourses } from '../../store/course/course.actions';
import { selectAllCourses } from '../../store/course/course.selectors';

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
  errorMessage = '';

  courses$!: Observable<Course[]>;
  apiCourses: any[] = [];
  loading = false;

  constructor(
    private store : Store,
    public enrollmentService: EnrollmentService,
    private router: Router,
    private route: ActivatedRoute,
    private courseApiService: CourseApiService
  ) {}

  viewCourse(courseId: number): void {
    this.router.navigate(['courses', courseId]);
  }

  

  ngOnInit(): void {

  this.loading = true;
  this.errorMessage = '';

  this.courseApiService.getCourses().subscribe({
    next: (data) => {
      this.apiCourses = data.slice(0, 5);
      this.loading = false;
    },
    error: (err) => {
      console.error(err);
      this.loading = false;
      this.errorMessage = 'Unable to load courses. Please try again later.';
    }
  });

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

  addCourseToApi() 
  {
    const newCourse = {
      title: 'Angular Advanced',
      body: 'Student Course Portal',
      userId: 1
    };

    this.courseApiService.addCourse(newCourse).subscribe({
      next: (response) => {
        console.log('Course Added Successfully');
        console.log(response);
      },
      error: (err) => {
        console.error(err);
      }
    });
  }

  updateCourseInApi() 
  {
    const updatedCourse = {
      id: 1,
      title: 'Angular Updated',
      body: 'Updated Course Information',
      userId: 1
    };

    this.courseApiService.updateCourse(1, updatedCourse).subscribe({
      next: (response) => {
        console.log('Course Updated Successfully');
        console.log(response);
      },
      error: (err) => {
        console.error(err);
      }
    });
  }

  deleteCourseFromApi() 
  {
    this.courseApiService.deleteCourse(1).subscribe({
      next: () => {
        console.log('Course Deleted Successfully');
      },
      error: (err) => {
        console.error(err);
      }
    });
  }

}