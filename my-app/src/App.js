import React, { Component } from 'react';

import './App.css';
import itemPreview from './itemPreview'
import JsonTable  from 'react-json-table'

// process

class App extends Component {
  constructor(props){
      super(props)
      this.state= {count: 0, details:[]}
      // this.clickHandler = this.clickHandler.bind(this)

}
// clickHandler(){
componentDidMount(){
      var self = this
      const payload = {
      "path": ["getPortfolioList"]
      };
      var http = require('https');
      const options = {
          hostname: 'greatapi.azurewebsites.net',
          port: 443,
          path: '/api/PwProxy',
          method: 'post',
          headers : {'content-type': 'application/json',
                'Content-Length': Buffer.byteLength(JSON.stringify(payload))},
          }; // post call settings


      const request = http.request(options, function(response: any) {
      console.log('STATUS: ' + response.statusCode);
      console.log('HEADERS: ' + JSON.stringify(response.headers));
      let stringResponse = '';
      response.setEncoding('utf8');
      response.on('data', (chunk) => stringResponse += chunk );
      response.on('end', function() {
      const body = JSON.parse(stringResponse);
      if (response.statusCode === 200) {
      var items = body
      self.setState({details:items})
      console.log(body);
      } else {
        console.log("error");
      // error
      }
      });
      });
      request.write(JSON.stringify(payload));
      request.end();
      this.setState({count:this.state.count + 1})

}
render() {
 return  (
  <div>

    <div><JsonTable rows={this.state.details}  /></div>
  </div>
 );
}
}

export default App;
