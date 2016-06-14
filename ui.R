## ui.R ##
library(shinydashboard)
library(shinyjs)

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
                column(width = 3,
                       box(
                         title = "Carga de datos", 
                         width = NULL,
                         status = "primary", 
                         solidHeader = TRUE,
                         collapsible = TRUE,
                         collapsed = FALSE,
                         fileInput('file1', 'Importar Fichero de datos',accept=c(".xls",".xlsx"))
                       ),
                       
                       box(
                         title = "Elementos Principales", 
                         width = NULL,
                         status = "primary", 
                         solidHeader = TRUE,
                         collapsible = TRUE,
                         collapsed = TRUE,
                         selectInput("tema", label = NULL, choices = list("Tema Gris" = 1, "Tema Claro" = 2, "Solo Grafico en Blanco" = 3), selected = 1),
                         selectInput("bolatexto", label = NULL, choices = list("Mostrar Bolas y Etiquetas" = 1, "Mostrar Solo Etiquetas" = 2, "Mostrar Solo Bolas" = 3), selected = 1)
                       ),
                       
                       box(
                         title = "Tamaños", 
                         width = NULL,
                         status = "primary", 
                         solidHeader = TRUE,
                         collapsible = TRUE,
                         collapsed = TRUE,
                         sliderInput("tm_texto", label ="Etiquetas", min = 10, max = 100, value = 40),
                         sliderInput("tm_bola", label ="Bolas", min = 10, max = 100, value = 20)
                       ),
                       
                       box(
                         title = "Etiquetas", 
                         width = NULL,
                         status = "primary", 
                         solidHeader = TRUE,
                         collapsible = TRUE,
                         collapsed = TRUE,
                         checkboxInput("lineabt", label = "Linea Bola-Texto", value = TRUE),
                         checkboxInput("enetiqueta", label = "Envolver Texto", value = FALSE),
                         sliderInput("separacion", label ="Fuerza de Separacion", min = 0, max = 100, value = 25)
                       ),
                       
                       box(
                         title = "Colores", 
                         width = NULL,
                         status = "primary", 
                         solidHeader = TRUE,
                         collapsible = TRUE,
                         collapsed = TRUE,
                         colourInput("col1", "Colores", value = "#D11919", showColour = "background"),
                         colourInput("col2", label=NULL, value = "#676767", showColour = "background")
                       )
                ),
                
                column(width = 9,
                       box(
                         title = "Mapa de Correspondencias", 
                         width = NULL,
                         status = "primary", 
                         solidHeader = TRUE,
                         collapsible = FALSE,
                         plotOutput("correspondencias", height = 500)
                       )
                )
              )
      )
    )
  )
)