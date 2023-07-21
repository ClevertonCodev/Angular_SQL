import { Component, OnInit } from '@angular/core';
import { ApiService } from '../Services/ApiService';
import { Router } from '@angular/router';

@Component({
  selector: 'app-post-list',
  templateUrl: './post-list.component.html',
  styleUrls: ['./post-list.component.css']
})
export class PostListComponent implements OnInit {
  posts: any[] = [];
  currentPage = 1;
  itemsPerPage = 5;
  pagesToShow = 5;
  searchText = '';

  constructor(private postService: ApiService, private router: Router) {}

  ngOnInit() {
    this.loadPosts();
  }

  loadPosts() {
    this.postService.getPosts().subscribe((data: any[]) => {
      this.posts = data;
    });
  }

  get postsToDisplay() {
    const startIndex = (this.currentPage - 1) * this.itemsPerPage;
    const endIndex = this.currentPage * this.itemsPerPage;
    return this.posts
      .filter(post => post.title.toLowerCase().includes(this.searchText.toLowerCase()))
      .slice(startIndex, endIndex);
  }

  prevPage() {
    if (this.currentPage > 1) {
      this.currentPage--;
    }
  }

  nextPage() {
    if (this.currentPage < this.totalPages()) {
      this.currentPage++;
    }
  }

  searchPosts() {
    this.currentPage = 1;
  }

  totalPages() {
    return Math.ceil(this.posts.length / this.itemsPerPage);
  }

  showPostDetails(id: number) {
    this.router.navigate(['/post', id]);
  }

  pagesArray(): number[] {
    const totalPages = this.totalPages();
    const halfPagesToShow = Math.floor(this.pagesToShow / 2);
    let startPage = Math.max(1, this.currentPage - halfPagesToShow);
    let endPage = startPage + this.pagesToShow - 1;

    if (endPage > totalPages) {
      endPage = totalPages;
      startPage = Math.max(1, endPage - this.pagesToShow + 1);
    }

    return Array.from({ length: endPage - startPage + 1 }, (_, index) => index + startPage);
  }

  goToPage(page: number) {
    if (page >= 1 && page <= this.totalPages()) {
      this.currentPage = page;
    }
  }

}
