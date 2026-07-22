import { Injectable } from '@angular/core';
import { Course } from '../models/course.model';

@Injectable({
  providedIn: 'root'
})
export class CourseService 
{

  constructor() { }
  private courses: Course[] = [

      {
        id: 1,
        name: 'Angular',
        code: 'ANG101',
        credits: 4,
        gradeStatus: 'passed'
      },

      {
        id: 2,
        name: 'Spring Boot',
        code: 'SPR201',
        credits: 4,
        gradeStatus: 'pending'
      },

      {
        id: 3,
        name: 'Java',
        code: 'JAVA301',
        credits: 3,
        gradeStatus: 'passed'
      },

      {
        id: 4,
        name: 'SQL',
        code: 'SQL401',
        credits: 3,
        gradeStatus: 'failed'
      },

      {
        id: 5,
        name: 'Microservices',
        code: 'MIC501',
        credits: 5,
        gradeStatus: 'pending'
      }

    ];

    getCourses(): Course[] 
    {
      return this.courses;
    } 

    getCourseById(id: number): Course | undefined 
    {
      return this.courses.find(course => course.id === id);
    }

    addCourse(course: Course): void 
    {
      this.courses.push(course);
    }

}