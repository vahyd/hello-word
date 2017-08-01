import React, { Component } from 'react';

import './App.css';
// process

class App extends Component {
  constructor(props){
      super(props)
      this.state= {numClicks: 0, data:"_blank"}

}
click(){
// const payload = {...}; // post call body
      var http = require('https');
      const options = {
          hostname: 'greatapi.azurewebsites.net',
          port: 443,
          path: '/api/PwProxy',
          method: 'post',
          headers : {},
          }; // post call settings

          console.log("Here!")
      const request = http.request(options, function(response: any) {
      console.log('STATUS: ' + response.statusCode);
      console.log('HEADERS: ' + JSON.stringify(response.headers));
      let stringResponse = '';
      response.setEncoding('utf8');
      response.on('data', (chunk) => stringResponse += chunk );
      response.on('end', function() {
      const body = JSON.parse(stringResponse);
      if (response.statusCode === 200) {
        console.log(body);
      } else {
        console.log("error");
      // error
      }
      });
      });
      // request.on('error', (error) => {
      // // error in the call
      // });
      // request.write(.JSON.stringify(payload));
      request.end();

}
render() {
 return  (
  <div>
      <button onClick={this.click.bind(this)}>Call API</button>
      // {this.state.numClicks} <br/>
      // {this.state.data}
  </div>
 );
}
}

export default App;
