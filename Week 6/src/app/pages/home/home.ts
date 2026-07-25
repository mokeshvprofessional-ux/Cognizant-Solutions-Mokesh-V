import { Component, Input, Output, EventEmitter } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { CourseService } from '../../services/course.service';
import { CourseSummaryWidget } from '../../components/course-summary-widget/course-summary-widget';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, FormsModule, CourseSummaryWidget],
  templateUrl: './home.html',
  styleUrl: './home.css'
})
export class Home 
{
  constructor(
  private courseService: CourseService
  ) {}

  @Input() portalName = '';

  @Output() enrollClicked = new EventEmitter<string>();

  searchTerm = '';
  message = '';
  isPortalActive = true;
  coursesAvailable = true;
  courses = [
  'Angular',
  'Java',
  'Spring Boot',
  'SQL'
  ];

  status = 'Active';
  isActive = true;
  studentName = 'mokesh';
  today = new Date();
  courseFee = 4999.99;
  attendance = 0.92;
  
  get courseCount(): number 
  {
    return this.courseService.getCourses().length;
  }

  onEnrollClick() {
    this.message = 'Enrollment opened successfully!';
    this.enrollClicked.emit('Student clicked Enroll');
  }
}