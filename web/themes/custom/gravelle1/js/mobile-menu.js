(function (Drupal) {
  Drupal.behaviors.mobileMenuToggle = {
    attach: function (context) {
      // Get elements globally using document.querySelector
      const toggle = document.querySelector('#menu-toggle');
      const menu = document.querySelector('#mobile-menu');
      const overlay = document.querySelector('.site-overlay');

      console.log('mobileMenuToggle attached');

      if (toggle && menu && overlay) {
        // Check if this has already been initialized (once-like behavior)
        if (!toggle.classList.contains('menu-bound')) {
          console.log('Attaching event listeners to toggle');

          toggle.classList.add('menu-bound');

          toggle.addEventListener('click', () => {
            console.log('Toggle button clicked'); // Add this line
            const isOpen = menu.classList.toggle('is-active');
            toggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
            document.body.classList.toggle('menu-open', isOpen);
            overlay.classList.toggle('is-active', isOpen);
          });


          overlay.addEventListener('click', () => {
            menu.classList.remove('is-active');
            overlay.classList.remove('is-active');
            document.body.classList.remove('menu-open');
            toggle.setAttribute('aria-expanded', 'false');
          });
        }
      } else {
        console.warn('Mobile menu elements not found:', { toggle, menu, overlay });
      }
    }
  };
})(Drupal);
