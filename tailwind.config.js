module.exports = {
    content: [
      './app/helpers/**/*.rb',
      './app/javascript/**/*.js',
      './app/javascript/**/*.jsx',
      './app/views/**/*.{erb,haml,html,slim}',
    ],
    theme: {
      extend: {
        colors: {
          'hot-pink': {
            DEFAULT: '#FF69B4', // Hot Pink
            light: '#FFB8D9',
            dark: '#E0368C',
          },
        },
      },
    },
    plugins: [
      require('@tailwindcss/forms'),
      require('@tailwindcss/typography'),
    ],
  }
  