import { NgAppPage } from './app.po';

describe('Backendless Angular App', () => {
  let page: NgAppPage;

  beforeEach(() => {
    page = new NgAppPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
