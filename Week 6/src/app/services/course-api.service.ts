import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Course } from '../models/course.model';

@Injectable({
  providedIn: 'root'
})
export class CourseApiService {

  private apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  constructor(private http: HttpClient) {}

  getCourses(): Observable<any[]> {
    return this.http.get<any[]>(this.apiUrl);
  }

  addCourse(course: any): Observable<any> 
  {
    return this.http.post(this.apiUrl, course);
  }

  updateCourse(id: number, course: any): Observable<any> 
  {
    return this.http.put(`${this.apiUrl}/${id}`, course);
  }

  deleteCourse(id: number): Observable<any> 
  {
    return this.http.delete(`${this.apiUrl}/${id}`);
  }

}