(function (Drupal) {
  Drupal.behaviors.mobileMenuToggle = {
    attach: function (context) {
      // Get elements globally using document.querySelector
      // Support either an id or class-based toggle button
      const toggle = document.querySelector('#menu-toggle') || document.querySelector('.menu-btn');
      const menu = document.querySelector('#mobile-menu');
      const overlay = document.querySelector('.site-overlay');

      console.log('mobileMenuToggle attached');

      if (toggle && menu && overlay) {
        // Check if this has already been initialized (once-like behavior)
        if (!toggle.classList.contains('menu-bound')) {
          console.log('Attaching event listeners to toggle');

          toggle.classList.add('menu-bound');

          const openMenu = () => {
            const isOpen = menu.classList.toggle('is-active');
            toggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
            document.body.classList.toggle('menu-open', isOpen);
            overlay.classList.toggle('is-active', isOpen);
          };

          toggle.addEventListener('click', () => {
            console.log('Toggle button clicked'); // Add this line
            openMenu();
          });


          overlay.addEventListener('click', () => {
            menu.classList.remove('is-active');
            overlay.classList.remove('is-active');
            document.body.classList.remove('menu-open');
            toggle.setAttribute('aria-expanded', 'false');
          });

          // Close on Escape for accessibility
          document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && menu.classList.contains('is-active')) {
              menu.classList.remove('is-active');
              overlay.classList.remove('is-active');
              document.body.classList.remove('menu-open');
              toggle.setAttribute('aria-expanded', 'false');
              toggle.focus();
            }
          });
        }
      } else {
        console.warn('Mobile menu elements not found:', { toggle, menu, overlay });
      }
    }
  };
})(Drupal);
