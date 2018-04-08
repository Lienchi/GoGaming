 $(document).ready(function(){
      var tour = new Tour({
        storage: false,
        steps: [
        {
          element: "#demo",
          title: "Title of my step",
          content: "Content of my step"
          placement: "bottom"
        },
        {
          element: "#toggle",
          title: "Title of my step",
          content: "Content of my step"
          placement: "bottom"
        }
      ],});

      // Initialize the tour
      tour.init();

      // Start the tour
      tour.start();
      tour.restart()
    });     

