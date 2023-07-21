import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ApiService} from '../Services/ApiService';
import { Title } from '@angular/platform-browser';
@Component({
  selector: 'app-post-details',
  templateUrl: './post-details.component.html',
  styleUrls: ['./post-details.component.css']
})
export class PostDetailsComponent implements OnInit {
  post: any;

  constructor(
    private route: ActivatedRoute,
    private postService: ApiService,
    private titleService: Title
  ) {}

  ngOnInit() {
    this.route.params.subscribe(params => {
      const postId = +params['id'];
      this.postService.getPostById(postId).subscribe(data => {
        this.post = data;
      });
    });
    this.titleService.setTitle('Posts');
  }
}
