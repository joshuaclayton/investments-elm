require("./styles/app.scss");
import GChartStackedBar from "./gcharts";

const Elm = require("./Main");
const app = Elm.embed(
  Elm.Main,
  document.getElementById("main"),
  { swap: false, setCurrentYear: 0 }
);

app.ports.setCurrentYear.send((new Date()).getFullYear() - 1);

GChartStackedBar.run(app.ports.yearlyContributionsSignal.subscribe);
