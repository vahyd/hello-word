import React from 'react'

const itemPreview = (item) => (
  <div className ="itemPreview">
    <div>

      {item.ID}
    </div>
      {item.abbreviation}
  </div>

);


export default itemPreview;
