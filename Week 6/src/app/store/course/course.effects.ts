import { Injectable, inject } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { CourseApiService } from '../../services/course-api.service';
import * as CourseActions from './course.actions';
import { catchError, map, of, switchMap } from 'rxjs';

@Injectable()
export class CourseEffects {

  private actions$ = inject(Actions);
  private courseService = inject(CourseApiService);

  loadCourses$ = createEffect(() =>
    this.actions$.pipe(
      ofType(CourseActions.loadCourses),
      switchMap(() =>
        this.courseService.getCourses().pipe(
          map((courses: any[]) =>
            CourseActions.loadCoursesSuccess({
              courses: courses.slice(0, 5)
            })
          ),
          catchError(error =>
            of(
              CourseActions.loadCoursesFailure({
                error: error.message
              })
            )
          )
        )
      )
    )
  );
}