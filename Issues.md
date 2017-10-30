Deployment
Background image was not showing up. 

Solution
- Use of asset_path to render image in stylesheets/full.css.erb
- background: url(<%= asset_path('coffee2.jpeg')%>) no-repeat center center fixed;
- ran $ rake assets:precompile 
- reference of solution and problem: 
https://stackoverflow.com/questions/14519997/actioncontrollerroutingerror-no-route-matches-get-assets-images-control-t