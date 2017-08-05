import React from 'react';
import sinon from 'sinon';
import { expect } from 'chai';
import { mount, shallow } from 'enzyme';

import App from './App';

describe('<App />', () => {
  it('calls componentDidMount', () => {
    sinon.spy(App.prototype, 'componentDidMount');
    const wrapper = mount(<App />);
    expect(App.prototype.componentDidMount).to.have.property('callCount', 1);
    App.prototype.componentDidMount.restore();
  });

});
describe('<App />', () => {
      it('Returns json file', (done) => {
        const wrapper = mount(<App />);
          setTimeout(() => {
            expect(wrapper.state().details).to.not.have.length(0);
            done();
         }, 3000);
       });
});
