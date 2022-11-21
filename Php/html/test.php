
<!DOCTYPE html>
<html>
<head>
  <!-- Standard Meta -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

  <!-- Site Properties -->
  <title>Sticky Example - Semantic</title>

  <link rel="stylesheet" type="text/css" href="semantic-ui/components/reset.css">
  <link rel="stylesheet" type="text/css" href="semantic-ui/components/site.css">

  <link rel="stylesheet" type="text/css" href="semantic-ui/components/container.css">
  <link rel="stylesheet" type="text/css" href="semantic-ui/components/grid.css">
  <link rel="stylesheet" type="text/css" href="semantic-ui/components/header.css">
  <link rel="stylesheet" type="text/css" href="semantic-ui/components/image.css">
  <link rel="stylesheet" type="text/css" href="semantic-ui/components/menu.css">

  <link rel="stylesheet" type="text/css" href="semantic-ui/components/divider.css">
  <link rel="stylesheet" type="text/css" href="semantic-ui/components/list.css">
  <link rel="stylesheet" type="text/css" href="semantic-ui/components/segment.css">
  <link rel="stylesheet" type="text/css" href="semantic-ui/components/dropdown.css">
  <link rel="stylesheet" type="text/css" href="semantic-ui/components/icon.css">
  <link rel="stylesheet" type="text/css" href="semantic-ui/components/transition.css">

  <script src="assets/library/jquery.min.js"></script>
  <script src="semantic-ui/components/transition.js"></script>
  <script src="semantic-ui/components/dropdown.js"></script>
  <script src="semantic-ui/components/visibility.js"></script>
  <script>
  $(document)
    .ready(function() {

      // fix main menu to page on passing
      $('.main.menu').visibility({
        type: 'fixed'
      });
      $('.overlay').visibility({
        type: 'fixed',
        offset: 80
      });

      // lazy load images
      $('.image').visibility({
        type: 'image',
        transition: 'vertical flip in',
        duration: 500
      });

      // show dropdown on hover
      $('.main.menu  .ui.dropdown').dropdown({
        on: 'hover'
      });
    })
  ;
  </script>

  <style type="text/css">

  body {
    background-color: #FFFFFF;
  }
  .main.container {
    margin-top: 2em;
  }

  .main.menu {
    margin-top: 4em;
    border-radius: 0;
    border: none;
    box-shadow: none;
    transition:
      box-shadow 0.5s ease,
      padding 0.5s ease
    ;
  }
  .main.menu .item img.logo {
    margin-right: 1.5em;
  }

  .overlay {
    float: left;
    margin: 0em 3em 1em 0em;
  }
  .overlay .menu {
    position: relative;
    left: 0;
    transition: left 0.5s ease;
  }

  .main.menu.fixed {
    background-color: #FFFFFF;
    border: 1px solid #DDD;
    box-shadow: 0px 3px 5px rgba(0, 0, 0, 0.2);
  }
  .overlay.fixed .menu {
    left: 800px;
  }

  .text.container .left.floated.image {
    margin: 2em 2em 2em -4em;
  }
  .text.container .right.floated.image {
    margin: 2em -4em 2em 2em;
  }

  .ui.footer.segment {
    margin: 5em 0em 0em;
    padding: 5em 0em;
  }
  </style>

</head>
<body>
</body>


<button class="ui loading button">Loading</button>
<button class="ui basic loading button">Loading</button>
<button class="ui primary loading button">Loading</button>


</html>
