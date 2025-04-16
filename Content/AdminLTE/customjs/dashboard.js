//ajax piechart by category
    $.ajax({
        url: 'ComplaintCategoryData.ashx',
        type: 'GET',
        dataType: 'json',
        success: function (data) {
            // data is an array of { category: "", total: number }
            console.log(data);
            loadPieChart(data); // your function to build the chart
        },
        error: function (xhr, status, error) {
            console.error("Error loading chart data", error);
        }
    });
    function loadPieChart(data) {
        const labels = data.map(d => d.category);
        const totals = data.map(d => d.total);

        const ctx = document.getElementById("pieChart").getContext("2d");
        new Chart(ctx, {
            type: 'pie',
            data: {
                labels: labels,
                datasets: [{
                    data: totals,
                    backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56'] // example colors
                }]
            }
        });
    }
