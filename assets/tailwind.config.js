module.exports = {
  content: ["./assets/js/**/*.js", "./lib/*_web.ex", "./lib/*_web/**/*.*ex"],

  plugins: [require("@tailwindcss/forms")],

  theme: {
    extend: {},
  },
};
