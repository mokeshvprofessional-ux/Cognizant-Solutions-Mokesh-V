import { Routes } from '@angular/router';
import { EnrollmentForm } from './pages/enrollment-form/enrollment-form';
import { ReactiveEnrollmentForm } from './pages/reactive-enrollment-form/reactive-enrollment-form';
import { CourseList } from './pages/course-list/course-list';
import { Home } from './pages/home/home';
import { StudentProfile } from './pages/student-profile/student-profile';
import { CourseDetail } from './pages/course-detail/course-detail';
import { NotFound } from './pages/not-found/not-found';
import { CoursesLayout } from './pages/courses-layout/courses-layout';
import { authGuard } from './guards/auth-guard';
import { unsavedChangesGuard } from './guards/unsaved-changes-guard'; 

export const routes: Routes = [

    {
        path: '',
        component: Home
    },

    {
        path: 'courses',
        component: CoursesLayout,
        children: [
            {
                path: '',
                component: CourseList
            },
            
            {
                path: ':id',
                component: CourseDetail
            }
        ]
    },

    {
        path: 'profile',
        component: StudentProfile,
        canActivate: [authGuard]
    },

    {
        path: 'enroll',
        canActivate: [authGuard],
        loadChildren: () =>
            import('./features/enrollment/enrollment-module')
            .then(m => m.EnrollmentModule)
    },

    {
        path: '**',
        component: NotFound
    },

    {
        path: 'enroll-reactive',
        component: ReactiveEnrollmentForm,
        canDeactivate: [unsavedChangesGuard]
    }

];