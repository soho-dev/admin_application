module ApplicationHelper

  def application_status_class
    {"pending" => "warning", "approved" => "success", "rejected" => "danger"}
  end

  def bar_chart_data
    data = {}
    data[:series] =  {
          name: "Applications",
          colorByPoint: true,
          data: [
              {
                  name: "LA",
                  y: 62.74,
                  drilldown: "LA"
              },
              {
                  name: "Sacramento",
                  y: 10.57,
                  drilldown: "Sacramento"
              },
              {
                  name: "San Diego",
                  y: 7.23,
                  drilldown: "San Diego"
              },
              {
                  name: "Oakland",
                  y: 5.58,
                  drilldown: "Safari"
              },
              {
                  name: "Amador",
                  y: 4.02,
                  drilldown: "Amador"
              },
              {
                  name: "Other",
                  y: 7.62,
                  drilldown: nil
              }
          ]
      }
    data[:drilldown_series] = {
        name: "LA",
        id: "LA",
        data: [
            [
                "v65.0",
                0.1
            ],
            [
                "v64.0",
                1.3
            ],
            [
                "v63.0",
                53.02
            ],
            [
                "v62.0",
                1.4
            ],
            [
                "v61.0",
                0.88
            ],
            [
                "v60.0",
                0.56
            ],
            [
                "v59.0",
                0.45
            ],
            [
                "v58.0",
                0.49
            ],
            [
                "v57.0",
                0.32
            ],
            [
                "v56.0",
                0.29
            ],
            [
                "v55.0",
                0.79
            ],
            [
                "v54.0",
                0.18
            ],
            [
                "v51.0",
                0.13
            ],
            [
                "v49.0",
                2.16
            ],
            [
                "v48.0",
                0.13
            ],
            [
                "v47.0",
                0.11
            ],
            [
                "v43.0",
                0.17
            ],
            [
                "v29.0",
                0.26
            ]
        ]
    },
    {
        name: "Sacramento",
        id: "Sacramento",
        data: [
            [
                "v58.0",
                1.02
            ],
            [
                "v57.0",
                7.36
            ],
            [
                "v56.0",
                0.35
            ],
            [
                "v55.0",
                0.11
            ],
            [
                "v54.0",
                0.1
            ],
            [
                "v52.0",
                0.95
            ],
            [
                "v51.0",
                0.15
            ],
            [
                "v50.0",
                0.1
            ],
            [
                "v48.0",
                0.31
            ],
            [
                "v47.0",
                0.12
            ]
        ]
    },
    {
        name: "San Diego",
        id: "San Diego",
        data: [
            [
                "v11.0",
                6.2
            ],
            [
                "v10.0",
                0.29
            ],
            [
                "v9.0",
                0.27
            ],
            [
                "v8.0",
                0.47
            ]
        ]
    },
    {
        name: "Oakland",
        id: "Oakland",
        data: [
            [
                "v11.0",
                3.39
            ],
            [
                "v10.1",
                0.96
            ],
            [
                "v10.0",
                0.36
            ],
            [
                "v9.1",
                0.54
            ],
            [
                "v9.0",
                0.13
            ],
            [
                "v5.1",
                0.2
            ]
        ]
    },
    {
        name: "Amador",
        id: "Amador",
        data: [
            [
                "v16",
                2.6
            ],
            [
                "v15",
                0.92
            ],
            [
                "v14",
                0.4
            ],
            [
                "v13",
                0.1
            ]
        ]
    },
    {
        name: "Other",
        id: "Other",
        data: [
            [
                "v50.0",
                0.96
            ],
            [
                "v49.0",
                0.82
            ],
            [
                "v12.1",
                0.14
            ]
        ]
    }

    data
  end

  def piechart_data
    {
        name:'Brands',
        colorByPoint:true,
        data:[{
            name:'LA',
            y:61.41,
            sliced: true,
            selected: true
        }, {
            name:'Sacramento',
            y:11.84
        }, {
            name:'San Diego',
            y: 10.85
        }, {
            name:'Oakland',
            y: 4.67
        }, {
            name:'Amador',
            y: 4.18
        }, {
            name:'Alamada',
            y: 1.64
        }, {
            name:'Alaska',
            y: 1.6
        }, {
            name:'QQ',
            y: 1.2
        }, {
            name:'Other',
            y: 2.61
        }]
    }
  end
end
