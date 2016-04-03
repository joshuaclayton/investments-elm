function debounce(func, wait, immediate) {
  var timeout;
  return function() {
    var context = this, args = arguments;
    var later = function() {
      timeout = null;
      if (!immediate) func.apply(context, args);
    };
    var callNow = immediate && !timeout;
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
    if (callNow) func.apply(context, args);
  };
};

export default class GChartStackedBar {
  static run(fn) {
    google.charts.load('current', {'packages':['corechart']});

    const options = {
      legend: { position: "top", alignment: "end" },
      isStacked: true,
      height: 340,
      chartArea: { width: "88%", left: "12%", right: 20 },
      vAxis: {
        format: "currency",
      },
    };

    const drawChart = (chart, data, options) => {
      chart.draw(data, options);
    };

    let debouncedDraw;

    fn(payload => {
      google.charts.setOnLoadCallback(() => {
        window.removeEventListener("resize", debouncedDraw);

        const data = google.visualization.arrayToDataTable(JSON.parse(payload));
        const chart = new google.visualization.ColumnChart(document.getElementById('chart2'));

        debouncedDraw = debounce(() => drawChart(chart, data, options), 250);
        debouncedDraw();

        window.addEventListener("resize", debouncedDraw);
      });
    })
  }
}
