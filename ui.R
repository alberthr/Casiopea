## ui.R ##
library(shinydashboard)

dashboardPage(skin = "red",
  dashboardHeader(title = "CASIOPEA"),
  
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Mapa de Correspondencias", tabName = "tabCorrespondencias", icon = icon("spinner")),
      menuItem("Consumo de Medios", tabName = "medios", icon = icon("th"))
    )
  ),
  
  dashboardBody(
    tabItems(


      # TAB MAPA DE CORRESPONDENCIAS
      tabItem(tabName = "tabCorrespondencias",
              fluidRow(
                box(width = 3,
                    title = "Carga de datos", 
                    status = "primary", 
                    solidHeader = TRUE,
                    collapsible = FALSE,
                    fileInput('file1', 'Importar Fichero de datos',accept=c(".xls",".xlsx"))
                ),
                
                box(width = 9,
                    title = "Mapa de Correspondencias", 
                    status = "primary", 
                    solidHeader = TRUE,
                    collapsible = FALSE,
                    plotOutput("correspondencias", height = 600)
                )
              )
      ),

      # TAB PERFIL SOCIODEMOGRAFICOS
      tabItem(tabName = "medios",
              fluidRow(
                box(width = 12,
                    title = "Histogram", 
                    status = "primary", 
                    solidHeader = TRUE,
                    collapsible = FALSE,
                    plotOutput("sociodemografico", height = 600))
              )
      )
      
      
    )
  )
)