import { TestBed } from '@angular/core/testing';

import { CourseApi } from './course-api.service';

describe('CourseApi', () => {
  let service: CourseApi;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(CourseApi);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
