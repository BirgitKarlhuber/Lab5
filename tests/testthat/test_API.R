

test_that("function rejects errounous input", {
  expect_error(request_data <- request_API("v3","world-2","geo","2016-01-01","fi"))
  expect_error(request_data <- request_API("v2","at-3","geo","2016-01-01","fi"))
  expect_error(request_data <- request_API("v2","at-3","gee","2016-01-01","fi"))
  expect_error(request_data <- request_API("v2","at-3","geo","01-01-2016","fi"))
  expect_error(request_data <- request_API("v2","at-3","geo","2016-01-01","tt"))
})


test_that("outputs are correct", {
  expect_equal(request_API("v2","world-2","geo","2016-01-01","fi")$id[1:5],
               c("114","115","117","120","123"))
  expect_equal(length(request_API("v2","ch-8","geo","2016-01-01","de")$id), 2310)
})


test_that("Downloading a big query works", {
  # expect_xx(request_data <- request_API("v2","at-3","geo","2016-01-01","fi"))

})


