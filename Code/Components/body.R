################################################################################
# body.R
#
# Create the body for the ui.
################################################################################

library(shinydashboard)
library(plotly)
library(DT)
library(shinyjs)

body <- dashboardBody(
  tags$head(tags$style(
    HTML("div.box-header {text-align: center;}
         .skin-black .main-sidebar {background-color: #0B2C4B;}
    .myClass {font-size: 14px; text-align: right; margin-top: 17px; margin-right: 20px;}")
  )),
  tags$script(
    HTML(
      '$(document).ready(function() {
$("header").find("nav").append(\'<div id="dateHeader" class="myClass"></div>\');
})'
    )
  ),
  tabItems(
    tabItem(tabName = "overview",
            fluidRow(
              box(
                title = HTML("Surveillance of COVID-19 in Patients Presenting with Febrile Illness<br>in Nakhon Phanom and Tak Provinces, Thailand (COVID Fever)"),
                width = 12,
                div(
                  style = "text-align: center; font-size: 20px",
                  h4("Objectives")
                ),
                HTML("<ul><li>Detect and describe the proportion, clinical characteristics, risk factors of SARS-CoV-2 infection among febrile patients without respiratory symptoms </li>
                          <li>Assess knowledge, attitudes, and practices (KAP) among febrile patients to better understand health seeking behavior, and potential barriers to care</li>
                          <li>Determine the utility of saliva and anterior nasal swabs as suitable specimens compared to nasopharyngeal swab + oropharyngeal swab for the detection of SARS-CoV-2 RNA.</li>
                          <li>Determine if a pooled PCR testing strategy is cost-effective </li>
                          <li>Assess clinical and laboratory characteristics, including temporal patterns of antibody response, and outcomes among patients hospitalized with COVID-19.</li>
                          <li>Determine the seroprevalence of antibodies against SARS-CoV-2 in febrile patients </li>
                
                     </ul>")
              ),
              box(
                title = "Study Sites",
                width = 12,
                plotOutput("map", height = 455)
              ),
              box(
                title = "Methods",
                width = 12,
                div(
                  style = "text-align: left; font-size: 20px; font-weight: bold",
                  h5("Study population:")
                ),
                HTML("<ul> <li>Prospective enroll febrile patients aged >2 years old, presenting to OPDs or ERs</li>
                          <li>Expected 8,500 cases within 2-3 years</li>
 
                     </ul>"),
                div(
                  style = "text-align: left; font-size: 20px; font-weight: bold",
                  h5("Inclusion criteria:")
                ),
                HTML("<ul> <li>Fever >37.5 &deg;C or history of fever  <14 days AND </li>
                            <li>No clinical signs or symptoms of respiratory infection  (no cough, difficulty breathing or sputum production)</li>
 
                     </ul>"),
                div(
                  style = "text-align: left; font-size: 20px; font-weight: bold",
                  h5("Exclusion criteria:")
                ),
                HTML("<ul> <li>Known COVID-19 infection within the past 30 days or</li>
                        <li>Fever >14 days or</li>
                        <li>Present to OPDs or ERs with trauma or accident</li>
                        <li>Not willing to participate or cannot communicate</li>
                     </ul>"),
                div(
                  style = "text-align: left; font-size: 20px; font-weight: bold",
                  h5("Data collection:")
                ),
                HTML("<ul> <li>Interview: clinical, risk factors, knowledge/attitude/practice (KAP), vaccination </li>
                        <li>Review medical record: clinical, laboratory, treatment, outcome</li>
                    </ul>"),
                div(
                  style = "text-align: left; font-size: 20px; font-weight: bold",
                  h5("Specimen collection and laboratory testing:")
                ),
                HTML("
              <style>
              table {
              font-family: Arial;
              background-color: #F5F5F5;
              border: 1px solid #1C6EA4; border-collapse: collapse;
              margin-left:auto; margin-right:auto;
              }
              table td {
              border: 1px solid #AAAAAA;
              padding: 5px 5px;
              }
              </style>
              <table>
              <tbody>
              <tr>
              <td rowspan='2'><span>&nbsp;</span></td>
              <td colspan='4'><div style='text-align:center;'>Specimen Collection</div></td>
              </tr>
              <tr>
              <td><div style='text-align:center; width:80pt;'>NP+OP swab</div></td>
              <td><div style='text-align:center; width:80pt;'>Nasal Swab</div></td>
              <td><div style='text-align:center; width:80pt;'>Saliva</div></td>
              <td><div style='text-align:center; width:80pt;'>Blood</div></td>
              </tr>
              <tr>
              <td>All enrollees at enrollment</td>
              <td><div style='text-align:center; color: green'><span>&#10004;</span></div></td>
              <td><div style='text-align:center; color: green'><span>&#10004;</span></div></td>
              <td><div style='text-align:center; color: green'><span>&#10004;</span></div></td>
              <td><div style='text-align:center; color: red'><span>&#10008;</span></div></td>
              </tr>
              <tr>
              <td>5<sup>th</sup> enrollees</td>
              <td><div style='text-align:center; color: green'><span>&#10004;</span></div></td>
              <td><div style='text-align:center; color: green'><span>&#10004;</span></div></td>
              <td><div style='text-align:center; color: green'><span>&#10004;</span></div></td>
              <td><div style='text-align:center; color: green'><span>&#10004;</span></div></td>
              </tr>
              </tbody>
              </table>
              "),
                div(
                  style = "text-align:center; display:block;",
                  img(src = "CollectMethod2.jpg" ,alt="Collect Method", height = "100", width = "600")
                )
                 
              )
            )),
    tabItem(tabName = "screen",
            fluidRow(
              box(
                title = "Number Screened by Month",
                width = 12,
                align="center",
                plotlyOutput("ScreeningBar", height = 375),
                radioButtons("screenx",
                             label = "",
                             inline = TRUE,
                             choices = list("Weekly" = 1, "Monthly" = 2), 
                             selected = 2)
              )
            ),
            fluidRow(
              column(
                width = 6,
                box(
                  title = "Age",
                  width = NULL,
                  dataTableOutput("ScreeningAge"),
               
                  plotlyOutput("ScreeningAgeGroup", height = 325)
                )
              ),
              column(
                width = 6,
                box(
                  title = "Gender",
                  width = NULL,
                  plotlyOutput("ScreeningGender")
                
                )
              )
            )
    ),
    tabItem(
      tabName = "enrol",
      fluidRow(
        column(
          width = 10,
          box(
            title = "Eligible, Enrollment and SARS-Cov2 Incidence by Month",
            width = NULL,
            align="center",
            plotlyOutput("EnrollmentBar", height = 375),
            radioButtons("enrollx", 
                         label = "",
                         inline = TRUE,
                         choices = list("Weekly" = 1, "Monthly" = 2), 
                         selected = 2)
          )
        ),
        column(
          width = 2,
          tags$head(tags$style(HTML('
            .small-box.bg-blue { background-color: #a1caf1 !important; color: #000000 !important}
            .small-box.bg-green { background-color: #ace1af !important; color: #000000 !important}
            .small-box.bg-orange { background-color: #B78F62 !important; color: #000000 !important}
            .small-box.bg-yellow { background-color: #f8de7e !important; color: #000000 !important}
          '))),
          valueBoxOutput("eliBox", width = NULL),
          valueBoxOutput("enrolBox", width = NULL),
          valueBoxOutput("posBox", width = NULL),
          valueBoxOutput("pos3weekBox", width = NULL)
        )
      ),
      fluidRow(
        box(
          title = "Age Group",
          width = 4,
          plotlyOutput("EnrollmentAge", height = 270)
        ),
        box(
          title = "Gender",
          width = 4,
          plotlyOutput("EnrollmentGender", height = 270)
        ),
        box(
          title = "Occupation",
          width = 4,
          plotlyOutput("EnrollmentOcc", height = 270)
        )
      ),
    ),
    tabItem(tabName = "diag",
            fluidRow(box(
              title = "Diagnosis at OPD/ER", 
              width = 12,
              plotlyOutput("Diag", height = 766)
            ))),
    tabItem(
      tabName = "sign",
      fluidRow(
        # tags$head(tags$style(HTML('
        #     .small-box {height: 70px}
        #   '))),
        valueBoxOutput("posBoxSign", width = 3),
        valueBoxOutput("hospitalised", width = 3),
        valueBoxOutput("intub", width = 3),
        valueBoxOutput("death", width = 3)
      ),
      box(
        title = "Clinical Signs and Symptoms among Febrile Patients",
        width = NULL,
        plotlyOutput("Sign", height = 612)
      )
    ), 
    tabItem(
      tabName = "underlying",
      fluidRow(
        box(
          title = "Underlying Condition Among Febrile Patients",
          width = 12,
          plotlyOutput("Underly", height = 475)
        )
      )
    ),
    tabItem(tabName = "risk",
      fluidRow(
        box(
          title = "Risk Factors Within Past 14 Days among Febrile Patients  ",
          width = 12,
          plotlyOutput("Risk", height = 475)
        )
      )
    ),
    tabItem(tabName = "vac",
      fluidRow(
        box(
          title = "COVID-19 Vaccination and PCR Result",
          width = 12,
          plotlyOutput("VaccineSunburst")
        )
        # ),
        # box(
        #   title = "COVID-19 Vaccination vs. PCR Results",
        #   width = 8,
        #   plotlyOutput("VaccinePie2")
        # )
      )
    ),
    tabItem(tabName = "atk",
            fluidRow(box(
              title = "Antigen Test Kits (ATK) Used within Past 30 Days among Febrile Patients",
              width = 12,
              plotlyOutput("atkPie")
            ))),
    tabItem(
      tabName = "detect",
        fluidRow(
          box(
            title = "SARS-CoV-2 Detection by Sample Type", 
            width = 6,
            plotlyOutput("DetectBar")
          ),
          box(
            title = "% PCR Positive by Sample Type",
            width = 6,
            plotlyOutput("DetectPie")
          )
        )
    ),
    tabItem(tabName = "sero",
            fluidRow(box(
              title = "Serology Testing Among Febrile Patient", 
              width = 12,
              ""
            ))),
    tabItem(tabName = "KAP",
            fluidRow(
              box(
                title = "Knowledge, Attitude and Practices",
                width = 12,
                div(
                  style = "text-align: center; font-size: 20px",
                  textOutput("titletext")
                ),
                plotlyOutput("kap1", height = 360),
                plotlyOutput("kap2", height = 232)
              )
            ))
  ),
  useShinyjs()
)
