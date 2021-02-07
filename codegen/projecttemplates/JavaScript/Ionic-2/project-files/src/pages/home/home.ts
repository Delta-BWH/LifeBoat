import {Component, OnInit} from '@angular/core';
import {DataService} from '../../app/data.service'

import {NavController} from 'ionic-angular';

@Component({
  selector: 'page-home',
  templateUrl: 'home.html',
  providers: [DataService]
})
export class HomePage implements OnInit {
  message: string;

  error = null;

  loading = null;

  constructor(public navCtrl: NavController, private dataService: DataService) {

  }

  saveTestObject(): void {
    this.loading = true;

    this.dataService.saveTestObject()
        .then(object => {
          this.message = 'A data object has been saved in Backendless. Check \'TestTable\' in Backendless Console.';
          this.loading = false;
        })
        .catch(error => {
          this.error = error;
          this.loading = false;
        });
  }

  ngOnInit(): void {
    this.saveTestObject();
  }
}
