## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ggfourfold)
library(ggplot2)

## ----berkeley-----------------------------------------------------------------
ucb <- as.data.frame(UCBAdmissions)
berkeley <- ggplot(ucb, aes(x = Admit, y = Gender, weight = Freq)) +
  theme_fourfold()

## ----berkeley-raw, fig.width = 4, fig.height = 4------------------------------
berkeley + geom_fourfold(std = "ind.max")

## ----berkeley-rows, fig.width = 4, fig.height = 4-----------------------------
berkeley + geom_fourfold(margin = 1)

## ----berkeley-std, fig.width = 4, fig.height = 4------------------------------
berkeley + geom_fourfold()

## ----berkeley-dept, fig.width = 7, fig.height = 5-----------------------------
berkeley +
  geom_fourfold() +
  facet_wrap(vars(Dept), ncol = 3, labeller = label_both)

## ----berkeley-square, fig.width = 7, fig.height = 5---------------------------
berkeley +
  geom_fourfold(shape = "square") +
  facet_wrap(vars(Dept), ncol = 3, labeller = label_both)

## ----berkeley-square-outside, fig.width = 7, fig.height = 5-------------------
berkeley +
  geom_fourfold(shape = "square", counts = "outside") +
  facet_wrap(vars(Dept), ncol = 3, labeller = label_both)

## ----berkeley-simple, fig.width = 7, fig.height = 5---------------------------
berkeley +
  geom_fourfold(extended = FALSE) +
  facet_wrap(vars(Dept), ncol = 3, labeller = label_both)

## ----ff-palette---------------------------------------------------------------
fourfold_palette()

## ----berkeley-okabe-ito, fig.width = 7, fig.height = 5------------------------
okabe_ito <- c(
  "#56B4E9", "#0072B2", # extended = FALSE: sky blue, blue
  "#F2CF7F", "#AAD9F3", # not significant: orange, sky blue (lightened)
  "#D55E00", "#0072B2"  # significant: vermilion, blue
)

berkeley +
  geom_fourfold(palette = okabe_ito) +
  facet_wrap(vars(Dept), ncol = 3, labeller = label_both)

## ----berkeley-okabe-ito-builtin, eval = FALSE---------------------------------
# berkeley +
#   geom_fourfold(palette = fourfold_palette("okabe-ito")) +
#   facet_wrap(vars(Dept), ncol = 3, labeller = label_both)

## ----berkeley-diagonal, fig.width = 5, fig.height = 5-------------------------
berkeley +
  geom_fourfold(
    diagonal.length = 0.05,
    diagonal.fill = "limegreen",
    diagonal.width = 1.5,
    color = "grey30"
  )

## ----berkeley-finished, fig.width = 7, fig.height = 5.8-----------------------
applicants <- margin.table(UCBAdmissions, 3)
dept_labels <- sprintf("%s (n = %d)", names(applicants), applicants)
names(dept_labels) <- names(applicants)

ggplot(ucb, aes(x = Admit, y = Gender, weight = Freq)) +
  geom_fourfold() +
  facet_wrap(vars(Dept), ncol = 3, labeller = labeller(Dept = dept_labels)) +
  labs(
    title = "UC Berkeley Admissions, 1973",
    subtitle = "Only department A shows a significant association",
    caption = "Data from Bickel et al. (1975)"
  ) +
  theme_fourfold(base_family = "serif") +
  theme(
    plot.title.position = "plot",
    plot.title = element_text(hjust = 0),
    plot.subtitle = element_text(
      hjust = 0,
      color = "grey30",
      margin = margin(b = 10)
    ),
    plot.caption = element_text(
      hjust = 1,
      color = "grey30",
      size = rel(0.8),
      margin = margin(t = 10)
    )
  )

