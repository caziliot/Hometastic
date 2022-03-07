import flatpickr from "flatpickr";
import rangePlugin from "flatpickr/dist/plugins/";
import monthSelectPlugin from "flatpickr/dist/plugins/monthSelect";

const initFlatpickr = () => {
  flatpickr(".datepicker", {
    plugins: [
      new monthSelectPlugin({
        altInput:true,
        dateFormat: "d-m-Y", //defaults to "F Y"
        altFormat: "F Y", //defaults to "F Y"
        theme: "dark", // defaults to "light
        parseDate: true
      })
    ]
  });
}
const initFlatRange = () => {
  flatpickr(".flatpic", {
    plugins: [
      new rangePlugin({
        input: "#month_end"
      })
    ]
  });
}
export { initFlatpickr, initFlatRange };
