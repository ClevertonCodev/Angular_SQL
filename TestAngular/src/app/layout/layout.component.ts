import { Component, Input } from '@angular/core';
import { Location } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';
@Component({
  selector: 'app-layout',
  templateUrl: './layout.component.html',
  styleUrls: ['./layout.component.css']
})
export class LayoutComponent {
  @Input() title?: string = 'Página';

  constructor(private location: Location, private router: Router, private route: ActivatedRoute) {}

  goBack(): void {
    this.location.back();
  }
}
