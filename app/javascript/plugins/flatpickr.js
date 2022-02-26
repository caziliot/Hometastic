import flatpickr from "flatpickr";

const initFlatpickr = () => {

  flatpickr(".datepicker", {
    plugins: [
      new monthSelectPlugin({
        shorthand: true, //defaults to false
        dateFormat: "m.y", //defaults to "F Y"
        altFormat: "F Y", //defaults to "F Y"
        theme: "dark" // defaults to "light"
      })
    ]
  });
}

export { initFlatpickr };
