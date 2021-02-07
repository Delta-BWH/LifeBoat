import { Injectable } from '@angular/core';
import Backendless from 'backendless'

@Injectable()
export class DataService {
  saveTestObject(): Promise<Object> {
    return Backendless.Data.of('TestTable').save({ foo: 'bar' })
  }
}
