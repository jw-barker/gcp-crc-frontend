// Ensure the entire script runs only when the DOM is fully loaded
window.addEventListener('load', () => {
  console.log('DOM fully loaded. Starting animations and visitor count fetch...');

  // Animation code with null checks
  var select = function(s) {
      return document.querySelector(s);
  }

  function randomBetween(min, max) {
      return Math.floor(Math.random() * (max - min + 1) + min) || 0.5;
  }

  var tl = new TimelineMax();

  for (var i = 0; i < 20; i++) {
      var bubble = select('.bubble' + i);
      if (!bubble) {
          console.warn(`Bubble element .bubble${i} not found. Skipping animation.`); // Prevent null error
          continue; // Skip this animation if the element is not found
      }
      
      var t = TweenMax.to(bubble, randomBetween(1, 1.5), {
          x: randomBetween(12, 15) * randomBetween(-1, 1),
          y: randomBetween(12, 15) * randomBetween(-1, 1),
          repeat: -1,
          repeatDelay: randomBetween(0.2, 0.5),
          yoyo: true,
          ease: Elastic.easeOut.config(1, 0.5)
      });
      tl.add(t, (i + 1) / 0.6);
  }

  tl.seek(50);

  // Visitor Counter Integration via API Gateway
  async function fetchVisitorCount() {
      console.log('Script loaded: fetchVisitorCount called'); // Step 1: Verify function is called

      try {
          const apiUrl = 'https://visitor-counter-gateway-1ovutoa0.ts.gateway.dev/visit';
          
          console.log('Preparing to make API request to:', apiUrl); // Step 2: Check if API call is prepared
          
          const response = await fetch(apiUrl, {
              method: 'GET',
              headers: {
                  'Accept': 'application/json'
              }
          });
          
          if (!response.ok) {
              throw new Error(`HTTP error! Status: ${response.status}`);
          }

          const data = await response.json();
          console.log('Visitor Count received from API:', data.count); // Step 3: Check if data is received

          const visitorElement = document.getElementById('visitorCount');
          if (!visitorElement) {
              console.error('Error: Element with ID "visitorCount" not found'); // Step 4: Element check
              return;
          }

          visitorElement.textContent = data.count;
          console.log('Visitor count updated on the page'); // Step 5: DOM update confirmation

      } catch (error) {
          console.error('Error fetching visitor count:', error);
          const visitorElement = document.getElementById('visitorCount');
          if (visitorElement) {
              visitorElement.textContent = 'Error loading count';
          }
      }
  }

  // Call the visitor count function once the DOM is fully loaded
  fetchVisitorCount();
});
