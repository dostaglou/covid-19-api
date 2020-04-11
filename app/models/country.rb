class Country < ApplicationRecord

  REGIONS =
  ["NORTH AMERICA", "EU", "EAST ASIA"]


  NORTH_AMERICA =
  ["USA", "Canada", "Mexico"]

  EU =
  ["Austria", "Italy", "Belgium", "Latvia", "Bulgaria", "Lithuania", "Croatia",
    "Luxembourg", "Cyprus", "Malta", "Czechia", "Netherlands", "Denmark",
    "Poland", "Estonia", "Portugal", "Finland", "Romania", "France",
    "Slovakia", "Germany", "Slovenia", "Greece", "Spain", "Hungary",
    "Sweden", "Ireland"
    ]

  EAST_ASIA =
  ["Hong Kong", "Singapore", "Japan", "Taiwan", "Mongolia", "S. Korea"]

  COUNTRY_NAMES =
  ["USA", "Italy", "Spain", "Germany", "Iran", "France", "UK", "Switzerland",
    "Belgium", "Netherlands", "S. Korea", "Austria", "Turkey", "Portugal",
    "Canada", "Norway", "Israel", "Brazil", "Australia", "Sweden", "Czechia",
    "Malaysia", "Ireland", "Denmark", "Chile", "Luxembourg", "Poland",
    "Romania", "Ecuador", "Japan", "Russia", "Pakistan", "Philippines",
    "Thailand", "Saudi Arabia", "Indonesia", "Finland", "South Africa",
    "Greece", "India", "Iceland", "Mexico", "Panama", "Singapore",
    "Dominican Republic", "Peru", "Argentina", "Croatia", "Serbia", "Slovenia",
    "Estonia", "Diamond Princess", "Colombia", "Hong Kong", "Qatar", "UAE",
    "Egypt", "New Zealand", "Iraq", "Morocco", "Bahrain", "Algeria",
    "Lithuania", "Armenia", "Ukraine", "Hungary", "Lebanon", "Latvia",
    "Bosnia and Herzegovina", "Bulgaria", "Slovakia", "Andorra", "Costa Rica",
    "Tunisia", "Taiwan", "Uruguay", "Kazakhstan", "North Macedonia",
    "Azerbaijan", "Kuwait", "Moldova", "Jordan", "San Marino", "Albania",
    "Burkina Faso", "Cyprus", "Vietnam", "Réunion", "Oman", "Faeroe Islands",
    "Ivory Coast", "Senegal", "Malta", "Ghana", "Belarus", "Uzbekistan",
    "Channel Islands", "Cameroon", "Cuba", "Honduras", "Venezuela", "Brunei",
    "Sri Lanka", "Afghanistan", "Palestine", "Nigeria", "Mauritius", "Cambodia",
    "Guadeloupe", "Georgia", "Bolivia", "Kyrgyzstan", "Martinique",
    "Montenegro", "Mayotte", "DRC", "Trinidad and Tobago", "Rwanda",
    "Gibraltar", "Paraguay", "Liechtenstein", "Kenya", "Aruba", "Bangladesh",
    "Monaco", "Isle of Man", "French Guiana", "Madagascar", "Macao",
    "Guatemala", "French Polynesia", "Zambia", "Jamaica", "Barbados", "Uganda",
    "Togo", "El Salvador", "Mali", "Ethiopia", "Niger", "Bermuda", "Congo",
    "Tanzania", "Djibouti", "Maldives", "Guinea", "Saint Martin", "Haiti",
    "New Caledonia", "Bahamas", "Myanmar", "Cayman Islands",
    "Equatorial Guinea", "Eritrea", "Mongolia", "Dominica", "Namibia",
    "Greenland", "Syria", "Grenada", "Saint Lucia", "Eswatini", "Curaçao",
    "Guyana", "Laos", "Libya", "Mozambique", "Seychelles", "Suriname", "Angola",
    "Gabon", "Zimbabwe", "Antigua and Barbuda", "Saint Kitts and Nevis",
    "Sudan", "Cabo Verde", "Benin", "Vatican City", "Sint Maarten", "Nepal",
    "Fiji", "Mauritania", "Montserrat", "St. Barth", "Gambia", "Nicaragua",
    "Bhutan", "Turks and Caicos", "CAR", "Chad", "Liberia", "Somalia",
    "MS Zaandam", "Anguilla", "Belize", "British Virgin Islands",
    "Guinea-Bissau", "Papua New Guinea", "St. Vincent Grenadines",
    "Timor-Leste", "China", "Botswana", "Sierra Leone", "Burundi",
    "Caribbean Netherlands"]

  POPULATIONS =
  [
    {
      "country": "Aruba",
      "pop": 104822
    },
    {
      "country": "Afghanistan",
      "pop": 34656032
    },
    {
      "country": "Angola",
      "pop": 28813463
    },
    {
      "country": "Albania",
      "pop": 2876101
    },
    {
      "country": "Andorra",
      "pop": 77281
    },
    {
      "country": "Arab World",
      "pop": 406452690
    },
    {
      "country": "United Arab Emirates",
      "pop": 9269612
    },
    {
      "country": "Argentina",
      "pop": 43847430
    },
    {
      "country": "Armenia",
      "pop": 2924816
    },
    {
      "country": "American Samoa",
      "pop": 55599
    },
    {
      "country": "Antigua and Barbuda",
      "pop": 100963
    },
    {
      "country": "Australia",
      "pop": 24127159
    },
    {
      "country": "Austria",
      "pop": 8747358
    },
    {
      "country": "Azerbaijan",
      "pop": 9762274
    },
    {
      "country": "Burundi",
      "pop": 10524117
    },
    {
      "country": "Belgium",
      "pop": 11348159
    },
    {
      "country": "Benin",
      "pop": 10872298
    },
    {
      "country": "Burkina Faso",
      "pop": 18646433
    },
    {
      "country": "Bangladesh",
      "pop": 162951560
    },
    {
      "country": "Bulgaria",
      "pop": 7127822
    },
    {
      "country": "Bahrain",
      "pop": 1425171
    },
    {
      "country": "Bahamas",
      "pop": 391232
    },
    {
      "country": "Bosnia and Herzegovina",
      "pop": 3516816
    },
    {
      "country": "Belarus",
      "pop": 9507120
    },
    {
      "country": "Belize",
      "pop": 366954
    },
    {
      "country": "Bermuda",
      "pop": 65331
    },
    {
      "country": "Bolivia",
      "pop": 10887882
    },
    {
      "country": "Brazil",
      "pop": 207652865
    },
    {
      "country": "Barbados",
      "pop": 284996
    },
    {
      "country": "Brunei Darussalam",
      "pop": 423196
    },
    {
      "country": "Bhutan",
      "pop": 797765
    },
    {
      "country": "Botswana",
      "pop": 2250260
    },
    {
      "country": "Central African Republic",
      "pop": 4594621
    },
    {
      "country": "Canada",
      "pop": 36286425
    },
    {
      "country": "Switzerland",
      "pop": 8372098
    },
    {
      "country": "Channel Islands",
      "pop": 164541
    },
    {
      "country": "Chile",
      "pop": 17909754
    },
    {
      "country": "China",
      "pop": 1378665000
    },
    {
      "country": "Cote d'Ivoire",
      "pop": 23695919
    },
    {
      "country": "Cameroon",
      "pop": 23439189
    },
    {
      "country": "Congo, Dem. Rep.",
      "pop": 78736153
    },
    {
      "country": "Congo, Rep.",
      "pop": 5125821
    },
    {
      "country": "Colombia",
      "pop": 48653419
    },
    {
      "country": "Comoros",
      "pop": 795601
    },
    {
      "country": "Cabo Verde",
      "pop": 539560
    },
    {
      "country": "Costa Rica",
      "pop": 4857274
    },
    {
      "country": "Caribbean small states",
      "pop": 7245472
    },
    {
      "country": "Cuba",
      "pop": 11475982
    },
    {
      "country": "Curacao",
      "pop": 159999
    },
    {
      "country": "Cayman Islands",
      "pop": 60765
    },
    {
      "country": "Cyprus",
      "pop": 1170125
    },
    {
      "country": "Czechia",
      "pop": 10561633
    },
    {
      "country": "Germany",
      "pop": 82667685
    },
    {
      "country": "Djibouti",
      "pop": 942333
    },
    {
      "country": "Dominica",
      "pop": 73543
    },
    {
      "country": "Denmark",
      "pop": 5731118
    },
    {
      "country": "Dominican Republic",
      "pop": 10648791
    },
    {
      "country": "Algeria",
      "pop": 40606052
    },
    {
      "country": "East Asia & Pacific (excluding high income)",
      "pop": 2051452657
    },
    {
      "country": "Early-demographic dividend",
      "pop": 3170542188
    },
    {
      "country": "East Asia & Pacific",
      "pop": 2296786207
    },
    {
      "country": "Europe & Central Asia (excluding high income)",
      "pop": 417424643
    },
    {
      "country": "Europe & Central Asia",
      "pop": 911995305
    },
    {
      "country": "Ecuador",
      "pop": 16385068
    },
    {
      "country": "Egypt",
      "pop": 95688681
    },
    {
      "country": "Euro area",
      "pop": 340894606
    },
    {
      "country": "Spain",
      "pop": 46443959
    },
    {
      "country": "Estonia",
      "pop": 1316481
    },
    {
      "country": "Ethiopia",
      "pop": 102403196
    },
    {
      "country": "European Union",
      "pop": 511497415
    },
    {
      "country": "Fragile and conflict affected situations",
      "pop": 496575241
    },
    {
      "country": "Finland",
      "pop": 5495096
    },
    {
      "country": "Fiji",
      "pop": 898760
    },
    {
      "country": "France",
      "pop": 66896109
    },
    {
      "country": "Faroe Islands",
      "pop": 49117
    },
    {
      "country": "Micronesia, Fed. Sts.",
      "pop": 104937
    },
    {
      "country": "Gabon",
      "pop": 1979786
    },
    {
      "country": "UK",
      "pop": 65637239
    },
    {
      "country": "Georgia",
      "pop": 3719300
    },
    {
      "country": "Ghana",
      "pop": 28206728
    },
    {
      "country": "Gibraltar",
      "pop": 34408
    },
    {
      "country": "Guinea",
      "pop": 12395924
    },
    {
      "country": "Gambia",
      "pop": 2038501
    },
    {
      "country": "Guinea-Bissau",
      "pop": 1815698
    },
    {
      "country": "Equatorial Guinea",
      "pop": 1221490
    },
    {
      "country": "Greece",
      "pop": 10746740
    },
    {
      "country": "Grenada",
      "pop": 107317
    },
    {
      "country": "Greenland",
      "pop": 56186
    },
    {
      "country": "Guatemala",
      "pop": 16582469
    },
    {
      "country": "Guam",
      "pop": 162896
    },
    {
      "country": "Guyana",
      "pop": 773303
    },
    {
      "country": "High income",
      "pop": 1190029421
    },
    {
      "country": "Hong Kong",
      "pop": 7346700
    },
    {
      "country": "Honduras",
      "pop": 9112867
    },
    {
      "country": "Heavily indebted poor countries (HIPC)",
      "pop": 744602976
    },
    {
      "country": "Croatia",
      "pop": 4170600
    },
    {
      "country": "Haiti",
      "pop": 10847334
    },
    {
      "country": "Hungary",
      "pop": 9817958
    },
    {
      "country": "IBRD only",
      "pop": 4697247117
    },
    {
      "country": "IDA & IBRD total",
      "pop": 6271593092
    },
    {
      "country": "IDA total",
      "pop": 1574345975
    },
    {
      "country": "IDA blend",
      "pop": 521159393
    },
    {
      "country": "Indonesia",
      "pop": 261115456
    },
    {
      "country": "IDA only",
      "pop": 1053186582
    },
    {
      "country": "Isle of Man",
      "pop": 83737
    },
    {
      "country": "India",
      "pop": 1324171354
    },
    {
      "country": "Ireland",
      "pop": 4773095
    },
    {
      "country": "Iran",
      "pop": 80277428
    },
    {
      "country": "Iraq",
      "pop": 37202572
    },
    {
      "country": "Iceland",
      "pop": 334252
    },
    {
      "country": "Israel",
      "pop": 8547100
    },
    {
      "country": "Italy",
      "pop": 60600590
    },
    {
      "country": "Jamaica",
      "pop": 2881355
    },
    {
      "country": "Jordan",
      "pop": 9455802
    },
    {
      "country": "Japan",
      "pop": 126994511
    },
    {
      "country": "Kazakhstan",
      "pop": 17797032
    },
    {
      "country": "Kenya",
      "pop": 48461567
    },
    {
      "country": "Kyrgyz Republic",
      "pop": 6082700
    },
    {
      "country": "Cambodia",
      "pop": 15762370
    },
    {
      "country": "Kiribati",
      "pop": 114395
    },
    {
      "country": "St. Kitts and Nevis",
      "pop": 54821
    },
    {
      "country": "S. Korea",
      "pop": 51245707
    },
    {
      "country": "Kuwait",
      "pop": 4052584
    },
    {
      "country": "Latin America & Caribbean (excluding high income)",
      "pop": 610136397
    },
    {
      "country": "Lao PDR",
      "pop": 6758353
    },
    {
      "country": "Lebanon",
      "pop": 6006668
    },
    {
      "country": "Liberia",
      "pop": 4613823
    },
    {
      "country": "Libya",
      "pop": 6293253
    },
    {
      "country": "St. Lucia",
      "pop": 178015
    },
    {
      "country": "Latin America & Caribbean",
      "pop": 637664490
    },
    {
      "country": "Least developed countries: UN classification",
      "pop": 980609415
    },
    {
      "country": "Low income",
      "pop": 659272676
    },
    {
      "country": "Liechtenstein",
      "pop": 37666
    },
    {
      "country": "Sri Lanka",
      "pop": 21203000
    },
    {
      "country": "Lower middle income",
      "pop": 3012923806
    },
    {
      "country": "Low & middle income",
      "pop": 6247922508
    },
    {
      "country": "Lesotho",
      "pop": 2203821
    },
    {
      "country": "Late-demographic dividend",
      "pop": 2262709895
    },
    {
      "country": "Lithuania",
      "pop": 2872298
    },
    {
      "country": "Luxembourg",
      "pop": 582972
    },
    {
      "country": "Latvia",
      "pop": 1960424
    },
    {
      "country": "Macao SAR, China",
      "pop": 612167
    },
    {
      "country": "St. Martin (French part)",
      "pop": 31949
    },
    {
      "country": "Morocco",
      "pop": 35276786
    },
    {
      "country": "Monaco",
      "pop": 38499
    },
    {
      "country": "Moldova",
      "pop": 3552000
    },
    {
      "country": "Madagascar",
      "pop": 24894551
    },
    {
      "country": "Maldives",
      "pop": 417492
    },
    {
      "country": "Middle East & North Africa",
      "pop": 436720722
    },
    {
      "country": "Mexico",
      "pop": 127540423
    },
    {
      "country": "Marshall Islands",
      "pop": 53066
    },
    {
      "country": "Middle income",
      "pop": 5592833481
    },
    {
      "country": "Macedonia, FYR",
      "pop": 2081206
    },
    {
      "country": "Mali",
      "pop": 17994837
    },
    {
      "country": "Malta",
      "pop": 436947
    },
    {
      "country": "Myanmar",
      "pop": 52885223
    },
    {
      "country": "Middle East & North Africa (excluding high income)",
      "pop": 373719055
    },
    {
      "country": "Montenegro",
      "pop": 622781
    },
    {
      "country": "Mongolia",
      "pop": 3027398
    },
    {
      "country": "Northern Mariana Islands",
      "pop": 55023
    },
    {
      "country": "Mozambique",
      "pop": 28829476
    },
    {
      "country": "Mauritania",
      "pop": 4301018
    },
    {
      "country": "Mauritius",
      "pop": 1263473
    },
    {
      "country": "Malawi",
      "pop": 18091575
    },
    {
      "country": "Malaysia",
      "pop": 31187265
    },
    {
      "country": "North America",
      "pop": 359479269
    },
    {
      "country": "Namibia",
      "pop": 2479713
    },
    {
      "country": "New Caledonia",
      "pop": 278000
    },
    {
      "country": "Niger",
      "pop": 20672987
    },
    {
      "country": "Nigeria",
      "pop": 185989640
    },
    {
      "country": "Nicaragua",
      "pop": 6149928
    },
    {
      "country": "Netherlands",
      "pop": 17018408
    },
    {
      "country": "Norway",
      "pop": 5232929
    },
    {
      "country": "Nepal",
      "pop": 28982771
    },
    {
      "country": "Nauru",
      "pop": 13049
    },
    {
      "country": "New Zealand",
      "pop": 4692700
    },
    {
      "country": "OECD members",
      "pop": 1289937319
    },
    {
      "country": "Oman",
      "pop": 4424762
    },
    {
      "country": "Pakistan",
      "pop": 193203476
    },
    {
      "country": "Panama",
      "pop": 4034119
    },
    {
      "country": "Peru",
      "pop": 31773839
    },
    {
      "country": "Philippines",
      "pop": 103320222
    },
    {
      "country": "Palau",
      "pop": 21503
    },
    {
      "country": "Papua New Guinea",
      "pop": 8084991
    },
    {
      "country": "Poland",
      "pop": 37948016
    },
    {
      "country": "Pre-demographic dividend",
      "pop": 879292453
    },
    {
      "country": "Puerto Rico",
      "pop": 3411307
    },
    {
      "country": "Korea, Dem. People’s Rep.",
      "pop": 25368620
    },
    {
      "country": "Portugal",
      "pop": 10324611
    },
    {
      "country": "Paraguay",
      "pop": 6725308
    },
    {
      "country": "West Bank and Gaza",
      "pop": 4551566
    },
    {
      "country": "Pacific island small states",
      "pop": 2388875
    },
    {
      "country": "Post-demographic dividend",
      "pop": 1102730983
    },
    {
      "country": "French Polynesia",
      "pop": 280208
    },
    {
      "country": "Qatar",
      "pop": 2569804
    },
    {
      "country": "Romania",
      "pop": 19705301
    },
    {
      "country": "Russia",
      "pop": 144342396
    },
    {
      "country": "Rwanda",
      "pop": 11917508
    },
    {
      "country": "South Asia",
      "pop": 1766383450
    },
    {
      "country": "Saudi Arabia",
      "pop": 32275687
    },
    {
      "country": "Sudan",
      "pop": 39578828
    },
    {
      "country": "Senegal",
      "pop": 15411614
    },
    {
      "country": "Singapore",
      "pop": 5607283
    },
    {
      "country": "Solomon Islands",
      "pop": 599419
    },
    {
      "country": "Sierra Leone",
      "pop": 7396190
    },
    {
      "country": "El Salvador",
      "pop": 6344722
    },
    {
      "country": "San Marino",
      "pop": 33203
    },
    {
      "country": "Somalia",
      "pop": 14317996
    },
    {
      "country": "Serbia",
      "pop": 7057412
    },
    {
      "country": "Sub-Saharan Africa (excluding high income)",
      "pop": 1033011458
    },
    {
      "country": "South Sudan",
      "pop": 12230730
    },
    {
      "country": "Sub-Saharan Africa",
      "pop": 1033106135
    },
    {
      "country": "Small states",
      "pop": 39618156
    },
    {
      "country": "Sao Tome and Principe",
      "pop": 199910
    },
    {
      "country": "Suriname",
      "pop": 558368
    },
    {
      "country": "Slovakia",
      "pop": 5428704
    },
    {
      "country": "Slovenia",
      "pop": 2064845
    },
    {
      "country": "Sweden",
      "pop": 9903122
    },
    {
      "country": "Swaziland",
      "pop": 1343098
    },
    {
      "country": "Sint Maarten (Dutch part)",
      "pop": 40005
    },
    {
      "country": "Seychelles",
      "pop": 94677
    },
    {
      "country": "Syria",
      "pop": 18430453
    },
    {
      "country": "Turks and Caicos Islands",
      "pop": 34900
    },
    {
      "country": "Chad",
      "pop": 14452543
    },
    {
      "country": "East Asia & Pacific (IDA & IBRD countries)",
      "pop": 2026028438
    },
    {
      "country": "Europe & Central Asia (IDA & IBRD countries)",
      "pop": 455372659
    },
    {
      "country": "Togo",
      "pop": 7606374
    },
    {
      "country": "Thailand",
      "pop": 68863514
    },
    {
      "country": "Taiwan",
      "pop": 23780000
    },
    {
      "country": "Tajikistan",
      "pop": 8734951
    },
    {
      "country": "Turkmenistan",
      "pop": 5662544
    },
    {
      "country": "Timor-Leste",
      "pop": 1268671
    },
    {
      "country": "Middle East & North Africa (IDA & IBRD countries)",
      "pop": 369167489
    },
    {
      "country": "Tonga",
      "pop": 107122
    },
    {
      "country": "South Asia (IDA & IBRD)",
      "pop": 1766383450
    },
    {
      "country": "Sub-Saharan Africa (IDA & IBRD countries)",
      "pop": 1033106135
    },
    {
      "country": "Trinidad and Tobago",
      "pop": 1364962
    },
    {
      "country": "Tunisia",
      "pop": 11403248
    },
    {
      "country": "Turkey",
      "pop": 79512426
    },
    {
      "country": "Tuvalu",
      "pop": 11097
    },
    {
      "country": "Tanzania",
      "pop": 55572201
    },
    {
      "country": "Uganda",
      "pop": 41487965
    },
    {
      "country": "Ukraine",
      "pop": 45004645
    },
    {
      "country": "Upper middle income",
      "pop": 2579909675
    },
    {
      "country": "Uruguay",
      "pop": 3444006
    },
    {
      "country": "USA",
      "pop": 323127513
    },
    {
      "country": "Uzbekistan",
      "pop": 31848200
    },
    {
      "country": "St. Vincent and the Grenadines",
      "pop": 109643
    },
    {
      "country": "Venezuela",
      "pop": 31568179
    },
    {
      "country": "British Virgin Islands",
      "pop": 30661
    },
    {
      "country": "Virgin Islands (U.S.)",
      "pop": 102951
    },
    {
      "country": "Vietnam",
      "pop": 92701100
    },
    {
      "country": "Vanuatu",
      "pop": 270402
    },
    {
      "country": "World",
      "pop": 7442135578
    },
    {
      "country": "Samoa",
      "pop": 195125
    },
    {
      "country": "Kosovo",
      "pop": 1816200
    },
    {
      "country": "Yemen, Rep.",
      "pop": 27584213
    },
    {
      "country": "South Africa",
      "pop": 55908865
    },
    {
      "country": "Zambia",
      "pop": 16591390
    },
    {
      "country": "Zimbabwe",
      "pop": 16150362
    }
  ]

  has_many :covid_dailies

  def percent_infected
    if self.population
      (self.covid_dailies.most_recent.total_cases.to_f / self.population * 100).round(4)
    else
      "Insufficient data"
    end
  end

  def percent_dead
    if self.population
      (self.covid_dailies.most_recent.total_deaths.to_f / self.population * 100).round(4)
    else
      "Insufficient data"
    end
  end

  def mortality_rate
    self.covid_dailies.most_recent.mortality_rate
  end

  def growth_rate(x = 7)
    span = self.covid_dailies.most_recent(7)
    finish = span.first.total_cases
    start = span.last.total_cases
    rate = (((finish.to_f - start)/start) * 100).round(4) if start & finish
    rate ||= "Insufficient Data"
  end
end
