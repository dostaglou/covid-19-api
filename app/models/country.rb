class Country < ApplicationRecord

  # As of April 4th
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

  has_many :covid_dailies
end
