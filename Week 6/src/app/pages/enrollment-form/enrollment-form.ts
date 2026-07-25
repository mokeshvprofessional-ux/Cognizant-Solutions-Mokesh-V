import { FormsModule, NgForm } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';

@Component({
  selector: 'app-enrollment-form',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './enrollment-form.html',
  styleUrl: './enrollment-form.css'
})
export class EnrollmentForm {
  studentName = '';

studentEmail = '';

courseId!: number;

preferredSemester = '';

agreeToTerms = false;
submitted = false;

  onSubmit(form: NgForm) 
  {

    console.log(form.value);

    console.log(form.valid);

    this.submitted = true;

  }
}
